import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textInput({
    required BuildContext context, 
    TextEditingController? controller, 
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    ValueChanged<String>? onChanged,
    ValueChanged<String?>? onSaved,
    String? Function(String?)? validator,
    InputDecoration? decoration,
    String? initialValue,
    List<TextInputFormatter>? formatters,
    // bool? expandThis,
    int? maxLinesThis,
    }) {
  return TextFormField(
    // expands: expandThis ?? false,
    maxLines: maxLinesThis ?? 1,
    controller: controller,
    autofocus: true,
    decoration: decoration,
    validator: validator,
    inputFormatters: formatters,
    onSaved: onSaved,
    initialValue: initialValue,
    onEditingComplete: () {
      if (nextFocusNode != null) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      } else {
        FocusScope.of(context).unfocus();
      }
    },
    onChanged: onChanged,
  );
}