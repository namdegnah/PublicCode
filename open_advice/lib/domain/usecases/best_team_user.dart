import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/best_team.dart';
import '../repositories/repositories_all.dart';


class BestTeamUser extends UseCase<BestTeam, Params> {

  
  final HttpRepository repository;
  BestTeamUser({required this.repository});

  @override
  Future<Either<Failure, BestTeam>> call(Params params) async {
    
    var bestTeamResult = await repository.getBestTeam(params.id);

    bestTeamResult.fold(
      (failure) {
        return Left(failure);
      },
      (bestTeam) => Right(bestTeam),       
    );              
    return bestTeamResult;
  }

}
