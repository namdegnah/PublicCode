import 'package:meta/meta.dart';
import '../../../domain/entities/transaction.dart';
import '../../../data/models/dialog_base.dart';

@immutable
abstract class TransactionsBlocState{}

class TransactionInitialState extends TransactionsBlocState{}

class Empty extends TransactionsBlocState{}
class Loading extends TransactionsBlocState{}
class Error extends TransactionsBlocState{
  final String message;
  Error({required this.message});
}
class TransactionState extends TransactionsBlocState{
  final Transaction transaction;
  TransactionState({required this.transaction});
}
class TransactionsState extends TransactionsBlocState{
  final List<Transaction> transactions;
  TransactionsState({required this.transactions});
}
class TransactionDialogState extends TransactionsBlocState{
  final DialogBase data;
  TransactionDialogState({required this.data});
}