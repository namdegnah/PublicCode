import 'package:flutter/material.dart';
import '../../../domain/entities/transfer.dart';
import '../../../data/models/dialog_base.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/recurrence.dart';
import '../common_widgets.dart';
import '../../config/constants.dart';
import '../../config/injection_container.dart';
import '../../../domain/entities/setting.dart';

class TransferWidget extends StatefulWidget {
  final Transfer transfer;
  final GlobalKey<FormState> form;
  final Function saveF;
  final DialogBase db;
  TransferWidget({required this.transfer, required this.form, required this.saveF, required this.db});

  @override
  _TransferWidgetState createState() => _TransferWidgetState();
}

class _TransferWidgetState extends State<TransferWidget> {
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
            // Transfer Name
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: 'Enter the transfer name', labelText: 'Transfer Name'),
                initialValue: widget.transfer.title,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a valid transfer name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => widget.transfer.title = value!,
              ),
            ),
            // Transaction Description
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 80,
                decoration: const InputDecoration(hintText: 'Enter the transfer description', labelText: 'Description'),
                initialValue: widget.transfer.description,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter some text for the description';
                  } else {
                    return  null;
                  }
                },
                onSaved: (value) => widget.transfer.description = value!,
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
                    initialValue: widget.transfer.amount == 0 ? 0.0.toString() : widget.transfer.amount.toString(),
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
                    onSaved: (value) => widget.transfer.amount = double.parse(value!), 
                  ),
                ),
              ],),
            ),                        
            // Planned Date for Tranfer 
            Container(
              // margin: EdgeInsets.only(left: 15),
              child: Row(children: <Widget>[
                widget.transfer.showDateSetting(),
                TextButton(
                  child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: showPick,
                ),
              ],),
            ),
            // Account, Category and Recurrence Dialogs for Transaction
            showToAccount(),
            //Show another account 
            showFromAccount(),
            //Show category
            showCategory(),
            showRecurrence(), 
            // Use in Finance Facts
            SwitchListTile(
              title: const Text('Use in Finance Facts'),
              value: widget.transfer.usedForCashFlow,
              subtitle: const Text('Include or Exclude from the Facts run'),
              onChanged: (bool value) {
                setState(() {
                  widget.transfer.usedForCashFlow = value;
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
      initialDate: widget.transfer.plannedDate == null ? DateTime.now() : widget.transfer.plannedDate!,
      firstDate: DateTime(DateTime.now().year - 5, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2050), 
    ).then((pickedate){
      setState(() {          
        widget.transfer.finish = DateTime(pickedate!.year, pickedate.month, pickedate.day);
      });
    });
  }  
  Widget showToAccount(){
    Text t;
    TextButton fb = TextButton(
      child: Text('To Account', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showAccountDialog().then((result){
          setState(() {
            widget.transfer.toAccountId = result;
          });              
        });
      } 
    ); 
    
    if(widget.transfer.toAccountId == 0){      
        t = const Text('No To Account Chosen');
    } else {
      Account account = widget.db.accounts!.firstWhere((account) => account.id == widget.transfer.toAccountId);
      t = Text(account.accountName);
    }
    return Row(children: <Widget>[
      t, SizedBox(width: 30,), fb, Divider(thickness: 1,),
    ],);
  }
  Widget showFromAccount(){
    Text t;
    TextButton fb = TextButton(
      child: const Text('From Account', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showAccountDialog().then((result){
          setState(() {
            widget.transfer.fromAccountId = result;
          });              
        });
      } 
    ); 
    
    if(widget.transfer.fromAccountId == 0){      
        t = Text('No from Account Chosen');
    } else {
      Account account = widget.db.accounts!.firstWhere((account) => account.id == widget.transfer.fromAccountId);
      t = Text(account.accountName);
    }
    return Row(children: <Widget>[
      t, SizedBox(width: 10,), fb, Divider(thickness: 1,),
    ],);
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
    lsdo.removeLast();
    return lsdo;
  }
  Future<int> _showAccountDialog() async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Accounts Dialog'),
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
  //Category Dialog
  Widget showCategory(){
    Text t;
    TextButton fb = TextButton(
      child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showCategoryDialog().then((result){
          setState(() {
            widget.transfer.categoryId = result;
          });              
        });
      } 
    );     
    if(widget.transfer.categoryId == 0){      
        t = Text('No Category Chosen');
    } else {
      Category category = widget.db.categories!.firstWhere((category) => category.id == widget.transfer.categoryId);
      t = Text(category.categoryName);
    }
    return Row(children: <Widget>[
      t, SizedBox(width: 30,), fb, Divider(thickness: 1,)
    ],);
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
  Future<int> _showCategoryDialog() async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Categories Dialog'), 
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
  Widget showRecurrence(){
    Text t;
    TextButton fb = TextButton(
      child: Text('Choose Recurrence', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showRecurrenceDialog().then((result){
          setState(() {
            widget.transfer.recurrenceId = result;
          });              
        });
      } 
    );     
    if(widget.transfer.recurrenceId == 0){      
        t = Text('No Recurrence Chosen');
    } else {
      Recurrence recurrence = widget.db.recurrences!.firstWhere((recurrence) => recurrence.id == widget.transfer.recurrenceId);
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