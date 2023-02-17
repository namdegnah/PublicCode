import '../../widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'bar_chart_options_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/settings/setting_bloc_exports.dart';
import '../../config/constants.dart';
import 'settings_switch.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget();

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Bar Chart Options'),
      ),
      body: buildBody(context),
    );
    return scaffold;
  }
}
  Builder buildBody(BuildContext context){
    int _user_id = getCurrentUserId();
    settings_switch(option: UserSettingNames.setting_bar_chart, user_id: _user_id, context: context);
    return Builder(
      builder: (context){
        final userState = context.watch<SettingBloc>().state;
        if(userState is BarChartState){        
          return BarChartOptionsWidget(accounts: userState.dialogBase.accounts!, setting: userState.dialogBase.setting!,);        
        } else if (userState is Loading){
          return Center(child: CircularProgressIndicator(),);
        }
        return Center(child: CircularProgressIndicator(),);
      }
    );
  }