import 'package:flutter/material.dart';
import '../enums.dart';
import '../buttons/elevated_buttons.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: 'Quicksand',
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.purple,
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtons(type: ElevatedButtons.lightMode),),
  textTheme: ThemeData.light().textTheme.copyWith(
    headline1: const TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 18,),
    headline2: const TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 16,),  
    headline3: const TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 14,),   
    bodyText1: const TextStyle(fontFamily: 'OpenSans',fontSize: 12,),   
    bodyText2: const TextStyle(fontFamily: 'Quicksand',fontSize: 12,),           
  ),
  appBarTheme: const AppBarTheme(    
    toolbarTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFA726)),
    color: Color(0xFF546E7A),
  ),
);


