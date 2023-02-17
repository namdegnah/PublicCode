import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/group.dart';
import '../entities/type.dart';
import '../entities/password.dart';
import '../../data/models/data_set.dart';

abstract class GroupRepository{
  Future<Either<Failure, List<Group>>> insertGroup(Group group);
  Future<Either<Failure, List<Group>>> groupList();
  Future<Either<Failure, List<Group>>> deleteGroup(int id);
  Future<Either<Failure, List<Group>>> updateGroup(Group group);
}
abstract class TypeRepository{
  Future<Either<Failure, List<Type>>> insertType(Type type);
  Future<Either<Failure, List<Type>>> typeList();
  Future<Either<Failure, List<Type>>> deleteType(Type type);
  Future<Either<Failure, List<Type>>> updateType(Type type);
  Future<Either<Failure, List<Type>>> insertTypeField(Type type);
}
abstract class PasswordRepository{
  Future<Either<Failure, List<Password>>> passwordList({required int groupId, required int typeId});
  Future<Either<Failure, List<Password>>> passwordAllList();
  Future<Either<Failure, List<Password>>> updatePassword(Password password);
  Future<Either<Failure, List<Password>>> insertPassword(Password password);
  Future<Either<Failure, List<Password>>> deletePassword(int id);
}
abstract class SetupRepository{
  Future<Either<Failure, DataSet>> setUpData();
}
