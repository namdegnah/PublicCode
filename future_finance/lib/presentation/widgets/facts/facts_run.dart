import 'package:flutter/material.dart';
import '../../../data/models/facts_base.dart';
import '../../bloc/facts/facts_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/accounts/account.dart';
import 'facts_widgets_export.dart';
import '../../config/style/style_extensions.dart';

class FactsRun extends StatefulWidget {
  final FactsBase factsbase;
  FactsRun({required this.factsbase});

  @override
  _FactsRunState createState() => _FactsRunState();
}

class _FactsRunState extends State<FactsRun> {

  @override
  Widget build(BuildContext context) {
    double pad = 5;
    double size = 15;
    
    return Column(
      children: <Widget>[
        Text('Future Finance Facts Run').buff(pad: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          SizedBox(width: 5,),
          Text('Choose Account').polish(pad: pad, size: size),
          SizedBox(width: 40,),
          showAccounts(),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          SizedBox(width: 5,),
          Text('Total of all Accounts').polish(pad: pad, size: size),
          SizedBox(width: 15,),
          // IconButton(
          //   icon: Icon(Icons.launch),
          //   onPressed: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (_) => FactsPage(cashflow: widget.factsbase.total.cashFlow))), // This produces the total and lauches the facts page
          // ),  
          ],
        ),
        ElevatedButton(
          child: Text('Home Screen'),
          onPressed:() {
            BlocProvider.of<FactsBloc>(context).add(GetHomeEvent());          
          },
        ),
      ],  
    );
  }
  Widget showAccounts(){    
    TextButton fb = TextButton(
      child: Text('Choose Account', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showAccountsDialog().then((result){
          widget.factsbase.account = result;
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => FactsPage(factsbase: widget.factsbase))); 
        });
      } 
    ); 
    return Row(children: <Widget>[
      SizedBox(width: 30,), fb, Divider(thickness: 1,),
    ],);
  }
  Future<int> _showAccountsDialog() async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Accounts'), 
        children: _convertAccounts(),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0,),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),        
      ), 
    ); 
  } 
  // Accounts Dialog 
  List<Widget> _convertAccounts(){ 
    List<Widget> lsdo = [];
    for(Account account in widget.factsbase.accounts){
      lsdo.add(SimpleDialogOption(        
          child: Text(account.accountName),
          onPressed: () => Navigator.pop(context, account.id),
        )
      );
      lsdo.add(Divider(thickness: 1,));                   
    }
    lsdo.removeLast();
    return lsdo;
  }   
}