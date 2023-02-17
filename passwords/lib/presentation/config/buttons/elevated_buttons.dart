import 'package:flutter/material.dart';
import '../enums.dart';

ButtonStyle elevatedButtons({required ElevatedButtons type}) {
  switch (type) {
    case ElevatedButtons.lightMode:
      return xStyle;
    case ElevatedButtons.darkMode:
      return ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        minimumSize: const Size(80, 50),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        primary: Colors.black12,
        onPrimary: Colors.black,
      );
    case ElevatedButtons.lightModeBold:
      return ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        minimumSize: const Size(80, 50),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        primary: Colors.black12,
        onPrimary: Colors.black,
      );
    case ElevatedButtons.darkModeBold:
      return ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        minimumSize: const Size(80, 50),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        primary: Colors.black12,
        onPrimary: Colors.black,
      );
    default:
      return ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        minimumSize: const Size(80, 50),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        primary: Colors.black12,
        onPrimary: Colors.black,
      );
  }
}

final xStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
  minimumSize: MaterialStateProperty.all<Size>(const Size(80, 50)),
  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),  
  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),       
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.brown.withOpacity(0.04);
        }
        if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {            
          return Colors.brown.withOpacity(0.12);
        }
        return null; // Defer to the widget's default.
      },
    ), 
);
