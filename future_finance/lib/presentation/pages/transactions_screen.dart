import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transactions/transaction_bloc_exports.dart';
//import '../../injection_container.dart';
import '../widgets/transactions/transaction_widgets.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: buildBody(context),
    );
    return scaffold;
  }
}
Builder buildBody(BuildContext context){
  BlocProvider.of<TransactionsBloc>(context).add(GetTransactionsEvent());
  return Builder(
    builder: (context){
      final userState = context.watch<TransactionsBloc>().state;
      if(userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      } else if (userState is TransactionsState){
        return TransactionsList(userState.transactions);
      }
      return Center(child: CircularProgressIndicator(),);
    }
  );
}

