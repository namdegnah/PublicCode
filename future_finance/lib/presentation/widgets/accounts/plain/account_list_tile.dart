import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/dialog_base.dart';
import 'package:intl/intl.dart';
import '../../../config/style/app_colours.dart';
import '../../../../domain/entities/accounts/account.dart';
import '../../../../domain/entities/accounts/account_savings.dart';
import '../../../../domain/entities/accounts/account_simple_savings.dart';
import '../../../bloc/accounts/account_bloc_exports.dart';
import '../../../config/injection_container.dart';
import '../../../pages/account_screen.dart';
import '../../accounts/savings/account_saving_options.dart';
import '../../accounts/simple_savings/account_simple_saving_options.dart';
import '../../../config/constants.dart';
import '../../../../domain/entities/setting.dart';

class AccountListTile extends StatelessWidget {
  final Account account;
  final DialogBase db;
  String currencySymbol =Currencies.currencyValue(sl<Setting>().currency);
  AccountListTile(this.account, this.db);
 
  void _deleteAccount(BuildContext context) {

    AccountsBloc ab = BlocProvider.of<AccountsBloc>(context);
    ab.add(DeleteAccountEvent(account: account));   
  }

  void _navigateAndDisplayAccount(BuildContext context) async {
    var result;
    result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<AccountsBloc>(),
        child: editCorrectAccount(), 
      ),
    ));
    if(result != null){
      AccountsBloc ab = BlocProvider.of<AccountsBloc>(context);
      ab.add(sendCorrectEvent(result as Account)!);   
    }
  }
  AccountsBlocEvent? sendCorrectEvent(Account account){
    if(account is AccountSavings){
      return UpdateAccountSavingsEvent(accountSavings: account);
    } else if (account is AccountSimpleSavings){
      return UpdateAccountSimpleSavingsEvent(accountSimpleSavings: account);
    } else if (account is Account){
      return UpdateAccountEvent(account: account);
    }
    return null;
  } 
  Widget editCorrectAccount(){
    if (account is AccountSavings){
      return AccountSavingOptions(accountSaving: account as AccountSavings, db: db);
    } else if(account is AccountSimpleSavings){
      return AccountSimpleSavingOptions(accountSimpleSaving: account as AccountSimpleSavings, db: db);
    } else {
      return AccountScreen(account: account, db: db);
    }
  }

  Widget _getCirclePricedCurrency(){
    var numb;
    
    if(account.balance < 1000){
      numb = NumberFormat.currency(symbol: currencySymbol, decimalDigits: 2);
    } else {
      numb = NumberFormat.currency(symbol: currencySymbol, decimalDigits: 0);
    }
    return CircleAvatar(
      backgroundColor: cltx,
      maxRadius: 25,
      minRadius: 20,        
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Text(
          numb.format(account.balance,),
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,  
          ),
        ),
      )
    );   
  }
   
  @override
  Widget build(BuildContext context) {
    
    return 
      Column(children: <Widget>[     
        ListTile(
          leading: _getCirclePricedCurrency(),
          title: Text(account.accountName),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayAccount(context),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteAccount(context),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 2, thickness: 2,)
      ],
    );
  }
}