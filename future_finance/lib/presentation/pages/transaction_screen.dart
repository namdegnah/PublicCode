import 'package:flutter/material.dart';
import '../bloc/dialog/dialog_bloc_exports.dart';
import '../../domain/entities/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/transactions/transaction_widgets.dart';
import '../../data/models/dialog_base.dart';

class TransactionScreen extends StatelessWidget {
  final Transaction transaction;
  TransactionScreen({required this.transaction});
  final form = GlobalKey<FormState>();
  late DialogBase db;
  late DialogBloc tb;

  void _saveForm(BuildContext context) {
    if (transaction.plannedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Select a planned date'),
          content: Text('e.g. Transaction must occur at a specific date'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return;
    }
    if (transaction.accountId == 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Select an account'),
          content: Text('e.g. Transaction must be linked to an account'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return;
    }
    if (transaction.categoryId == 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Select a category'),
          content: Text('e.g. Transaction must have a category'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return;
    }
    final isValid = form.currentState!.validate();
    if (!isValid) return;
    form.currentState!.save();
    Navigator.pop(context, transaction);
  }

  void _getDiaialogData() {
    tb.add(DialogFullEvent());
  }

  Builder buildBody(BuildContext context){
    return Builder(
      builder: (context){
        final userState = context.watch<DialogBloc>().state;
        if(userState is DialogFullState){
          db = userState.data;
          return TransactionWidget(transaction: transaction, form: form, saveF: _saveForm, db: db);        
        } else if (userState is Loading){
          return Center(child: CircularProgressIndicator(),);
        }
        return Center(child: CircularProgressIndicator(),);
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    tb = BlocProvider.of<DialogBloc>(context);
    _getDiaialogData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(context),
          ),
        ],
      ),
      body: buildBody(context),
    );
  }
}
