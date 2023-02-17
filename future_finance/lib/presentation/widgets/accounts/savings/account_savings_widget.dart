import 'package:flutter/material.dart';
import '../../../../domain/entities/accounts/account.dart';
import '../../../../domain/entities/accounts/account_savings.dart';
import '../../../../domain/entities/recurrence.dart';
import '../../../config/injection_container.dart';
import '../../../../data/models/dialog_base.dart';
import '../../../widgets/common_widgets.dart';
import '../../../config/constants.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/setting.dart';

class AccountSavingsWidget extends StatefulWidget {
  final AccountSavings account;
  final GlobalKey<FormState> form;
  final DialogBase db;  
  static int SAVINGS_RATE = 10;
  static int CHARGE_RATE = 20;
  static int ACCOUNT_START = 30;

  AccountSavingsWidget(this.account, this.form, this.db);

  @override
  _AccountSavingsWidgetState createState() => _AccountSavingsWidgetState();
}

class _AccountSavingsWidgetState extends State<AccountSavingsWidget> {
  


  @override
  Widget build(BuildContext context) {
    String currencySymbol =Currencies.currencyValue(sl<Setting>().currency);
    return Form(
      key: widget.form,
      child: SingleChildScrollView(
        child:Table(          
          columnWidths: {
            0: FlexColumnWidth(0.45),
            1: FlexColumnWidth(0.55)
          },
          border: TableBorder.all(color: Colors.white, width: 10, style: BorderStyle.solid),
          children: [
            TableRow(
              children: [
                //Account Name
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: TextFormField(
                    maxLength: 40,
                    decoration: const InputDecoration(hintText: 'Enter the account name', labelText: 'Account Name'),
                    initialValue: widget.account.accountName,
                    textInputAction: TextInputAction.none,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter a valid Account name';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => widget.account.accountName = value!,
                  ),
                ),
                //Description
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    maxLength: 40,
                    decoration: const InputDecoration(hintText: 'Enter the account description', labelText: 'Description'),
                    initialValue: widget.account.description,
                    textInputAction: TextInputAction.none,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter some text for the description';
                      } else {
                        return  null;
                      }
                    },
                    onSaved: (value) => widget.account.description = value!,
                  ),              
                ),
              ]  
            ),
            TableRow(
              children: [
                //Balance
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: TextFormField(
                    maxLength: 8,
                    decoration: InputDecoration(hintText: 'Enter Balance in ${currencySymbol}', labelText: 'Balance (${currencySymbol})'),
                    initialValue: widget.account.balance.toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.none,
                    validator: (value){
                    if(value!.isEmpty){
                      return 'please enter an account balance in (${currencySymbol})';
                    } 
                    if(double.tryParse(value) == null){
                      return 'please enter a valid number for the account balance';
                    }
                    return null;
                    },
                    onSaved: (value) => widget.account.balance = double.parse(value!), 
                  ),
                ),
                //User in Finance Facts
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: SwitchListTile(
                    
                    title: const Text('Use in Finance Facts', style: TextStyle(fontSize: 12),),
                    value: widget.account.usedForCashFlow,
                    onChanged: (bool value) {
                      setState(() {
                        widget.account.usedForCashFlow = value;
                      });
                    } 
                  ),
                ),
              ]
            ),
            TableRow(
              children: [
                //Accrued Interest
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: TextFormField(
                    maxLength: 8,
                    decoration: InputDecoration(labelText: 'Accrued Interest (${currencySymbol})'),
                    initialValue: widget.account.interestAccrued.toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.none,
                    validator: (value){
                    if(value!.isEmpty){
                      return 'please enter accrued interest in (${currencySymbol})';
                    } 
                    if(double.tryParse(value) == null){
                      return 'please enter a valid number for the accrued interest';
                    }
                    return null;
                    },
                    onSaved: (value) => widget.account.interestAccrued = double.parse(value!), 
                  ),
                ),
                //Capital Ceiling
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: TextFormField(
                    maxLength: 8,
                    decoration: InputDecoration(labelText: 'Capital Ceiling (${currencySymbol})'),
                    initialValue: widget.account.capitalCeiling.toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.none,
                    validator: (value){
                    if(value!.isEmpty){
                      return 'please enter capital ceiling in (${currencySymbol})';
                    } 
                    if(double.tryParse(value) == null){
                      return 'please enter a valid number for the capital ceiling';
                    }
                    return null;
                    },
                    onSaved: (value) => widget.account.capitalCeiling = double.parse(value!), 
                  ),
                ),
              ]
            ),                                              
            TableRow(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text('Savings', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text('Charges', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),                    
                ),
              ]  
            ),
            TableRow(
              children: [
                //Savings Rate
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextFormField(
                    maxLength: 8,
                    decoration: InputDecoration(hintText: 'Enter Rate in %', labelText: 'Saving Rate (%)'),
                    initialValue: widget.account.savingsRate.toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.none,
                    validator: (value){
                    if(value!.isEmpty){
                      return 'please enter a saving rate in (%)';
                    } 
                    if(double.tryParse(value) == null){
                      return 'please enter a valid number for the savings rate';
                    }
                    return null;
                    },
                    onSaved: (value) => widget.account.savingsRate = double.parse(value!), 
                  ),
                ),
                //Charges
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextFormField(
                    maxLength: 8,
                    decoration: InputDecoration(hintText: 'Enter Charge in ${currencySymbol}', labelText: 'Charges (${currencySymbol})'),
                    initialValue: widget.account.chargeRate.toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.none,
                    validator: (value){
                    if(value!.isEmpty){
                      return 'please enter an account balance in (${currencySymbol})';
                    } 
                    if(double.tryParse(value) == null){
                      return 'please enter a valid number for the account balance';
                    }
                    return null;
                    },
                    onSaved: (value) => widget.account.chargeRate = double.parse(value!), 
                  ),
                ),
              ]
            ), 
            TableRow(
              children: [
                showRecurrence(AccountSavingsWidget.SAVINGS_RATE),
                showRecurrence(AccountSavingsWidget.CHARGE_RATE),
              ]
            ),
            TableRow( 
              children: [ 
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text('Account Start', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                ),                            
                showDateChoice(AccountSavingsWidget.ACCOUNT_START),
                //showDateChoice(AccountSavingsWidget.CHARGE_RATE),
              ]
            ), 
            TableRow(
              children: [
                showAccounts(AccountSavingsWidget.SAVINGS_RATE),
                showAccounts(AccountSavingsWidget.CHARGE_RATE),
              ]
            ),                           
          ],
        ),        
      ),
    );
  }
