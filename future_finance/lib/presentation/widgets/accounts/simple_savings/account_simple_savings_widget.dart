import 'package:flutter/material.dart';
import '../../../../domain/entities/accounts/account_simple_savings.dart';
import '../../../../domain/entities/accounts/account_add_interest.dart';
import '../../../../domain/entities/recurrence.dart';
import '../../../config/injection_container.dart';
import '../../../../data/models/dialog_base.dart';
import '../../../config/constants.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/setting.dart';
import 'account_simple_widgets.dart';

class AccountSimpleSavingsWidget extends StatefulWidget {
  final AccountSimpleSavings account;
  final GlobalKey<FormState> form;
  final DialogBase db;  
  static int SAVINGS_RATE = 10;
  static int CHARGE_RATE = 20;
  static int ACCOUNT_START = 30;
  static int ACCOUNT_END = 40;

  AccountSimpleSavingsWidget(this.account, this.form, this.db);

  @override
  _AccountSimpleSavingsWidgetState createState() => _AccountSimpleSavingsWidgetState();
}

class _AccountSimpleSavingsWidgetState extends State<AccountSimpleSavingsWidget> {
  


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
                showAddInterest(),
                showRecurrence(),
              ]
            ),
            TableRow( 
              children: [ 
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text('Account Start', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                ),                            
                showDateChoice(AccountSimpleSavingsWidget.ACCOUNT_START),
              ]
            ),  
            TableRow( 
              children: [ 
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text('Account End\n ongoing don\'t set', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                ),                            
                showDateChoice(AccountSimpleSavingsWidget.ACCOUNT_END),
              ]
            ),                                                  
          ],
        ),        
      ),
    );
  }
// ====================================================================================================================================
  Widget showRecurrence(){
    
    Text text;
    ElevatedButton fb = ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade800),
        backgroundColor: Colors.grey.shade400,
      ),
      child: Text('Recurrence', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        showRecurrenceDialog(context, widget.db.recurrences!).then((result){
          setState(() { 
            if(result != null){
              widget.account.chargeRecurrenceId = result;
            }                       
          });              
        });
      } 
    );  
    if(widget.account.chargeRecurrenceId != RecurrenceNames.no_recurrence){
      Recurrence recurrence = widget.db.recurrences!.firstWhere((recurrence) => checkRecurrenceId(recurrence));
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
  bool checkRecurrenceId(Recurrence recurrence){
    if(recurrence.id == widget.account.chargeRecurrenceId) return true;
    return false;
  }
//======================================================================================================================= 
  Widget showAddInterest(){
    
    Text text;
    ElevatedButton fb = ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade800),
        backgroundColor: Colors.grey.shade400,
      ),
      child: Text('Add Interest', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        showAddInterestDialog(context, widget.db.addInterests!).then((result){
          setState(() { 
            if(result != null){
              widget.account.addInterestId = result;
            }                       
          });              
        });
      } 
    );  
    if(widget.account.addInterestId != AddInterestNames.no_add_interest){
      AddInterest addInterest = widget.db.addInterests!.firstWhere((interest) => checkAddInterestId(interest));
     text = Text(addInterest.title);
    } else {
      text = Text('No Add Interest');
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(children: [
        fb,
        text
      ],) ,
    );
  }    
  bool checkAddInterestId(AddInterest interest){
    if(interest.id == widget.account.addInterestId) return true;
    return false;
  }  
//=======================================================================================================================   
  Widget showDateChoice(int type){
    var formatDate = DateFormat('dd-MM-yy'); 
    Text text;
    ElevatedButton dt = ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade800),
        backgroundColor: Colors.grey.shade400,
      ),
      child: type == AccountSimpleSavingsWidget.ACCOUNT_START 
        ? Text('Start Date', style: TextStyle(fontWeight: FontWeight.bold)) 
        : Text('End Date', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: (){
        showPick(type);
      },  
    );
    if((type == AccountSimpleSavingsWidget.ACCOUNT_START && widget.account.accountStart != null)){
      text = Text(formatDate.format(widget.account.accountStart!));
    } else if(type == AccountSimpleSavingsWidget.ACCOUNT_END && widget.account.accountEnd != null) {
      text = Text(formatDate.format(widget.account.accountEnd!));
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
      lastDate: DateTime(DateTime.now().year + 30), 
    ).then((pickedate){
      setState(() {
        if(pickedate != null){
          if(type == AccountSimpleSavingsWidget.ACCOUNT_START){
            widget.account.accountStart = DateTime(pickedate.year, pickedate.month, pickedate.day);
          } else if (type == AccountSimpleSavingsWidget.ACCOUNT_END){
            widget.account.accountEnd = DateTime(pickedate.year, pickedate.month, pickedate.day);
          }
                    
        }
      });
    });        
  }   
//=======================================================================================================================

}