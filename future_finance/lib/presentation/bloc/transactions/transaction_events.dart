import 'package:meta/meta.dart';
import '../../../domain/entities/transaction.dart';

@immutable
abstract class TransactionsBlocEvent{}

class GetTransactionsEvent extends TransactionsBlocEvent{}

class GetTransactionEvent extends TransactionsBlocEvent{
  final int id;
  GetTransactionEvent({required this.id});
}
class DeleteTransactionEvent extends TransactionsBlocEvent{
  final int id;
  DeleteTransactionEvent({required this.id});
}
class UpdateTransactionEvent extends TransactionsBlocEvent{
  final Transaction transaction;
  UpdateTransactionEvent({required this.transaction});
}
class InsertTransactionEvent extends TransactionsBlocEvent{
  final Transaction transaction;
  InsertTransactionEvent({required this.transaction});
}
class TransactionDialogEvent extends TransactionsBlocEvent{
  final List<String> tableNames;
  TransactionDialogEvent({required this.tableNames});
}
class UpdateProcessedEvent extends TransactionsBlocEvent {
  final int id;
  UpdateProcessedEvent({required this.id});
}