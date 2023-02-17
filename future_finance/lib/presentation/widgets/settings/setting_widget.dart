import 'package:flutter/material.dart';
import 'setting_widget_export.dart';
//import '../../../injection_container.dart';
import 'archive_widget.dart';
import 'auto_process_widget.dart';
import 'currency_widget.dart';
import 'end_date_widget.dart';

class SettingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double iconSize = 45;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.black26),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                ;
              },
            ),
          ],
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 255,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Settings',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/settings.png'),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SettingListTile(
              titleText: 'Auto Process Upon Launch',
              leadingImage: Image.asset('assets/images/settings/auto_process2.png',fit: BoxFit.fitHeight,height: iconSize,),
              editSetting: autoProcess,
            ),
            SettingListTile(
              titleText: 'Automatic Archive',
              leadingImage: Image.asset(
                'assets/images/settings/archive.png',
                fit: BoxFit.fitHeight,
                height: iconSize,
              ),
              editSetting: automaticArchive,
            ),
            SettingListTile(
              titleText: 'Bar Chart Options',
              leadingImage: Image.asset('assets/images/settings/bar_chart.png',fit: BoxFit.fitHeight,height: iconSize,),
              editSetting: barChart,
            ),
            SettingListTile(
              titleText: 'Mortgage Calculator',
              leadingImage: Image.asset(
                'assets/images/settings/mortgage_calculator.png',
                fit: BoxFit.fitHeight,
                height: iconSize,
              ),
              editSetting: mortgageCalculator,
            ),
            // SettingListTile(
            //   titleText: 'Backup and Restore',
            //   leadingImage: Image.asset(
            //     'assets/images/settings/backup.png',
            //     fit: BoxFit.fitHeight,
            //     height: iconSize,
            //   ),
            //   editSetting: backupRestore,
            // ),
            SettingListTile(
              titleText: 'Facts Run End Date',
              leadingImage: Image.asset(
                'assets/images/settings/calendar.gif',
                fit: BoxFit.fitHeight,
                height: iconSize,
              ),
              editSetting: factsRunEndDate,
            ),
            SettingListTile(
              titleText: 'Currency',
              leadingImage: Image.asset(
                'assets/images/settings/currency-symbol.png',
                fit: BoxFit.fitHeight,
                height: iconSize,
              ),
              editSetting: curencyChoice,
            ),
            //Widget
          ]),
        ),
      ],
    );
  }

  void autoProcess(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AutoProcessWidget()));           
  }

  void barChart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => BarChartWidget()));         
  }
  void mortgageCalculator(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MortgageCalculatorWidget()));        
  }

  // Function backupRestore(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => BackupRestoreWidget()));         
  // }

  void factsRunEndDate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => EndDateWidget()));
  }

  void curencyChoice(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute( builder: (_) => CurrencyWidget()));         
  }

  void automaticArchive(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ArchiveWidget()));            
  }
}
