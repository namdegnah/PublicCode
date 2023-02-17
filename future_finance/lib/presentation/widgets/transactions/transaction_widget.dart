import 'package:flutter/material.dart';
import '../../../domain/entities/transaction.dart';
import '../../../data/models/dialog_base.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/recurrence.dart';
import '../common_widgets.dart';
import '../../config/injection_container.dart';
import '../../config/constants.dart';
import '../../../domain/entities/setting.dart';

class TransactionWidget extends StatefulWidget {
  final Transaction transaction;
  final GlobalKey<FormState> form;
  final Function saveF;
  final DialogBase db;
  TransactionWidget({required this.transaction, required this.form, required this.saveF, required this.db});

  @override
  _TransactionWidgetState createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  var result; 

  @override
  Widget build(BuildContext context) {
    String currencySymbol =Currencies.currencyValue(sl<Setting>().currency);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: widget.form,
        child: ListView(
          children: <Widget>[
            // Transaction Name
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: 'Enter the transaction name', labelText: 'Transaction Name'),
                initialValue: widget.transaction.title,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a valid transaction name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => widget.transaction.title = value!,
              ),
            ),
            // Transaction Description
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 80,
                decoration: const InputDecoration(hintText: 'Enter the transaction description', labelText: 'Description'),
                initialValue: widget.transaction.description,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter some text for the description';
                  } else {
                    return  null;
                  }
                },
                onSaved: (value) => widget.transaction.description = value!,
              ),              
            ),
            // Amount
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                SizedBox(
                  width: 15,
                  child: Text(
                    currencySymbol, 
                    style: TextStyle(height: 0.45),
                  ), 
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                    child: TextFormField(
                    maxLength: 8,
                    decoration: InputDecoration(hintText: 'Enter amount in ${currencySymbol}', labelText: 'Amount (${currencySymbol})'),
                    initialValue: widget.transaction.amount == null ? 0.0.toString() : widget.transaction.amount.toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.none,
                    onFieldSubmitted: (_) => widget.saveF(context),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter an amount in (${currencySymbol})';
                      } 
                      if(double.tryParse(value) == null){
                        return 'please enter a valid number for the transaction amount';
                      }
                      return null;
                    },
                    onSaved: (value) => widget.transaction.amount = double.parse(value!), 
                  ),
                ),
              ],),
            ),            
            // Planned Date for Transaction 
            Container(
              // margin: EdgeInsets.only(left: 10),
              child: Row(children: <Widget>[
                widget.transaction.showDateSetting(),
                TextButton(
                  child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: showPick,
                ),
              ],),
            ),
            // Account, Category and Recurrence Dialogs for Transaction
            showAccount(), 
            showCategory(),
            showRecurrence(), 
            // Use in Finance Facts
            SwitchListTile(
              title: const Text('Debit or Credit'),
              value: widget.transaction.credit,
              subtitle: const Text('Debit is off, Credit is on'),
              onChanged: (bool value) {
                setState(() {
                  widget.transaction.credit = value;
                });
              } 
            ),            
            // Use in Finance Facts
            SwitchListTile(
              title: const Text('Use in Finance Facts'),
              value: widget.transaction.usedForCashFlow,
              subtitle: const Text('Include or Exclude from the Facts run'),
              onChanged: (bool value) {
                setState(() {
                  widget.transaction.usedForCashFlow = value;
                });
              } 
            ),
          ],
        ),
      ),
    );
  }
  void showPick(){
    FocusScope.of(context).unfocus();
    showDatePicker(
      context: context,
      initialDate: widget.transaction.plannedDate == null ? DateTime.now() : widget.transaction.plannedDate!,
      firstDate: DateTime(DateTime.now().year - 5, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2050), 
    ).then((pickedate){
      setState(() {          
        widget.transaction.finish = DateTime(pickedate!.year, pickedate.month, pickedate.day);
      });
    });    
  }  
  Widget showAccount(){
    Text text;
    OutlinedButton fb = OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blueGrey[800]!),
        primary: Colors.blueGrey[800],
      ),    
      child: Text('Choose Account', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showAccountDialog().then((result){
          setState(() {
            widget.transaction.accountId = result;
          });              
        });
      } 
    );     
    if(widget.transaction.accountId == 0){      
        text = Text('No Account Chosen');
    } else {
      Account account = widget.db.accounts!.firstWhere((account) => account.id == widget.transaction.accountId);
      text = Text(account.accountName);
    }
    return Row(children: <Widget>[
      text, SizedBox(width: 30,), fb, Divider(thickness: 1,),
    ],);
  }

  Future<int> _showAccountDialog() async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Accounts Dialog'), // Could this be central? Why is it bold and bigger? Colour maybe
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
    for(Account account in widget.db.accounts!){
      lsdo.add(SimpleDialogOption(        
          child: Text(account.accountName),
          onPressed: () => Navigator.pop(context, account.id),
        )
      );
      lsdo.add(Divider(thickness: 1,));      
    }
    if(lsdo.length > 0){
      lsdo.removeLast();
    }    
    return lsdo;
  }

  //Category Dialog
  Widget showCategory(){
    Text t;
      OutlinedButton fb = OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blueGrey[800]!),
        primary: Colors.blueGrey[800],
      ),
      child: Text('Choose Category', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showCategoryDialog().then((result){
          setState(() {
            widget.transaction.categoryId = result;
          });              
        });
      } 
    );     
    if(widget.transaction.categoryId == 0){      
        t = Text('No Category Chosen');
    } else {
      Category category = widget.db.categories!.firstWhere((category) => category.id == widget.transaction.categoryId);
      t = Text(category.categoryName);
    }
    return Row(children: <Widget>[
      t, SizedBox(width: 30,), fb, Divider(thickness: 1,)
    ],);
  }
  Future<int> _showCategoryDialog() async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Categories Dialog'), // Could this be central? Why is it bold and bigger? Colour maybe
        children: _convertCategories(),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0,),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),        
      ), 
    ); 
  }
  List<Widget> _convertCategories(){ 
    List<Widget> lsdo = [];
    for(Category category in widget.db.categories!){
      lsdo.add(Row(children: <Widget>[
        SizedBox(width: 5,),
        IconListImage(category.iconPath, 25),
        SizedBox(width: 3,),
        SimpleDialogOption(child: Text(category.categoryName), onPressed: () => Navigator.pop(context, category.id),),         
      ],));             
      lsdo.add(Divider(thickness: 1,));      
    }
    lsdo.removeLast();
    return lsdo;
  }  
  Widget showRecurrence(){
    Text t;
    TextButton fb = TextButton(
      child: Text('Choose Recurrence', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showRecurrenceDialog().then((result){
          setState(() {
            widget.transaction.recurrenceId = result;
          });              
        });
      } 
    );     
    if(widget.transaction.recurrenceId == 0){      
        t = Text('No Recurrence Chosen');
    } else {
      Recurrence recurrence = widget.db.recurrences!.firstWhere((recurrence) => recurrence.id == widget.transaction.recurrenceId);
      t = Text(recurrence.title);
    }
    return Row(children: <Widget>[
      t, SizedBox(width: 30,), fb, Divider(thickness: 1,)
    ],);
  }  
  // Recurrence Dialog
  List<Widget> _convertRecurrences(){ 
    List<Widget> lsdo = [];
    for(Recurrence recurrence in widget.db.recurrences!){
      lsdo.add(Row(children: <Widget>[
        SizedBox(width: 5,),
        IconListImage(recurrence.iconPath, 25),
        SizedBox(width: 3,),
        SimpleDialogOption(child: Text(recurrence.title), onPressed: () => Navigator.pop(context, recurrence.id),),                
      ],));
      lsdo.add(Divider(thickness: 1,));      
    }
    lsdo.removeLast();
    return lsdo;
  }  
  Future<int> _showRecurrenceDialog() async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Recurrence Dialog'), // Could this be central? Why is it bold and bigger? Colour maybe
        children: _convertRecurrences(),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0,),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),
      ), 
    ); 
  }         
}