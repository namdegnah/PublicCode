
import '../../presentation/config/style/text_style.dart';
import 'package:flutter/material.dart';


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
}
extension GroupExtensions on List<Type>{

  List<DropdownMenuItem<Type>> getDropdownValues(){
    List<DropdownMenuItem<Type>> ans = [];
    for(var type in this){
      ans.add(DropdownMenuItem(value: type, child: Text(type.name, style: dropdownList,),));
    }
    return ans;
  }
}