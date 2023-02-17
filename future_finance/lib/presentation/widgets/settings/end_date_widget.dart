import '../../widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import '../../config/constants.dart';
import 'end_date_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/settings/setting_bloc_exports.dart';

import 'settings_switch.dart';

class EndDateWidget extends StatefulWidget {
  EndDateWidget();

  @override
  _EndDateWidgetState createState() => _EndDateWidgetState();
}

class _EndDateWidgetState extends State<EndDateWidget> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Facts Run End Date'),
      ),
      body: buildBody(context),
    );
    return scaffold;
  }
}
Builder buildBody(BuildContext context){
  int _user_id = getCurrentUserId();
  settings_switch(option: UserSettingNames.setting_endDate, user_id: _user_id, context: context);
  return Builder(
    builder: (context){
      final userState = context.watch<SettingBloc>().state;
      if(userState is ReturnSetting){        
        return EndDateOptions(setting: userState.setting,);       
      } else if (userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      }
      return Center(child: CircularProgressIndicator(),);
    }
  );
}