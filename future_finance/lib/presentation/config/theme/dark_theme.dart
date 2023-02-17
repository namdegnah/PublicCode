import 'package:flutter/material.dart';
import '../buttons/elevated_buttons.dart';
import '../enums.dart';
  import 'package:google_fonts/google_fonts.dart';

  final darkTheme = ThemeData(
    fontFamily: 'Quicksand',
    primaryColor: Colors.black,
    primarySwatch: Colors.blueGrey,
    backgroundColor: Colors.grey,
    scaffoldBackgroundColor: Colors.grey,
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtons(type: ElevatedButtons.darkMode),),
    textTheme: GoogleFonts.openSansTextTheme(
      ThemeData.dark().textTheme.copyWith(
        headline1: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        headline2: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        headline3: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
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
  