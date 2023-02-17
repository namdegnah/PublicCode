import '../../data/models/dialog_base.dart';
import '../../core/usecases/usecase.dart';
import '../../data/models/params.dart';
import '../entities/transaction.dart';
import 'package:dartz/dartz.dart';
import '../repositories/repositories_all.dart';
import '../../core/errors/error_export.dart';

class TransactionUser extends UseCase<List<Transaction>, Params>{
  final TransactionRepository repository;
  TransactionUser({required this.repository});  


  Future<Either<Failure, List<Transaction>>> call(Params params) async {
    return await repository.transactionList();
  }
  Future<Either<Failure, List<Transaction>>> insertTransaction(Params params) async {
    Transaction transaction = params.transaction!;
    return await repository.insertTransaction(transaction);
  }
  Future<Either<Failure, List<Transaction>>> deleteTransaction(Params params) async {
    int id = params.id!;
    return await repository.deleteTransaction(id);
  }
  Future<Either<Failure, List<Transaction>>> updateTransaction(Params params) async {
    Transaction transaction = params.transaction!;
    return await repository.updateTransaction(transaction);
  }
  Future<Either<Failure, Transaction>> transaction(Params params) async {
    int id = params.id!;
    return await repository.transaction(id);
  }
  Future<Either<Failure, DialogBase>> transactionDialog(Params params) async {
    return await repository.dialogList(params.tableNames!);
  }
  Future<Either<Failure, ServerSuccess>> updateProcess(Params params) async {
    int id = params.id!;
    return await repository.updateProcess(id);
  }  
}