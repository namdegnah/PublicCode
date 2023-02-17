import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData blueLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  textTheme: GoogleFonts.ralewayTextTheme(
    ThemeData.light().textTheme.copyWith(
      headline1: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
      headline2: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue.shade800),
      headline3: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue.shade900),
      bodyText1: const TextStyle(fontSize: 12,),
      bodyText2: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
    ),
  ),
  colorScheme: ColorScheme(
    primary: Colors.blue,
    onPrimary: Colors.black,
    primaryVariant: Colors.blue.shade800,

    background: Colors.white,
    onBackground: Colors.black,

    error: Colors.red,
    onError: Colors.white,

    secondary: Colors.blue.shade500,
    secondaryVariant: Colors.blue.shade900,
    onSecondary: Colors.black,

    surface: Colors.blue,
    onSurface: Colors.black,

    brightness: Brightness.light,
  ),  
  appBarTheme: AppBarTheme(
    titleTextStyle: lightBlueAppBar,
    toolbarTextStyle: lightBlueAppBar,
    color: Colors.blue,
  ),          
);
final TextStyle lightBlueAppBar = GoogleFonts.openSans(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.normal,
);