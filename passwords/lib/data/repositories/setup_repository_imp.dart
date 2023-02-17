import 'package:dartz/dartz.dart';
import '../datasources/data_sources.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../domain/entities/password_field.dart';
import '../../domain/entities/type.dart';
import '../models/password_fields.dart';
import '../../data/models/data_set.dart';
import '../../presentation/config/injection_container.dart';

class SetupRepositoryImp extends SetupRepository {

  final AppDataSource dataSource;
  SetupRepositoryImp({required this.dataSource}); 

  @override
  Future<Either<Failure, DataSet>> setUpData() async {
    return await _getAllDataAndProces();
  }
  Future<Either<Failure, DataSet>> _getAllDataAndProces() async {
    
    DataSet dataSet = DataSet();
    dataSet.passwordFields = passwordFields;

    final passwords = await sl<PasswordRepository>().passwordList(groupId: -1, typeId: -1);
    passwords.fold(
      (failure) => throw failure,
      (list) => dataSet.passwords = list,
    );
    final types = await sl<TypeRepository>().typeList();
    types.fold(
      (failure) => throw failure,
      (list) => dataSet.types = list,
    );
    final groups = await sl<GroupRepository>().groupList();
    groups.fold(
      (failure) => throw failure,
      (list) => dataSet.groups = list,
    );
    dataSet.types!.setTypeFields();
    return Right(dataSet);
  }       
}