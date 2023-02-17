import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/password.dart';
import '../repositories/repositories_all.dart';

class PasswordUser extends UseCase<List<Password>, Params> {
  final PasswordRepository repository;
  PasswordUser({required this.repository});

  @override
  Future<Either<Failure, List<Password>>> call(Params params) async {
    return await repository.passwordList(groupId: -1, typeId: -1);
  }
  Future<Either<Failure, List<Password>>> getPasswords() async {
    return await repository.passwordList(groupId: -1, typeId: -1);
  }
  Future<Either<Failure, List<Password>>> getAllPasswords() async {
    return await repository.passwordAllList();
  }  
  Future<Either<Failure, List<Password>>> insertPassword(Params params) async {
    Password password = params.password;
    return await repository.insertPassword(password);
  }
  Future<Either<Failure, List<Password>>> deletePassword(Params params) async {
    int id = params.id;
    return await repository.deletePassword(id);
  }
  Future<Either<Failure, List<Password>>> updatePassword(Params params) async {
    Password password = params.password;
    return await repository.updatePassword(password);
  }
}
