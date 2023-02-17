import 'package:flutter/material.dart';
import '../../../domain/entities/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/settings/setting_bloc_exports.dart';
import '../../config/constants.dart';
import 'package:intl/intl.dart';

class EndDateOptions extends StatelessWidget {

  final Setting setting;

  EndDateOptions({required this.setting});

  void showPick(BuildContext context, Setting setting) {
    showDatePicker(
      context: context,
      initialDate: setting.endDate,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),          
      lastDate: DateTime(2050),
    ).then((pickedate) {
      if (pickedate != null){
        setting.endDate = DateTime(pickedate.year, pickedate.month, pickedate.day);
        SettingBloc sb = BlocProvider.of<SettingBloc>(context);
        sb.add(UpdateEndDateSetting(user_id: setting.user_id, setting_id: UserSettingNames.setting_endDate, time: setting.endDate)); 
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var formatDate = DateFormat('dd-MM-yy');
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: 'When you run the facts run it can run to a specific ',
            style: ColourScheme.st,
            children: <TextSpan>[
              TextSpan(text: 'date', style: ColourScheme.stb),
              TextSpan(text: ' this can be years ahead or any', style: ColourScheme.stb),
              TextSpan(text: ' date', style: ColourScheme.stb),
              TextSpan(text: ' you want. Often a couple of years is sufficient ', style: ColourScheme.st),
              TextSpan(text: ' ,however,', style: ColourScheme.stb),
              TextSpan(text: ' you can choose any date you feel appropriate.\n\n ', style: ColourScheme.st),
              TextSpan(text: 'The date', style: ColourScheme.stb),
              TextSpan(text: ' must be in the future. ', style: ColourScheme.st),
              TextSpan(text: 'The default is ', style: ColourScheme.st),
              TextSpan(text: 'one year ahead ', style: ColourScheme.st),
            ]
          ),
        ),
        Divider(thickness: 2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            showSetting(setting, formatDate),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => showPick(context, setting),
            ),
          ],
        ),        
        ],),
      ),
    );
  }
  Widget showSetting(Setting setting, DateFormat formatDate){
    return Text(
      'Finish Date: ${formatDate.format(setting.endDate)}',
      style: TextStyle(fontSize: 14),
      );
  }  
}