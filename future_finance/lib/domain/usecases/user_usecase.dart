import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/repositories_all.dart';

class UserUser extends UseCase<List<User>, Params> {
  final UserRepository repository;
  UserUser({required this.repository});

  @override
  Future<Either<Failure, List<User>>> call(Params params) async {
    return await repository.userList();
  }

  Future<Either<Failure, List<User>>> getUsers() async {
    return await repository.userList();
  }

  Future<Either<Failure, List<User>>> insertUser(Params params) async {
    User user = params.user!;
    return await repository.insertUser(user);
  }

  Future<Either<Failure, List<User>>> deleteUser(Params params) async {
    int id = params.id!;
    return await repository.deleteUser(id);
  }

  Future<Either<Failure, List<User>>> updateUser(Params params) async {
    User user = params.user!;
    return await repository.updateUser(user);
  }

  Future<Either<Failure, User>> user(Params params) async {
    int id = params.id!;
    return await repository.user(id);
  }
}
