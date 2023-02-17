import 'package:flutter/material.dart';
import 'app_colours.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle anyStyle({
  required TextStyle start,
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  double? letterSpacing,
  double? height,
  double? decorationThickness,
  Color? decorationColor,
  List<Shadow>? shadows,
}){
  start = start.copyWith(color: color);
  start = start.copyWith(fontSize: fontSize);
  start = start.copyWith(fontWeight: fontWeight);
  start = start.copyWith(decoration: decoration);
  start = start.copyWith(letterSpacing: letterSpacing);
  start = start.copyWith(height: height);
  start = start.copyWith(decorationThickness: decorationThickness);
  start = start.copyWith(decorationColor: decorationColor);
  start = start.copyWith(shadows: shadows);
  return start;
}

TextStyle customerData = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w600);
TextStyle dashboardHi20 = GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.5, height: 1.4, color: dashboardHi);
TextStyle stb = TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal, shadows: [Shadow(color: Colors.black26, offset: Offset(1.0, 1.0), blurRadius: 1.0)]);
    