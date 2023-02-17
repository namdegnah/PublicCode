import 'package:flutter/material.dart';
import '../../pages/paint/scaler.dart';

void set_scaler(BuildContext context){
    final int portrait = 4;
    final  int landscape = 12;
    Orientation orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.portrait){
      Scaler.noMonths = portrait;
      Scaler.setBarDetails((MediaQuery.of(context).size.width).ceil(), (MediaQuery. of(context).size.height).ceil());
    } else {
      Scaler.noMonths = landscape;
      Scaler.setBarDetails((MediaQuery.of(context).size.height).ceil(), (MediaQuery. of(context).size.width).ceil());
    }
}