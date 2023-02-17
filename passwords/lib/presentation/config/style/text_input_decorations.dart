import 'package:flutter/material.dart';


InputDecoration textInputDecoration({String? hintText, String? labelText}) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: hintText,
    labelText: labelText,
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
  );
}