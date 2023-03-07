import '../../domain/entities/best_team.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import 'extensions.dart';
import '../entities/match.dart';
import '../entities/team.dart';
import '../repositories/repositories_all.dart';
import '../entities/current_season.dart';
import '../../core/util/date_time_extension.dart';
import 'package:intl/intl.dart';

class MatchesUser extends UseCase<BestTeam, Params> {

  final HttpRepository repository;
  
  MatchesUser({required this.repository});
  DateFormat footballFormat = DateFormat('yyyy-MM-dd');

  @override
  Future<Either<Failure, BestTeam>> call(Params params) async {
    try{
      CurrentSeason? currentSeason;
      late List<Match> listMatch;
      DateTime now = DateTime.now();
      
      var currentSeasonEither = await repository.getCurrentSeason();
      currentSeasonEither.fold(
        (failure) {
          return Left(failure);
        },
        (season) => currentSeason = season,      
      );
      if(currentSeason != null){
        DateTime seasonEndDate = DateTime.parse(currentSeason!.endDate);
        if(now.isAfter(seasonEndDate)) now = seasonEndDate;        
      }
      DateTime thirtyBefore = now.lessDays(30);
      var matchesEither = await repository.getFootballJson(footballFormat.format(thirtyBefore), footballFormat.format(now));

      matchesEither.fold(
        (failure) {
          return Left(failure);
        },
        (list) => listMatch = list,       
      );        
        
      return matchList(listMatch);
    } on Exception catch(error) {
      return Left(UseCaseFailure(error.toString()));
    }
  }
  Future<Either<Failure, BestTeam>> matchList(List<Match> data) async {
    late final Team bestTeam;
    late final int bestTeamId;    
    List<Team> winners  = [];   
    Team? team;
    try{
      for(var match in data){
        if(match.score.fullTime.home >= 0 && match.score.fullTime.away >= 0){
          team = winner(match);
          if(team != null){
            winners.add(team);
          } 
        }
      }
      winners.sort((a, b) => a.name.compareTo(b.name));
      int max = winners.getMaxCount();
      int maxValues = winners.getCountOfMaxValue(max);
      bestTeam = winners.getValueOfMax(maxValues, max);
      bestTeamId = bestTeam.id;
      late BestTeam bt;
      var bestTeamResult = await repository.getBestTeam(bestTeamId);
      bestTeamResult.fold(
        (failure) {
          return Left(failure);
        },
        (bestTeam) => bt = bestTeam,      
      );
      bt.originalId = bestTeamId;
      return Right(bt);
    } on Exception catch(error){
      return Left(UseCaseFailure(error.toString()));
    }
  }
  Team? winner(Match match){
    if(match.score.winner == 'HOME_TEAM') return Team(id: match.homeTeam.id, name: match.homeTeam.name);
    if(match.score.winner == 'AWAY_TEAM') return Team(id: match.awayTeam.id, name: match.awayTeam.name);
    return null;
  }  
}
