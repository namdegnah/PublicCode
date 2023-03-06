import '../../domain/entities/current_season.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/match.dart';
import '../../domain/entities/best_team.dart';
import '../datasources/data_sources.dart';

class HttpRepositoryImp extends HttpRepository{
  final AppDataSource dataSource;
  HttpRepositoryImp({required this.dataSource});  
  

  @override
  Future<Either<Failure, List<Match>>> getFootballJson(String dateFrom, String dateTo) async {
    try{
      final data = await dataSource.getFootballJson(dateFrom, dateTo);
      return Right(data);

    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  @override
  Future<Either<Failure, BestTeam>> getBestTeam(int id) async {
    try{
      final data = await dataSource.getBestTeam(id);
      return Right(data);

    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  @override
  Future<Either<Failure, CurrentSeason>> getCurrentSeason() async {
    try{
      final data = await dataSource.getCurrentSeason();
      return Right(data);

    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }          
}