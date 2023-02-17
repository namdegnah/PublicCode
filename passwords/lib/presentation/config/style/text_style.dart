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
TextStyle start = GoogleFonts.roboto(fontSize: 12, color: simplyBlack, fontWeight: FontWeight.normal);
TextStyle customerData = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w600);
TextStyle dashboardHi20 = GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.5, height: 1.4, color: dashboardHi);
TextStyle dropdownList = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, color: simplyBlack);
TextStyle buttonText = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1,);
TextStyle wizardStep = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: dashboardHi);
TextStyle wizardName = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w800, color: dashboardHi);
TextStyle wizardDescription = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: dashboardHi);
TextStyle unfocussed = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, color: simplyWhite, height: 1, letterSpacing: 1.2);