// ====================================================================================================================================
  Widget showRecurrence(int type){
    
    Text text;
    ElevatedButton fb = ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        side: BorderSide(color: Colors.grey.shade800),
        primary: Colors.grey.shade400,
      ),
      child: Text('Recurrence', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showRecurrenceDialog().then((result){
          setState(() { 
            if(result != null){
              type == AccountSavingsWidget.SAVINGS_RATE ? widget.account.rateRecurrenceId = result : widget.account.chargeRecurrenceId = result;
            }                       
          });              
        });
      } 
    );  
    if((type == AccountSavingsWidget.SAVINGS_RATE && widget.account.rateRecurrenceId != RecurrenceNames.no_recurrence) || (type == AccountSavingsWidget.CHARGE_RATE && widget.account.chargeRecurrenceId != RecurrenceNames.no_recurrence)){
      Recurrence recurrence = widget.db.recurrences!.firstWhere((recurrence) => checkRecurrenceId(recurrence, type));
     text = Text(recurrence.title);
    } else {
      text = Text('No Recurrence');
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(children: [
        fb,
        text
      ],) ,
    );
  }    
  bool checkRecurrenceId(Recurrence recurrence, int type){
    if(type == AccountSavingsWidget.SAVINGS_RATE && recurrence.id == widget.account.rateRecurrenceId) return true;
    if(type == AccountSavingsWidget.CHARGE_RATE && recurrence.id == widget.account.chargeRecurrenceId) return true;
    return false;
  }
  Future<int> _showRecurrenceDialog() async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Recurrences'), // Could this be central? Why is it bold and bigger? Colour maybe
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
  // Recurrence Dialog
  List<Widget> _convertRecurrences(){ 
    List<Widget> lsdo = [];
    for(Recurrence recurrence in widget.db.recurrences!){
      lsdo.add(Row(children: <Widget>[
        SizedBox(width: 5,),
        IconListImage(recurrence.iconPath, 25),
        SizedBox(width: 3,),
        SimpleDialogOption(child: Text(recurrence.title), onPressed: () => Navigator.pop(context, recurrence.id)),                
      ],));
      lsdo.add(Divider(thickness: 1,));      
    }
    lsdo.removeLast();
    return lsdo;
  }
