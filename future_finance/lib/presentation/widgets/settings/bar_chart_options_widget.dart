import '../../widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/entities/setting.dart';
import '../../config/constants.dart';
import '../../bloc/settings/setting_bloc_exports.dart';

class BarChartOptionsWidget extends StatelessWidget {
  final Setting setting;
  final List<Account> accounts;

  BarChartOptionsWidget({required this.accounts, required this.setting});
  
  @override
  Widget build(BuildContext context) {
    var accountId = setting.barChart;
    var accountName = 'Total';
    if(accountId != SettingNames.barChartTotal){
      var accountMaybe = accounts.firstWhere((account) => account.id == accountId, orElse: () => Account.noAccount(),);
      if(accountMaybe == Account.noAccount()){
        accountId = SettingNames.barChartTotal;
        accountName = SettingNames.barChartTotalName;
      } else {
        accountName = accounts.firstWhere((account) => account.id == accountId).accountName;
      }      
    }    
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: 'When you open the ',
            style: ColourScheme.st,
            children: <TextSpan>[
              TextSpan(text: 'App', style: ColourScheme.stb),
              TextSpan(text: ' it shows a ', style: ColourScheme.stb),
              TextSpan(text: 'Bar Chart', style: ColourScheme.stb),
              TextSpan(text: ' for either one of your accounts or the total of all accounts. You can select the ', style: ColourScheme.st),
              TextSpan(text: 'account', style: ColourScheme.stb),
              TextSpan(text: ' on this screen', style: ColourScheme.st),
              TextSpan(text: '\n\n'),
              TextSpan(text: 'Your current choice is ', style: ColourScheme.st),
              TextSpan(text: accountName, style: ColourScheme.stb),
              TextSpan(text: '\n\n', style: ColourScheme.st),
            ]
          ),
        ),
        Row(children: <Widget>[
          Text('Choose your account', style: ColourScheme.st,),
          SizedBox(width: 10,),
          showAccounts(context),
        ],)
      ],),
    );
  }

  Widget showAccounts(BuildContext context){    
    TextButton fb = TextButton(
      child: Icon(Icons.more_vert),
      onPressed: (){
        _showAccountsDialog(context).then((result){
          int user_id = getCurrentUserId();
          SettingBloc sb = BlocProvider.of<SettingBloc>(context);
          sb.add(BarChartEvent(user_id: user_id, account_id: result));
        });       
      } 
    ); 
    return Row(children: <Widget>[
      SizedBox(width: 30,), fb, Divider(thickness: 1,),
    ],);
  }

  Future<int> _showAccountsDialog(BuildContext context) async {   
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Accounts', style: ColourScheme.st,), 
        children: _convertAccounts(context),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0,),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),        
      ), 
    ); 
  } 
  List<Widget> _convertAccounts(BuildContext context){ 
    List<Widget> lsdo = [];
    if(accounts.isNotEmpty){
      for(Account account in accounts){
        lsdo.add(SimpleDialogOption(        
            child: Text(account.accountName),
            onPressed: () => Navigator.pop(context, account.id),
          )
        );
        lsdo.add(Divider(thickness: 1,));                   
      }
      if(accounts.length > 1){
        lsdo.add(SimpleDialogOption(
          child: Text('Total'),
          onPressed: () => Navigator.pop(context, SettingNames.barChartTotal),
        ));
        lsdo.add(Divider(thickness: 1,));
      }
      lsdo.removeLast();      
    }
    return lsdo;       
  }  
}