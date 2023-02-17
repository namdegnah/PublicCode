import 'package:flutter/material.dart';
import 'package:future_finance/presentation/config/constants.dart';
import '../../bloc/facts/facts_bloc_exports.dart';
import '../../pages/paint/excel_animator.dart';
import '../../../data/models/facts_base.dart';
import '../../pages/paint/scaler.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/usecases/facts_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/function_calls.dart';

class FactsHome extends StatefulWidget {
  final FactsBase factsbase;
  FactsHome({required this.factsbase});

  @override
  _FactsHomeState createState() => _FactsHomeState();
}

class _FactsHomeState extends State<FactsHome> {
  late FactsBloc fb;
  
  @override
  Widget build(BuildContext context) {
    if(widget.factsbase.users.length == 0){
      return Column(children: [
        Center(
          child: Text(
            'You start by adding a new user, select the menu on the top left side to add a new user',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            ),
          )        
      ],);
    } else {
      bool success = true;
      var errorColumn = Column();
      var chartColumn = Column();
      try{
        chartColumn = Column(
          children: <Widget>[
            SizedBox( 
              height: Scaler.barDetails!.portraitGap.ceilToDouble(),
              width: MediaQuery.of(context).size.width,
              child: ExcelAnimator(factsbase: widget.factsbase,),
            ),
            SizedBox(height: 10,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Text('Full Details'),
                showAccounts(),
              ],
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text('Tests'),
              onPressed: () async {
                await loadTesting();
              },
            ),                  
          ],
        );
        
      } on Exception catch(error){
        success = false;
        errorColumn = Column(
          children: <Widget>[
            Text(error.toString(), overflow: TextOverflow.visible),
          ],
        );
      }   

      return success ? chartColumn : errorColumn;
    }
  }

  Widget showAccounts() {
        
    //Can I refresh the accounts here?
    ElevatedButton fb = ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white, 
        side: BorderSide(color: Colors.grey.shade800), 
        primary: Colors.grey.shade400,), 
        child: Text('Choose Account', style: TextStyle(fontWeight: FontWeight.bold)), 
        onPressed: (){
          _showAccountsDialog().then((result) {
            if(result != null){
              widget.factsbase.account = result;
              FactsUser.accountChosenId = result;
              BlocProvider.of<FactsBloc>(context).add(GetFactsEvent());            
            }
          });
        },
    );
    return Row(
      children: <Widget>[SizedBox(width: 30,), fb,Divider(thickness: 1,),],       
    );
  }

  Future<int> _showAccountsDialog() async {
    
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Accounts'),
        children: _convertAccounts(),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),
      ),
    );
  }

  // Accounts Dialog
  List<Widget> _convertAccounts() {
    List<Widget> lsdo = [];
    // List<Account> accountsToUse = sl<AccountUser>().accounts ?? widget.factsbase.accounts;
    List<Account> accountsToUse = widget.factsbase.accounts;
    if(accountsToUse.isNotEmpty){
      for (Account account in accountsToUse) {
        lsdo.add(SimpleDialogOption(
          child: Text(account.accountName),
          onPressed: () => Navigator.pop(context, account.id),
        ));
        lsdo.add(Divider(
          thickness: 1,
        ));
      }
      if (accountsToUse.length > 1) {
        lsdo.add(SimpleDialogOption(
          child: Text(widget.factsbase.total.accountName),
          onPressed: () => Navigator.pop(context, widget.factsbase.total.id),
        ));
        lsdo.add(Divider(
          thickness: 1,
        ));
      }
      lsdo.removeLast();      
    }
    return lsdo;
  }
}