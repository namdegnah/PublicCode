import 'package:flutter/material.dart';
import '../config/style/app_colours.dart';
import '../config/style/text_style.dart';

double innerCircleDiameter = 8;
double statusRectangleWidth = 100;
double statusRectangleHeight = 24;
const int largeScreenSize = 1366;
const int mediumScreenSize = 790;
const int smallScreenSize = 500;
const int customScreenSize = 1000;
const int mobileScreenSize = 499;
int pending = 1;

Widget routeLink({
  required String text,
  required Future<void> Function()? onTap,
  TextStyle? linkStyle,
  }){
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: linkStyle == null ? Text(text) : Text(text, style: linkStyle,),
    ),
  );
}
bool isMoreThanParticlarSizeScreen(BuildContext context, double size) => 
  MediaQuery.of(context).size.width > size;
  
bool isMoreThanMediumScreen(BuildContext context) => 
  MediaQuery.of(context).size.width > mediumScreenSize;

bool isMoreThanCustomScreen(BuildContext context) =>
  MediaQuery.of(context).size.width > customScreenSize;

bool isMoreThanSmallScren(Size size) =>
  size.width > smallScreenSize;

bool isMobileScreen(BuildContext context) =>
   MediaQuery.of(context).size.width < mobileScreenSize;

bool isSmallScreen(BuildContext context) => 
  MediaQuery.of(context).size.width < mediumScreenSize && 
  MediaQuery.of(context).size.width >= mobileScreenSize;     

bool isMediumScreen(BuildContext context) => 
  MediaQuery.of(context).size.width >= mediumScreenSize &&
  MediaQuery.of(context).size.width < largeScreenSize;

bool isLargeScreen(BuildContext context) => 
  MediaQuery.of(context).size.width >= largeScreenSize; 

bool isCustomScreen(BuildContext context) => 
  MediaQuery.of(context).size.width >= mediumScreenSize &&
  MediaQuery.of(context).size.width <= customScreenSize;

Widget anyText({
  required String text,
  required TextStyle style,
  double? size,
  double? height,
  FontWeight? weight, 
  Color? color,
  TextDecoration? decoration,
  double? letterSpacing,
  double? left,
  double? right,
  double? top,
  double? bottom,
  bool? bigSize,
}){
  style = style.copyWith(letterSpacing: letterSpacing);
  style = style.copyWith(decoration: decoration);
  style = style.copyWith(fontSize: size);
  style = style.copyWith(height: height);
  style = style.copyWith(fontWeight: weight);
  style = style.copyWith(color: color); 
  if(!(bigSize ?? true)) style = style.copyWith(fontSize: 2 * style.fontSize!/3);
  return Padding(
    padding: EdgeInsets.only(
      left: left ?? 0,
      right: right ?? 0,
      top: top ?? 0,
      bottom: bottom ?? 0,
    ),
    child: Text(text, style: style,),
  );
}
class CanSize{
  late bool _size;
  set size(bool size) => _size = size;
}
Widget getNavWidget(IconData icondata, String tooltip, VoidCallback? onPressed){
  Icon icon = Icon(icondata, color: (onPressed == null) ? simplyBlack : clearFilterText);
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onPressed,
      child: Tooltip(
        message: tooltip,
        child: icon,
      ),
    ),
  );
}
Widget getTitleWidget(String label, int flex, VoidCallback? onPressed, String tooltip){
  return Expanded(
    flex: flex,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: customerData,),
        const SizedBox(width: 3,),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            
            child: Tooltip(
              message: tooltip,
              child: Icon(
                Icons.sort,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
