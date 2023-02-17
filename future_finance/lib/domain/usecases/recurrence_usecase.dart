import '../../core/usecases/usecase.dart';
import '../../data/models/params.dart';
import '../entities/recurrence.dart';
import 'package:dartz/dartz.dart';
import '../repositories/repositories_all.dart';
import '../../core/errors/failures.dart';

class RecurrenceUser extends UseCase<List<Recurrence>, Params>{
  final RecurrenceRepository repository;
  RecurrenceUser({required this.repository});  


  Future<Either<Failure, List<Recurrence>>> call(Params params) async {
    return await repository.recurrenceList();
  }
  Future<Either<Failure, List<Recurrence>>> insertRecurrence(Params params) async {
    Recurrence recurrence = params.recurrence!;
    return await repository.insertRecurrence(recurrence);
  }
  Future<Either<Failure, List<Recurrence>>> deleteRecurrence(Params params) async {
    int id = params.id!;
    return await repository.deleteRecurrence(id);
  }
  Future<Either<Failure, List<Recurrence>>> updateRecurrence(Params params) async {
    Recurrence recurrence = params.recurrence!;
    return await repository.updateRecurrence(recurrence);
  }
  Future<Either<Failure, Recurrence>> recurrence(Params params) async {
    int id = params.id!;
    return await repository.recurrence(id);
  }  
}