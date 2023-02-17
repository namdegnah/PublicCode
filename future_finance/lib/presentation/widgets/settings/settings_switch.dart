import 'package:flutter/cupertino.dart';
import '../../bloc/settings/setting_bloc_exports.dart';
import '../../config/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void settings_switch({required int option, required int user_id, required BuildContext context}){

  switch(option){
    case(UserSettingNames.setting_bar_chart):
      BlocProvider.of<SettingBloc>(context).add(BarChartEvent(user_id: user_id));
      break;
    case(UserSettingNames.setting_auto_archive):
      BlocProvider.of<SettingBloc>(context).add(GetUserSettings(id: user_id));
      break;
    case(UserSettingNames.setting_currency):
      BlocProvider.of<SettingBloc>(context).add(GetUserSettings(id: user_id));    
      break;
    case(UserSettingNames.setting_endDate):
      BlocProvider.of<SettingBloc>(context).add(GetUserSettings(id: user_id));
      break;
    case(UserSettingNames.setting_auto_process):
      BlocProvider.of<SettingBloc>(context).add(GetUserSettings(id: user_id));
      break;
    default:
      BlocProvider.of<SettingBloc>(context).add(GetUserSettings(id: user_id));
      break;
  }  
}