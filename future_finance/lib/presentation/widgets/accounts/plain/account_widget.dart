import 'package:flutter/material.dart';
import '../../../../domain/entities/accounts/account.dart';
import '../../../config/injection_container.dart';
import '../../../config/constants.dart';
import '../../../../domain/entities/setting.dart';


class AccountWidget extends StatefulWidget {
  final Account account;
  final GlobalKey<FormState> form;
  final Function saveF;
  AccountWidget(this.account, this.form, this.saveF);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  @override
  Widget build(BuildContext context) {

    String currencySymbol =Currencies.currencyValue(sl<Setting>().currency);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: widget.form,
        child: ListView(
          children: <Widget>[
            // Account Name
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
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
            // Account Description
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 80,
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
            // Balance
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
                    decoration: InputDecoration(hintText: 'Enter Balance in ${currencySymbol}', labelText: 'Account Balance (${currencySymbol})'),
                    initialValue: widget.account.balance.toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.none,
                    onFieldSubmitted: (_) => widget.saveF(context),
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
              ],),
            ),
            // Use in Finance Facts
            SwitchListTile(
              title: const Text('Use in Finance Facts'),
              value: widget.account.usedForCashFlow,
              subtitle: const Text('Include or Exclude from the Facts run'),
              onChanged: (bool value) {
                setState(() {
                  widget.account.usedForCashFlow = value;
                });
              } 
            ),
          ],
        ),
      ),
    );
  }
}