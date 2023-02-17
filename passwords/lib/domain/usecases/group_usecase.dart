import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/group.dart';
import '../repositories/repositories_all.dart';

class GroupUser extends UseCase<List<Group>, Params> {
  final GroupRepository repository;
  GroupUser({required this.repository});

  @override
  Future<Either<Failure, List<Group>>> call(Params params) async {
    return await repository.groupList();
  }
  Future<Either<Failure, List<Group>>> getGroups() async {
    return await repository.groupList();
  }
  Future<Either<Failure, List<Group>>> insertGroup(Params params) async {
    Group group = params.group;
    return await repository.insertGroup(group);
  }
  Future<Either<Failure, List<Group>>> deleteGroup(Params params) async {
    int id = params.id;
    return await repository.deleteGroup(id);
  }
  Future<Either<Failure, List<Group>>> updateGroup(Params params) async {
    Group group = params.group;
    return await repository.updateGroup(group);
  }
}
