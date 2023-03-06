import '../../domain/entities/match.dart';
import '../../domain/entities/best_team.dart';
import '../../domain/entities/current_season.dart';

abstract class AppDataSource{
  
  Future<List<Match>> getFootballJson(String dateFrom, String dateTo); 
  Future<BestTeam> getBestTeam(int id);
  Future<CurrentSeason> getCurrentSeason();
}
