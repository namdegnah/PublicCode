import 'dart:convert';
List<DevRegCode> modelGDRCFromJson(String str) => List<DevRegCode>.from(json.decode(str).map((x) => DevRegCode.fromJson(x)));

class DevRegCode {
  DevRegCode({
    required this.group,
    required this.type,
    required this.description,
    required this.password,
    required this.notes,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String password;
  late final String notes;
  
  DevRegCode.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    password = json['password'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['password'] = password;
    _data['notes'] = notes;
    return _data;
  }
}