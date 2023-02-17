  import 'package:flutter/material.dart';
  import '../buttons/elevated_buttons.dart';
  import '../enums.dart';
  import 'package:google_fonts/google_fonts.dart';

  final lightTheme =  ThemeData(
    fontFamily: 'Quicksand',
    primaryColor: Colors.lightBlue,
    primarySwatch: Colors.lightBlue,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtons(type: ElevatedButtons.lightMode),),
    textTheme: GoogleFonts.ralewayTextTheme(
      ThemeData.light().textTheme.copyWith(
        headline1: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        headline2: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        headline3: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
        bodyText1: const TextStyle(fontSize: 12,),
        bodyText2: const TextStyle(fontSize: 10,),
      ),
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
  