//=======================================================================================================================   
  Widget showDateChoice(int type){
    var formatDate = DateFormat('dd-MM-yy'); 
    Text text;
    ElevatedButton dt = ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        side: BorderSide(color: Colors.grey.shade800),
        primary: Colors.grey.shade400,
      ),
      child: Text('Start Date', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        showPick(type);
      },  
    );
    if((type == AccountSavingsWidget.ACCOUNT_START && widget.account.accountStart != null)){
      text = Text(formatDate.format(widget.account.accountStart!));
    } else {
      text = Text('No date');
    }   
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        dt,
        text,
      ],), );      
  }
  void showPick(int type){
    FocusScope.of(context).unfocus();
    showDatePicker(
      context: context,
      initialDate: widget.account.accountStart?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2050), 
    ).then((pickedate){
      setState(() {
        if(pickedate != null){
          widget.account.accountStart = DateTime(pickedate.year, pickedate.month, pickedate.day);          
        }
      });
    });        
  }   
//=======================================================================================================================
  Widget showAccounts(int type){
    
    Text text;
    ElevatedButton fb = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade800),
        foregroundColor: Colors.grey.shade400,
      ),
      child: Text('Accounts', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        _showAccountDialog().then((result){
          setState(() { 
            if(result != null){
              type == AccountSavingsWidget.SAVINGS_RATE ? widget.account.savingsAccountId = result : widget.account.chargeAccountId = result;
            }                       
          });              
        });
      } 
    );  
    if((type == AccountSavingsWidget.SAVINGS_RATE && widget.account.savingsAccountId != AccountNames.no_account) || (type == AccountSavingsWidget.CHARGE_RATE && widget.account.chargeAccountId != AccountNames.no_account)){
      Account account = widget.db.accounts!.firstWhere((account) => checkAccountId(account, type));
      text = Text(account.accountName);
    } else {
      text = Text(widget.account.accountName);
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        fb,
        text
      ],) ,
    );
  }    
  bool checkAccountId(Account account, int type){
    if(type == AccountSavingsWidget.SAVINGS_RATE && account.id == widget.account.savingsAccountId) return true;
    if(type == AccountSavingsWidget.CHARGE_RATE && account.id == widget.account.chargeAccountId) return true;
    return false;
  }
  Future<int> _showAccountDialog() async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Accounts'), // Could this be central? Why is it bold and bigger? Colour maybe
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
      lsdo.add(Row(children: <Widget>[
        SizedBox(width: 5,),
        IconListImage(accountTypeIconPath(account)!, 25),
        SizedBox(width: 3,),
        SimpleDialogOption(child: Text(account.accountName), onPressed: () => Navigator.pop(context, account.id),),                
      ],));
      lsdo.add(Divider(thickness: 1,));      
    }
    if(lsdo.isNotEmpty) lsdo.removeLast();
    return lsdo;
  } 
  String? accountTypeIconPath(Account account){
    if(account is AccountSavings){
      return widget.db.accountTypes![AccountTypesNames.savingAccount - 1].iconPath;
    } else if (account is Account){
      return widget.db.accountTypes![AccountTypesNames.plainAccount - 1].iconPath;
    }
    return null;
  }     
}