import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData greenDarkTheme = ThemeData(
  primaryColor: Colors.green.shade900,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.dark().textTheme.copyWith(
      headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green.shade100),
      headline2: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green.shade200),
      headline3: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green.shade300),
      bodyText1: const TextStyle(fontSize: 12,),
      bodyText2: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green.shade200),
    ),
  ),
  colorScheme: ColorScheme(
    primary: Colors.green.shade900,
    onPrimary: Colors.white,
    primaryVariant: Colors.green.shade800,

    background: Colors.black87,
    onBackground: Colors.white,

    error: Colors.red,
    onError: Colors.white,

    secondary: Colors.green.shade500,  
    onSecondary: Colors.white,

    surface: Colors.green.shade900,
    onSurface: Colors.white,

    brightness: Brightness.dark,

    secondaryVariant: Colors.green.shade900,

  ),   
  appBarTheme: AppBarTheme(
    titleTextStyle: darkGreenAppBar,    
    toolbarTextStyle: darkGreenAppBar,
    color: Colors.green.shade900,
  ),         
);
final TextStyle darkGreenAppBar = GoogleFonts.openSans(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.normal,
);