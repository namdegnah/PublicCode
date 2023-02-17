import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../bloc/settings/setting_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingSendEvent extends StatelessWidget {
  late int _user_id;
  late int _option;
  SettingSendEvent({required int user_id, required int option}){
    _user_id = user_id;
    _option = option;
  }
  
  late SettingBloc sb;
    
  @override
  Widget build(BuildContext context) {
    
    sb = BlocProvider.of<SettingBloc>(context);
    switch(_option){
      case(UserSettingNames.setting_bar_chart):
        sb.add(BarChartEvent(user_id: _user_id));
        break;
      case(UserSettingNames.setting_auto_archive):
        sb.add(GetUserSettings(id: _user_id));
        break;
      case(UserSettingNames.setting_currency):
        sb.add(GetUserSettings(id: _user_id));      
        break;
      case(UserSettingNames.setting_endDate):
        sb.add(GetUserSettings(id: _user_id));
        break;
      default:
        sb.add(GetUserSettings(id: _user_id));
        break;
    }
       
    return const SizedBox(height: 1);      
  }
}