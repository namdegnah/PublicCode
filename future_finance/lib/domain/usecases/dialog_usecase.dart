import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/repositories_all.dart';
import '../../data/models/dialog_base.dart';

class DialogUser extends UseCase<DialogBase, Params>{
  final DialogRepository repository;
  DialogUser({required this.repository});

  Future<Either<Failure, DialogBase>> call(Params params) async {
    return await repository.dialogFull();
  }  
  Future<Either<Failure, DialogBase>> dialogRecurrences() async {
    return await repository.dialogRecurrences();
  }
  Future<Either<Failure, DialogBase>> dialogCategories() async {
    return await repository.dialogCategories();
  }
  Future<Either<Failure, DialogBase>> dialogAccounts() async {
    return await repository.dialogAccounts();
  }
  Future<Either<Failure, DialogBase>> dialogUsers() async {
    return await repository.dialogUsers();
  }
  Future<Either<Failure, DialogBase>> dialogAccountTypes() async {
    return await repository.dialogAccountTypes();
  }
}