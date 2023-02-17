import '../../data/models/dialog_base.dart';

import '../../core/usecases/usecase.dart';
import '../../data/models/params.dart';
import '../entities/transfer.dart';
import 'package:dartz/dartz.dart';
import '../repositories/repositories_all.dart';
import '../../core/errors/failures.dart';

class TransferUser extends UseCase<List<Transfer>, Params>{
  final TransferRepository repository;
  TransferUser({required this.repository});  


  Future<Either<Failure, List<Transfer>>> call(Params params) async {
    return await repository.transferList();
  }
  Future<Either<Failure, List<Transfer>>> insertTransfer(Params params) async {
    Transfer transfer = params.transfer!;
    return await repository.insertTransfer(transfer);
  }
  Future<Either<Failure, List<Transfer>>> deleteTransfer(Params params) async {
    int id = params.id!;
    return await repository.deleteTransfer(id);
  }
  Future<Either<Failure, List<Transfer>>> updateTransfer(Params params) async {
    Transfer transfer = params.transfer!;
    return await repository.updateTransfer(transfer);
  }
  Future<Either<Failure, Transfer>> transfer(Params params) async {
    int id = params.id!;
    return await repository.transfer(id);
  }
  Future<Either<Failure, DialogBase>> transferDialog(Params params) async {
    return await repository.dialogList(params.tableNames!);
  }  
  Future<Either<Failure, void>> updateProcess(Params params) async {
    int id = params.id!;
    return await repository.updateProcess(id);
  }  
}