import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../buttons/elevated_buttons.dart';
import '../enums.dart';

final ThemeData greenLightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.green,
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtons(type: ElevatedButtons.darkMode),),
  textTheme: GoogleFonts.ralewayTextTheme(
    ThemeData.light().textTheme.copyWith(
      headline1: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
      headline2: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green.shade800),
      headline3: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green.shade900),
      bodyText1: const TextStyle(fontSize: 12,),
      bodyText2: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green.shade700),
    ),
  ),
  colorScheme: ColorScheme(
    primary: Colors.green, //The color displayed most frequently across your app’s screens and components.
    onPrimary: Colors.black, //A color that's clearly legible when drawn on primary
    primaryVariant: Colors.green.shade800, //A darker version of the primary color.

    background: Colors.white, //A color that typically appears behind scrollable content.
    onBackground: Colors.black,

    error: Colors.red, //The color to use for input validation errors,
    onError: Colors.white,

    secondary: Colors.green.shade500, //An accent color that, when used sparingly, calls attention to parts of your app.
    onSecondary: Colors.black,
    secondaryVariant: Colors.green.shade900,

    surface: Colors.green, //The background color for widgets like Card.
    onSurface: Colors.black,

    brightness: Brightness.light, //The overall brightness of this color scheme.

  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: lightGreenAppBar,    
    toolbarTextStyle: lightGreenAppBar,
    color: Colors.green,
  ),    
);

final TextStyle lightGreenAppBar = GoogleFonts.openSans(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.normal,
);