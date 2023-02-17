import 'dart:convert';
List<PersonalWebLogin> modelPWLJson(String str) => List<PersonalWebLogin>.from(json.decode(str).map((x) => PersonalWebLogin.fromJson(x)));

class PersonalWebLogin {
  PersonalWebLogin({
    required this.group,
    required this.type,
    required this.description,
    required this.url,
    required this.password,
    required this.username,
    required this.notes,
    required this.email,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String url;
  late final String password;
  late final String username;
  late final String notes;
  late final String email;
  
  PersonalWebLogin.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    url = json['url'];
    password = json['password'];
    username = json['username'];
    notes = json['notes'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['url'] = url;
    _data['password'] = password;
    _data['username'] = username;
    _data['notes'] = notes;
    _data['email'] = email;
    return _data;
  }
}