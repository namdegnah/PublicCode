import 'package:flutter/material.dart';
import 'excel_paint_bar.dart';
import '../../../data/models/facts_base.dart';
import '../../config/injection_container.dart';
import 'bar_loader.dart';
import '../../config/constants.dart';
import '../../../domain/entities/setting.dart';
import '../../../domain/entities/accounts/account.dart';

class ExcelAnimator extends StatefulWidget {
  final FactsBase factsbase;
  
  ExcelAnimator({required this.factsbase});

  @override
  _ExcelAnimatorState createState() => _ExcelAnimatorState();
}

class _ExcelAnimatorState extends State<ExcelAnimator>  with SingleTickerProviderStateMixin {

  double _heightFraction = 0.0;
  
  late Animation<double> heightAnimation;
  late AnimationController controller;

  @override
  void initState() {
    try{
      controller = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
      heightAnimation = Tween(begin: 0.00, end: 1.0).animate(controller)
        ..addListener(() {
          setState(() {
            _heightFraction = heightAnimation.value;
          });
        });
      controller.forward();              
      super.initState();
    } on Exception catch(error){
      throw error;
    }
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {   
    try{
      late List<BarLoader> loaders;
      int accountId = sl<Setting>().barChart; //find the account for BarChart
      if(accountId == SettingNames.barChartTotal){
        loaders = widget.factsbase.total.loaders;
      } else {
        Account _account = widget.factsbase.accounts.firstWhere((account) => account.id == accountId, orElse: () => Account.noAccount());
        if(!_account.isNoAccount()){
          loaders = _account.loaders;
        }
      }
      if(loaders.isNotEmpty){
        return CustomPaint(painter: ExcelPaintBar(_heightFraction, loaders),);
      } else {
        return const SizedBox(height: 1);
      }
    } on Exception catch(error){
      return Column(
        children: <Widget>[
          Text(error.toString(), overflow: TextOverflow.visible),
        ],
      );
    }

  }
}
