import '../../core/util/form_elements.dart';
import 'package:flutter/material.dart';
import '../../presentation/config/style/text_input_decorations.dart';
import '../../core/util/validation.dart';
import '../entities/password.dart';
import '../../presentation/config/constants.dart';

class PasswordField {
  PasswordField({
    required this.id,
    required this.name,
    required this.description,
    required this.hintText,
    required this.errorText,
    required this.validationIndex,
    required this.length,
    this.formatterIndex,
    this.addEnabled,
    this.removeEnabled,
    this.nextEnabled,
    this.previousEnabled,
    this.widgetId,
  });
  late int id;
  late String name;
  late String description;
  late String hintText;
  late String errorText;
  late int validationIndex;
  late int length;
  late int? formatterIndex;
  String? fieldvalue;
  bool? addEnabled;
  bool? removeEnabled;
  bool? nextEnabled;
  bool? previousEnabled;
  int? widgetId; // can this be a stateful widget that is passed the method to save the data and thus can contain anything?

  PasswordField.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    hintText = json['hintText'];
    errorText = json['errorText'];
    validationIndex = json['validationIndex'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['hintText'] = hintText;
    data['errorText'] = errorText;
    data['validationIndex'] = validationIndex;
    data['length'] = length;
    return data;
  }
  // field needs hint text error text and which validation!
  Widget getTextFormField({
    required BuildContext context, 
    required FocusNode thisNode,
    FocusNode? nextNode,
    String? dbValue, 
    Password? password,
    bool? expandThis,
    int? maxLinesThis,
    }){
      // set the validationId to be used to either the passwordField.validationId or the password.passwordValidationId if it has been set
    int valindex = (password != null && password.passwordValidationId != null && id == PasswordFieldsNumbers.password.index) ? password.passwordValidationId! : validationIndex;
    return textInput(
      context: context,
      decoration: textInputDecoration(hintText: hintText, labelText: name),
      focusNode: thisNode,
      nextFocusNode: nextNode,
      initialValue: dbValue,
      // expandThis: expandThis,
      maxLinesThis: maxLinesThis,
      validator: getValidation(validationIndex: valindex, errorText: errorText, length: length), 
      formatters: getFormatters(formatterIndex: formatterIndex, length: length),
      onSaved: (value) => fieldvalue = value!,
    );
  }
}
// extension on List<PasswordField> that returns List<Widget> for the column
extension PasswordFunctions on List<PasswordField> {
  List<Widget> getWidgets({required List<FocusNode> nodes, required BuildContext context, Password? password}){
    List<Widget> ans = <Widget>[];
    for(var i = 0; i < length; i++){
      // print('${this[i].id} : ${PasswordFieldsNumbers.notes.index}');
      ans.add(this[i].getTextFormField(     
        context: context, 
        // expandThis: this[i].id == PasswordFieldsNumbers.notes.index ? true : false,
        maxLinesThis: this[i].id == PasswordFieldsNumbers.notes.index ? 10 : null,
        //ex ? 10 : null,
        thisNode: nodes[i], 
        nextNode: i == length - 1 ? null : nodes[i + 1],
        dbValue: password == null ? '' : password.getValue(this[i]),
        password: password
        )
      );
      ans.add(const SizedBox(height: 10,));
    }
    return ans;
  }
}