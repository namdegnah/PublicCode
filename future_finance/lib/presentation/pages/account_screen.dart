import 'package:flutter/material.dart';
import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/user.dart';
import '../../../presentation/widgets/accounts/plain/account_widget.dart';
import '../../../../data/models/dialog_base.dart';
import '../bloc/accounts/account_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/injection_container.dart';

class AccountScreen extends StatelessWidget {
  final Account account;
  final DialogBase db;
  AccountScreen({required this.account, required this.db});
  final form = GlobalKey<FormState>();
 

  void _saveForm(BuildContext context){
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();
    Navigator.pop(context, account);
  }
  void _shareAccount(BuildContext context){
    _showUsersDialog(context).then((result) async {
      if (result != null) {        
        AccountsBloc ab = BlocProvider.of<AccountsBloc>(context);
        // ab.add(InsertSharedAccount(account: account, id: result));        
      }  
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
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
      body: AccountWidget(account, form, _saveForm),
      );
  }
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
    // DefaultUserSetting du = sl<DefaultUserSetting>();
    // int user_id = du.userChoice;    
    int user_id = 1;
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
    lsdo.removeLast();
    return lsdo;
  }     
}