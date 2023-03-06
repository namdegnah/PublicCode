import 'package:flutter/material.dart';

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
    this.key,
  });
    
  final Function()? onTap;
  final String title;
  bool enabled;
  double? height;
  double? width;
  Color? textColor;
  TextStyle? textStyle;
  double? cornerRadius;
  String? key;

  Widget get button {
    return SizedBox(
      height: height ?? 40,
      width: width ?? 327,
      child: ElevatedButton(
        key: Key(key ?? 'buttonkey'),
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