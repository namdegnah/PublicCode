import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/transactions/transaction_bloc_exports.dart';
import '../../../domain/entities/transaction.dart';
import 'transaction_widgets.dart';
import '../../config/constants.dart';
import '../../bloc/dialog/dialog_bloc_exports.dart';
import '../../config/injection_container.dart';
import '../../pages/transaction_screen.dart';


class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionsList(this.transactions);

  void _navigateAndDisplayTransaction(BuildContext context) async {

    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<DialogBloc>(),
        child: TransactionScreen(transaction: Transaction(id: 0, title: '', description: '', plannedDate: null, accountId: 0, categoryId: 0, recurrenceId: 0, credit: true, amount: 0.00, usedForCashFlow: true, processed: SettingNames.autoProcessedFalse, user_id: 0), ),                       
      ),
    ));
    if(result != null){
      BlocProvider.of<TransactionsBloc>(context).add(InsertTransactionEvent(transaction: result as Transaction));
    }
  }  

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.black26),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _navigateAndDisplayTransaction(context);
              },
            ),
          ],
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 265,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Transactions',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/transaction.jpg'),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index){
            return TransactionListTile(transactions[index]);
          },
          childCount: transactions.length,
          ),
        ),
      ],
    );    
  }
}
