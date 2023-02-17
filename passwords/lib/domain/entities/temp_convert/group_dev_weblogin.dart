import 'dart:convert';
List<GroupDevWebLogin> modelGDWFromJson(String str) => List<GroupDevWebLogin>.from(json.decode(str).map((x) => GroupDevWebLogin.fromJson(x)));


class GroupDevWebLogin {
  GroupDevWebLogin({
    required this.group,
    required this.type,
    required this.description,
    required this.url,
    required this.phone,
    required this.password,
    required this.email,
    required this.notes,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String url;
  late final String phone;
  late final String password;
  late final String email;
  late final String notes;
  
  GroupDevWebLogin.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    url = json['url'];
    phone = json['phone'];
    password = json['password'];
    email = json['email'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['url'] = url;
    _data['phone'] = phone;
    _data['password'] = password;
    _data['email'] = email;
    _data['notes'] = notes;
    return _data;
  }
}