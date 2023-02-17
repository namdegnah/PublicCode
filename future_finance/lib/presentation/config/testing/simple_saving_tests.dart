import 'package:flutter/material.dart';
import '../../bloc/accounts/account_bloc_exports.dart';
import '../../../domain/entities/accounts/account_simple_savings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/common_widgets.dart';

class SimpleSavingTests extends StatelessWidget{
  
  late AccountSimpleSavings account;
  
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

  Builder runTest(BuildContext context, AccountsBlocEvent event) {
    BlocProvider.of<AccountsBloc>(context).add(event);
    return Builder(
      builder: (context){
        final userState = context.watch<AccountsBloc>().state;
        if(userState is Error){
          return Text('ERROR: ${userState.message}');
        }
        if(userState is AccountState){
          return Text('retrieved');
        }
        if(userState is Loading){
          return Center(child: CircularProgressIndicator(),);
        } else if (userState is AccountsDialogState){
          account = userState.db.accounts!.last as AccountSimpleSavings;
          return AccountWidget(account: account);
        }
        return Center(child: CircularProgressIndicator(),);
      }
    ); 
  }
  Widget correctInsertFound(AccountSimpleSavings account){
    if(account == ass){
      return Text('Correct Record returned');
    } else {
      return Text('Incorrect Record returned');
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget insertRecord = runTest(context, InsertAccountSimpleSavingsEvent(accountSimpleSavings: ass));
    print('and the id of the record inserted is ${getCurrentAccountNumber()}');
    return Column(
      children: [
        insertRecord,              
      ],
    );
  }  
}

class AccountWidget extends StatelessWidget {
  AccountWidget({this.account, super.key});
  final AccountSimpleSavings? account;
  
  AccountSimpleSavings getAccount() => this.account!;
  
  Widget build(BuildContext context) {

    return Text('Insert Record Success: id is ${account!.id}');
  }
}
