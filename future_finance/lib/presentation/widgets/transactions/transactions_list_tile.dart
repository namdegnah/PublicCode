import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/injection_container.dart';
import '../../../domain/entities/transaction.dart';
import '../../bloc/transactions/transaction_bloc_exports.dart';
import '../../pages/transaction_screen.dart';
import '../../bloc/dialog/dialog_bloc_exports.dart';

class TransactionListTile extends StatelessWidget {
  final Transaction transaction;
  TransactionListTile(this.transaction);
  late int id;

  void _deleteTransaction(BuildContext context, int id) {
    TransactionsBloc tb = BlocProvider.of<TransactionsBloc>(context);
    tb.add(DeleteTransactionEvent(id: id));
  }
  void _navigateAndDisplayTransaction(BuildContext context, int id) async {

    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<DialogBloc>(),
        child: TransactionScreen(transaction: transaction,), 
      ),
    ));
    if(result != null){
      BlocProvider.of<TransactionsBloc>(context).add(UpdateTransactionEvent(transaction: result as Transaction));  
    }
  }

  Widget _showInOrOut() {
    return CircleAvatar(
      backgroundColor: transaction.credit ? Colors.blue : Colors.red,
      maxRadius: 25,
      minRadius: 20,
      child: transaction.credit
          ? Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 30,
            )
          : Icon(Icons.remove_circle, color: Colors.white, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    id = transaction.id;
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => print(transaction.id), //This is the point to action
          leading: transaction.credit
              ? Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                  size: 30,
                )
              : Icon(Icons.remove_circle, color: Colors.red, size: 30),
          title: Text(transaction.title),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayTransaction(context, id),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTransaction(context, id),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
        )
      ],
    );
  }
}
