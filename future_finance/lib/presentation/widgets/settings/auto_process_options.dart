import 'package:flutter/material.dart';
import '../../../domain/entities/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/settings/setting_bloc_exports.dart';
import '../../config/constants.dart';

class AutoProcessOptions extends StatelessWidget {

  final Setting setting;

  AutoProcessOptions({required this.setting});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'When you open the',
              style: ColourScheme.st,
              children: <TextSpan>[
                TextSpan(text: 'App', style: ColourScheme.stb),
                TextSpan(text: ' it finds the last', style: ColourScheme.stb),
                TextSpan(text: ' day', style: ColourScheme.stb),
                TextSpan(text: ' you used it. It can then ', style: ColourScheme.st),
                TextSpan(text: 'process', style: ColourScheme.stb),
                TextSpan(text: ' all the transactions and transfers from this date and ', style: ColourScheme.st),
                TextSpan(text: 'update', style: ColourScheme.stb),
                TextSpan(text: ' the account\'s balances. This means when you open the app it shows ', style: ColourScheme.stb),
                TextSpan(text: 'today\’s account\’s balances.\n\n', style: ColourScheme.stb),
                TextSpan(text: 'This can be turned ', style: ColourScheme.st),
                TextSpan(text: 'off', style: ColourScheme.stb),
                TextSpan(text: ' on this screen. This means when you open the app it shows the balance of your accounts and all future transactions and transfers. This gives you total control and you can amend the account\’s balance ', style: ColourScheme.st),
                TextSpan(text: 'manually', style: ColourScheme.stb),
                TextSpan(text: '.', style: ColourScheme.st),
              ]
            ),
          ),
        // Divider(thickness: 2,),
          SwitchListTile(
            title: const Text('Auto Process since last use'),
            subtitle: const Text('No is left, Yes is right'),
            value: setting.autoProcess == SettingNames.autoProcessedTrue, 
            onChanged: (bool value) {
              setting.autoProcess = value == true ? SettingNames.autoProcessedTrue : SettingNames.autoProcessedFalse;
              SettingBloc sb = BlocProvider.of<SettingBloc>(context);
              sb.add(UpdateUserSetting(user_id: setting.user_id, setting_id: UserSettingNames.setting_auto_process, value: setting.autoProcess));              
            },
          ),
        ],),
      ),
    );
  }
}