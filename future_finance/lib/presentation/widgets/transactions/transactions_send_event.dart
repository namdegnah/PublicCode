import 'package:flutter/material.dart';
// import '../../bloc/recurrences/recurrence_bloc_exports.dart';
import '../../bloc/transactions/transaction_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsSendEvent extends StatelessWidget {
  TransactionsSendEvent();
  
  @override
  Widget build(BuildContext context) {
    
    BlocProvider.of<TransactionsBloc>(context).add(GetTransactionsEvent()); 
    return const SizedBox(height: 1);      
  }
}