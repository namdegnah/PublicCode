import 'dart:convert';
List<PersonalPeople> modelPPJson(String str) => List<PersonalPeople>.from(json.decode(str).map((x) => PersonalPeople.fromJson(x)));


class PersonalPeople {
  PersonalPeople({
    required this.group,
    required this.type,
    required this.description,
    required this.phoneNumber,
    required this.email,
    required this.notes,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String phoneNumber;
  late final String email;
  late final String notes;
  
  PersonalPeople.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['phoneNumber'] = phoneNumber;
    _data['email'] = email;
    _data['notes'] = notes;
    return _data;
  }
}