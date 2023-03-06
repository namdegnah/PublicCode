import 'package:flutter/material.dart';
import '../../presentation/config/style/text_style.dart';
class Group {
  Group({
    required this.id,
    required this.name,
  });
  late int id;
  late String name;
  
  Group.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['"id"'] = id;
    _data['"name"'] = '"$name"';
    return _data;
  }
  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Group &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;  
}

extension GroupExtensions on List<Group>{

  List<DropdownMenuItem<Group>> getDropdownValues(){
    List<DropdownMenuItem<Group>> ans = [];
    for(var group in this){
      ans.add(DropdownMenuItem(value: group, child: Text(group.name, style: dropdownList,),));
    }
    return ans;
  }
}