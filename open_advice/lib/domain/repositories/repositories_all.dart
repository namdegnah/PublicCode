import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/match.dart';
import '../entities/best_team.dart';
import '../entities/current_season.dart';

abstract class HttpRepository{

  Future<Either<Failure, List<Match>>> getFootballJson(String dateFrom, String dateTo);
  Future<Either<Failure, BestTeam>> getBestTeam(int id); 
  Future<Either<Failure, CurrentSeason>> getCurrentSeason();    
}
