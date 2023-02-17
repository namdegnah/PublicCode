import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData blueDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue.shade900,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.dark().textTheme.copyWith(
      headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue.shade100),
      headline2: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue.shade200),
      headline3: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue.shade300),
      bodyText1: const TextStyle(fontSize: 12,),
      bodyText2: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue.shade200),
    ),
  ),
  colorScheme: ColorScheme(
    primary: Colors.blue.shade900,
    onPrimary: Colors.white,
    primaryVariant: Colors.blue.shade800,

    background: Colors.black87,
    onBackground: Colors.white,

    error: Colors.red,
    onError: Colors.white,

    secondary: Colors.blue.shade500,
    onSecondary: Colors.white,
    secondaryVariant: Colors.blue.shade900,

    surface: Colors.blue.shade900,
    onSurface: Colors.white,

    brightness: Brightness.dark,    
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: darkBlueAppBar,    
    toolbarTextStyle: darkBlueAppBar,
    color: Colors.blue.shade900,
  ),         
);
final TextStyle darkBlueAppBar = GoogleFonts.openSans(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.normal,
);