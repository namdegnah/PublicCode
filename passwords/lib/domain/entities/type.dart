import 'password_field.dart';
import '../../presentation/config/style/text_style.dart';
import 'package:flutter/material.dart';
import '../../core/util/string_extensions.dart';
import '../../data/models/password_fields.dart' as pf;

class Type {
  Type({
    required this.id,
    required this.name,
    required this.fields,
    required this.passwordValidationId,
  });
  late int id;
  late String name;
  late String fields;
  late int? passwordValidationId;
  List<PasswordField>? fieldList;

  Type.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    fields = json['fields'];
    passwordValidationId = json['passwordValidationId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['"id"'] = id;
    data['"name"'] = '"$name"';
    data['"fields"'] = '"$fields"';
    data['"passwordValidationId"'] = passwordValidationId ?? 0;
    return data;
  }
  void addField(int fieldId){
    fields = fields.replaceCharAt(index: fieldId, newChar: '1');
  }
  void removeField(int fieldId){
    fields.replaceCharAt(index: fieldId, newChar: '0');
  }  
}
extension GroupExtensions on List<Type>{

  List<DropdownMenuItem<Type>> getDropdownValues(){
    List<DropdownMenuItem<Type>> ans = [];
    for(var type in this){
      ans.add(DropdownMenuItem(value: type, child: Text(type.name, style: dropdownList,),));
    }
    return ans;
  }
  // this now gets extended to include validation options
  void setTypeFields(){
    for(var type in this){
      List<PasswordField> passwordFields = [];
      final fieldString = type.fields;
      for(var i = 0; i < fieldString.length; i++){
        int field = int.parse(fieldString[i]);
        if(field != 0){
          passwordFields.add(pf.passwordFields.firstWhere((element) => element.id == i));
        }
      }
      type.fieldList = passwordFields;
    }    
  }
}