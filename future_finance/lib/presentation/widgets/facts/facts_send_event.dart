import 'package:flutter/material.dart';
import '../../bloc/facts/facts_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pages/paint/scaler.dart';

class FactsSendEvent extends StatelessWidget {

  static int portrait = 4;
  static int landscape = 12;

  FactsSendEvent();
    
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.portrait){
      Scaler.noMonths = portrait;
      Scaler.setBarDetails((MediaQuery.of(context).size.width).ceil(), (MediaQuery. of(context).size.height).ceil());
    } else {
      Scaler.noMonths = landscape;
      Scaler.setBarDetails((MediaQuery.of(context).size.height).ceil(), (MediaQuery. of(context).size.width).ceil());
    }    
    FactsBloc fb = BlocProvider.of<FactsBloc>(context);
    
    fb.add(RunPauseEvent());  
    
    return const SizedBox(height: 1);      
  }
}