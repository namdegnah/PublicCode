import 'package:flutter/material.dart';
import '../../../domain/entities/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/settings/setting_bloc_exports.dart';
import '../../config/constants.dart';

class CurrencyOptions extends StatelessWidget {

  final Setting setting;

  CurrencyOptions({required this.setting});

  @override
  Widget build(BuildContext context) {
    var c_text = Currencies.currencyTerm(setting.currency);
    var c_value = Currencies.currencyValue(setting.currency);    
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'The App shows a currency symbol for your account\’s balance, transfers and transactions. You can select from ',
              style: ColourScheme.st,
              children: <TextSpan>[
                TextSpan(text: 'Dollar', style: ColourScheme.stb),
                TextSpan(text: ' (', style: ColourScheme.st),
                TextSpan(text: '\u0024', style: ColourScheme.str),
                TextSpan(text: ') or '),
                TextSpan(text: 'Pound', style: ColourScheme.stb),
                TextSpan(text: ' (', style: ColourScheme.st),
                TextSpan(text: '\u00A3', style: ColourScheme.str),
                TextSpan(text: ') or '),
                TextSpan(text: 'Yen', style: ColourScheme.stb),
                TextSpan(text: ' (', style: ColourScheme.st),
                TextSpan(text: '\u00A5', style: ColourScheme.str),
                TextSpan(text: ') or '),
                TextSpan(text: 'Euro', style: ColourScheme.stb),
                TextSpan(text: ' (', style: ColourScheme.st),
                TextSpan(text: '\u20AC', style: ColourScheme.str),
                TextSpan(text: ')\n\n'),
                TextSpan(text: 'Your current choice is ', style: ColourScheme.st),
                TextSpan(text: c_text, style: ColourScheme.stb),
                TextSpan(text: ' (', style: ColourScheme.st),
                TextSpan(text: c_value, style: ColourScheme.str),
                TextSpan(text: ')', style: ColourScheme.st),               
              ],
            ),
          ),
          Row(children: <Widget>[
            Text('Choose your currency', style: ColourScheme.st,),
            SizedBox(width: 10,),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (value){
                setting.currency = value as int;
                SettingBloc sb = BlocProvider.of<SettingBloc>(context);
                sb.add(UpdateUserSetting(user_id: setting.user_id, setting_id: UserSettingNames.setting_currency, value: setting.currency));
              },
              itemBuilder: (_) => Currencies.getCurrencyItems(),          
            ),           
          ],)        
        ],),
      ),
    );
  }
}