import 'package:flutter/material.dart';
import '../../../domain/entities/setting.dart';
import '../../config/style/app_colours.dart';
import '../../config/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/settings/setting_bloc_exports.dart';

class ArchiveWidgetOptions extends StatelessWidget {
  final Setting setting;

  ArchiveWidgetOptions({required this.setting});

  @override
  Widget build(BuildContext context) {
    double gap = 80.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  text: 'Transactions and Transfers can ',
                  style: ColourScheme.st,
                  children: <TextSpan>[
                    TextSpan(text: 'expire', style: ColourScheme.stb),
                    TextSpan(
                        text: ', and upon expiring they can be automatically ',
                        style: ColourScheme.stb),
                    TextSpan(text: 'archived', style: ColourScheme.stb),
                    TextSpan(
                        text:
                            '. For example, if you have a transaction for a product then when this is paid the transaction has  ',
                        style: ColourScheme.st),
                    TextSpan(text: 'expired', style: ColourScheme.stb),
                    TextSpan(
                        text:
                            '.\n\nAnother example is a car loan, during the payment period the transaction is ',
                        style: ColourScheme.st),
                    TextSpan(text: 'valid', style: ColourScheme.stb),
                    TextSpan(
                        text:
                            ', but upon the final payment this recurring transaction ',
                        style: ColourScheme.stb),
                    TextSpan(text: 'expires', style: ColourScheme.stb),
                    TextSpan(text: '.\n\nAutomatic archive ', style: ColourScheme.st),
                    TextSpan(text: 'hides', style: ColourScheme.stb),
                    TextSpan(text: '  all transactions and transfers that have expired. It is recommended to leave this setting ', style: ColourScheme.st),
                    TextSpan(text: 'on', style: ColourScheme.stb),
                    TextSpan(text: '.\n\n', style: ColourScheme.st),
                    TextSpan(text: 'Automatic archive is also linked to ', style: ColourScheme.st),
                    TextSpan(text: 'Automatic Processing', style: ColourScheme.stb),
                    TextSpan(text: ' where transfers and transactions are processed since you last ran the App. As such, when you open your app, it is up to date and the only transactions and transfers you see are current and affect your ', style: ColourScheme.st),
                    TextSpan(text: 'financial future', style: ColourScheme.stb),
                    TextSpan(text: '.', style: ColourScheme.st),
                    
                  ]),
            ),
            SwitchListTile(
              title: const Text('Automatic Archive'),
              subtitle: const Text('No is left, Yes is right'),
              value: setting.autoArchive == SettingNames.userArchiveTrue,                  
              onChanged: (bool value) {               
                setting.autoArchive = value == true
                  ? SettingNames.userArchiveTrue
                  : SettingNames.userArchiveFalse;
                SettingBloc sb = BlocProvider.of<SettingBloc>(context);
                sb.add(UpdateUserSetting(user_id: setting.user_id, setting_id: UserSettingNames.setting_auto_archive, value: setting.autoArchive));                
              },
            ),
        ],),
      );
    
  
    

  





  }
}