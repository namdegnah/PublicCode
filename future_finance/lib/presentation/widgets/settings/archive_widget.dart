import '../../widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import '../../config/constants.dart';
import 'archive_widget_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/settings/setting_bloc_exports.dart';
import 'settings_switch.dart';

class ArchiveWidget extends StatefulWidget {
  ArchiveWidget();

  @override
  _ArchiveWidgetState createState() => _ArchiveWidgetState();
}

class _ArchiveWidgetState extends State<ArchiveWidget> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Archive Options'),
      ),
      body: buildBody(context),
    );
    return scaffold;
  }
}
Builder buildBody(BuildContext context){
  int _user_id = getCurrentUserId();
  settings_switch(option: UserSettingNames.setting_auto_archive, user_id: _user_id, context: context);
  return Builder(
    builder: (context){
      final userState = context.watch<SettingBloc>().state;
      if(userState is ReturnSetting){        
        return ArchiveWidgetOptions(setting: userState.setting,);       
      } else if (userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      }
      return Center(child: CircularProgressIndicator(),);
    }
  );
}
