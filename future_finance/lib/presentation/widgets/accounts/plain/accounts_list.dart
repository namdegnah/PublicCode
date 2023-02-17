import 'package:flutter/material.dart';
import '../../../bloc/accounts/account_bloc_exports.dart';
import '../../../pages/account_screen.dart';
import '../../../../domain/entities/accounts/account.dart';
import '../../../../domain/entities/accounts/account_type.dart';
import '../../../widgets/accounts/plain/account_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/dialog_base.dart';
import '../../common_widgets.dart';
import '../../../config/constants.dart';
import '../savings/account_saving_options.dart';
import '../simple_savings/account_simple_saving_options.dart';
import '../../../../domain/entities/accounts/account_savings.dart';
import '../../../../domain/entities/accounts/account_simple_savings.dart';

class AccountList extends StatelessWidget {
  final DialogBase db;
  AccountList({required this.db});

  void _navigateAndDisplayAccount(BuildContext context) async {
      int _accountTypeId = 0;
        _showAccountTypeDialog(context).then((result) async {
          //so here is where we launch the next screen. Using the same method. 
          //first check to see what the result is
          
          if(result != null){
            _accountTypeId = result;
            switch(_accountTypeId){
              case AccountTypesNames.plainAccount:
                var result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AccountScreen(account: Account(id: 0, accountName: '', description: '', balance: 0.0, usedForCashFlow: true), db: db,), ),);
                  if (result != null) {
                    AccountsBloc ab = BlocProvider.of<AccountsBloc>(context);
                    Account account = result as Account;
                    ab.add(InsertAccountEvent(account: account));      
                  }
                  break;
              case AccountTypesNames.savingAccount:
                var result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AccountSavingOptions(accountSaving: AccountSavings(id: 0, accountName: '', description: '', balance: 0.0, usedForCashFlow: true, chargeRate: 0.0, chargeRecurrenceId: RecurrenceNames.no_recurrence, accountStart: null, accountEnd: null, savingsRate: 0.0, rateRecurrenceId: RecurrenceNames.no_recurrence, lastInterestAdded: null, interestAccrued: 0.0, capitalCeiling: 0.0, chargeAccountId: AccountNames.no_account, savingsAccountId: AccountNames.no_account), db: db), ),);
                  if (result != null) {
                    AccountsBloc ab = BlocProvider.of<AccountsBloc>(context);
                    AccountSavings accountSaving = result as AccountSavings;
                    ab.add(InsertAccountSavingsEvent(accountSavings: accountSaving));      
                  }
                  break; 
              case AccountTypesNames.simpleSavingAccount:
                var result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AccountSimpleSavingOptions(accountSimpleSaving: AccountSimpleSavings(id: 0, accountName: '', description: '', balance: 0.0, usedForCashFlow: true, chargeRate: 0.0, chargeRecurrenceId: RecurrenceNames.no_recurrence, accountStart: null, accountEnd: null, savingsRate: 0.0, addInterestId: AddInterestNames.no_add_interest, lastInterestAdded: null, interestAccrued: 0.0), db: db), ),);
                  if (result != null) {
                    AccountsBloc ab = BlocProvider.of<AccountsBloc>(context);
                    AccountSimpleSavings accountSaving = result as AccountSimpleSavings;
                    ab.add(InsertAccountSimpleSavingsEvent(accountSimpleSavings: accountSaving));      
                  }
                  break;                             
              default:
                print(result);
                break;
            }
          }
                       
        });                
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
                _navigateAndDisplayAccount(context);
              },
            ),
          ],
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 265,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Bank Accounts',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/strongboxA.png'),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index){
            return AccountListTile(db.accounts![index], db);
          },
          childCount: db.accounts!.length,
          ),
        ),
      ],
    );    
  }
  Future<int> _showAccountTypeDialog(BuildContext context) async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Account Types Dialog'), // Could this be central? Why is it bold and bigger? Colour maybe
        children: _convertAccountType(context),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0,),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),        
      ), 
    ); 
  }
  List<Widget> _convertAccountType(BuildContext context){ 
    List<Widget> lsdo = [];
    for(AccountType accountType in db.accountTypes!){
      lsdo.add(Row(children: <Widget>[
        SizedBox(width: 5,),
        IconListImage(accountType.iconPath, 25),
        SizedBox(width: 3,),
        SimpleDialogOption(child: Text(accountType.typeName), onPressed: () => Navigator.pop(context, accountType.id),),         
      ],));             
      lsdo.add(Divider(thickness: 1,));      
    }
    if (lsdo.isNotEmpty) lsdo.removeLast();
    return lsdo;
  }   
}
