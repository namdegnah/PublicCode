import '../../../widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/accounts/account_simple_savings.dart';
import 'account_simple_savings_widget.dart';
import '../../../../data/models/dialog_base.dart';
import '../../../config/constants.dart';
import '../../../bloc/accounts/account_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/user.dart';

class AccountSimpleSavingOptions extends StatelessWidget {
  final AccountSimpleSavings accountSimpleSaving;
  final DialogBase db;
  AccountSimpleSavingOptions({required this.accountSimpleSaving, required this.db});
  final form = GlobalKey<FormState>();
 

  void _saveForm(BuildContext context){
    if(accountSimpleSaving.accountStart == 0){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a start date for the account start'), content: Text('e.g. Account must start at a specific date'), actions: <Widget>[ElevatedButton(style: ElevatedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.grey.shade800), backgroundColor: Colors.grey.shade400,), child: Text('OK', style: TextStyle(fontWeight: FontWeight.bold)), onPressed: (){Navigator.of(context).pop();},),],),);
      return;
    }     
    if(accountSimpleSaving.addInterestId == 0 || accountSimpleSaving.addInterestId == AddInterestNames.no_add_interest){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select when the interest is paid into the account'), content: Text('e.g. Interest must be paid into the account'), actions: <Widget>[ElevatedButton(style: ElevatedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.grey.shade800), backgroundColor: Colors.grey.shade400,), child: Text('OK', style: TextStyle(fontWeight: FontWeight.bold)), onPressed: (){Navigator.of(context).pop();},),],),);
      return;
    }
    if(accountSimpleSaving.chargeRecurrenceId == 0 || accountSimpleSaving.chargeRecurrenceId == RecurrenceNames.no_recurrence){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a recurrence for charges'), content: Text('e.g. Charges must have a periodic recurrence'), actions: <Widget>[ElevatedButton(style: ElevatedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.grey.shade800), backgroundColor: Colors.grey.shade400,), child: Text('OK', style: TextStyle(fontWeight: FontWeight.bold)), onPressed: (){Navigator.of(context).pop();},),],),);
      return;
    }              
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();
    
    Navigator.pop(context, accountSimpleSaving);
  }
  void _shareAccount(BuildContext context){
    _showUsersDialog(context).then((result) async {
      if (result != null) {        
        BlocProvider.of<AccountsBloc>(context).add(InsertSharedAccount(account: accountSimpleSaving, id: result));      
      }  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings Account'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareAccount(context),
          ),          
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],
        ),
      body: AccountSimpleSavingsWidget(accountSimpleSaving, form, db),
      );
  }
//=======================================================================================================================  
  Future<int> _showUsersDialog(BuildContext context) async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Users Dialog'), // Could this be central? Why is it bold and bigger? Colour maybe
        children: _convertUsers(context),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0,),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),        
      ), 
    ); 
  }
  List<Widget> _convertUsers(BuildContext context){ 
    List<Widget> lsdo = [];

    int user_id = getCurrentUserId();    
    for(User user in db.users!){
      if(user.id != user_id){
        lsdo.add(Row(children: <Widget>[
          SizedBox(width: 5,),
          SizedBox(width: 3,),
          SimpleDialogOption(child: Text(user.name), onPressed: () => Navigator.pop(context, user.id),),         
        ],));             
        lsdo.add(Divider(thickness: 1,));      
    }        
      }
    if(lsdo.isNotEmpty) lsdo.removeLast();
    return lsdo;
  }   
}