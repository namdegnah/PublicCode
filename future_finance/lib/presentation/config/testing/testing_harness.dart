import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/accounts/account_bloc_exports.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/entities/accounts/account_simple_savings.dart';
import '../../../data/models/dialog_base.dart';

class TestingHarness extends StatelessWidget {
  TestingHarness({Key? key}) : super(key: key);
  int i = 0;
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: getTestWidget(context, i),
    );
    return scaffold;
  }
}
Builder testSimpleInsertSavings(BuildContext context){
  
  BlocProvider.of<AccountsBloc>(context).add(InsertAccountSimpleSavingsEvent(accountSimpleSavings: ass));
  
  return Builder(
    builder: (BuildContext context){
      final userState = context.watch<AccountsBloc>().state;
      if(userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      } else if (userState is AccountsDialogState){
        account.id = userState.db.id!;
        return SimpleWidgetResults(db: userState.db,);
      }
      return Center(child: CircularProgressIndicator(),);
    }
  );
}

Widget getTestWidget(BuildContext context, int i){
  switch(i){
    case 0: return testSimpleInsertSavings(context);
  }
  return Container();
}
AccountSimpleSavings ass = AccountSimpleSavings(
  lastInterestAdded: null, 
  interestAccrued: 0, 
  savingsRate: 2.5, 
  addInterestId: 1, 
  accountStart: DateTime.now(), 
  accountEnd: null,
  chargeRate: 0, 
  chargeRecurrenceId: 1, 
  id: -1, 
  accountName: 'Test Account', 
  description: 'description', 
  balance: 100, 
  usedForCashFlow: true
);
Account account = Account(
  accountName: '',
  id: -1,
  balance: 0,
  description: ''
);
class SimpleWidgetResults extends StatelessWidget {
  const SimpleWidgetResults({required this.db, super.key});
  final DialogBase db;

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text('Account id is: ${db.id!}'),
    ));
  }
}