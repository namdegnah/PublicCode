import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/repositories_all.dart';
import '../../data/models/data_set.dart';

class SetupUser extends UseCase<DataSet, Params> {
  final SetupRepository repository;
  SetupUser({required this.repository});

  @override
  Future<Either<Failure, DataSet>> call(Params params) async {
    return await repository.setUpData();
  }
  Future<Either<Failure, DataSet>> setUpDataSet() async {
    return await repository.setUpData();
  }
}