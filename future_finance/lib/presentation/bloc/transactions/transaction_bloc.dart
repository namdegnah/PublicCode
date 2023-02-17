import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/transaction_usecase.dart';
import '../../../data/models/params.dart';
import 'transaction_bloc_exports.dart';
import '../../config/injection_container.dart';

class TransactionsBloc extends Bloc<TransactionsBlocEvent, TransactionsBlocState> {
  final TransactionUser transactionUser = sl<TransactionUser>();

  TransactionsBloc() : super(TransactionInitialState()){
    on<GetTransactionsEvent>((event, emit) => _getTransactions(event, emit));
    on<GetTransactionEvent>((event, emit) => _getTransaction(event, emit));
    on<InsertTransactionEvent>((event, emit) => _insertTransaction(event, emit));
    on<DeleteTransactionEvent>((event, emit) => _deleteTransaction(event, emit));
    on<UpdateTransactionEvent>((event, emit) => _updateTransaction(event, emit));
    on<TransactionDialogEvent>((event, emit) => _transactionDialog(event, emit));
    on<UpdateProcessedEvent>((event, emit) => _updateProcessed(event, emit));
  }
  void _getTransactions(GetTransactionsEvent event, Emitter<TransactionsBlocState> emit) async {
    emit(Loading());
    final failureOrTransactionsList = await transactionUser.call(Params());
    failureOrTransactionsList.fold(
      (failure) => emit(Error(message: failure.message)),
      (transactions) => emit(TransactionsState(transactions: transactions)),      
    );    
  }
  void _getTransaction(GetTransactionEvent event, Emitter<TransactionsBlocState> emit) async {
    emit(Loading());
    final failureOrTransaction = await transactionUser.transaction(Params.id(id: event.id));
    failureOrTransaction.fold(
      (failure) => emit(Error(message: failure.message)),
      (transaction) => emit(TransactionState(transaction: transaction)),      
    );    
  }
  void _insertTransaction(InsertTransactionEvent event, Emitter<TransactionsBlocState> emit) async {
    emit(Loading());
    final failureOrTransaction = await transactionUser.insertTransaction(Params.transaction(transaction: event.transaction));
    failureOrTransaction.fold(
      (failure) => emit(Error(message: failure.message)),
      (transactions) => emit(TransactionsState(transactions: transactions)),    
    );
  }
  void _deleteTransaction(DeleteTransactionEvent event, Emitter<TransactionsBlocState> emit) async {
    emit(Loading());
    final failureOrTransactionsList = await transactionUser.deleteTransaction(Params.id(id: event.id));
    failureOrTransactionsList.fold(
      (failure) => emit(Error(message: failure.message)),
      (transactions) => emit(TransactionsState(transactions: transactions)),    
    );    
  }
  void _updateTransaction(UpdateTransactionEvent event, Emitter<TransactionsBlocState> emit) async {
    emit(Loading());
    final failureOrTransactionsList = await transactionUser.updateTransaction(Params.transaction(transaction: event.transaction));
    failureOrTransactionsList.fold(
      (failure) => emit(Error(message: failure.message)),
      (transactions) => emit(TransactionsState(transactions: transactions)),    
    );    
  }
  void _transactionDialog(TransactionDialogEvent event, Emitter<TransactionsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogData = await transactionUser.transactionDialog(Params.tableNames(tableNames: event.tableNames));
    failureOrDialogData.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogData) => emit(TransactionDialogState(data: dialogData)),    
    );    
  }
  void _updateProcessed(UpdateProcessedEvent event, Emitter<TransactionsBlocState> emit) async {
    emit(Loading());
    final failureOrVoid = await transactionUser.updateProcess(Params.id(id: event.id));
    failureOrVoid.fold(
      (failure) => emit(Error(message: failure.message)),
      (transactions) => null,    
    );    
  }
}