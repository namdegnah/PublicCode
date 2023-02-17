import 'package:flutter/material.dart';
import 'package:passwords/presentation/config/style/app_colours.dart';

class StandardButton{

  StandardButton({
    required this.onTap,
    required this.title,
    required this.enabled,
    this.height,
    this.width,
    this.textColor,
    this.textStyle,
    this.cornerRadius,
  });
    
  final Function()? onTap;
  final String title;
  bool enabled;
  double? height;
  double? width;
  Color? textColor;
  TextStyle? textStyle;
  double? cornerRadius;

  Widget get button {
    return SizedBox(
      height: height ?? 40,
      width: width ?? 327,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ButtonStyle(
          // text colour
          foregroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                ? Colors.black45
                : textColor ?? Colors.white;
            }
          ),
          // button colour
          backgroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                ? Colors.black26
                : Colors.black54;
            }
          ), 
          textStyle: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            return textStyle;
          }),
          shape: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius ?? 16),
            ),
          ),                                       
        ),
        child: Text(title, style: textStyle,),
      ),
    );
  }
}