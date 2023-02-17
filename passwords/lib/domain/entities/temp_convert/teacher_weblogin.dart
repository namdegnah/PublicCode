import 'dart:convert';
List<TeacherWebLogin> modelTWLJson(String str) => List<TeacherWebLogin>.from(json.decode(str).map((x) => TeacherWebLogin.fromJson(x)));

class TeacherWebLogin {
  TeacherWebLogin({
    required this.group,
    required this.type,
    required this.description,
    required this.url,
    required this.password,
    required this.username,
    required this.email,
    required this.notes,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String url;
  late final String password;
  late final String username;
  late final String email;
  late final String notes;
  
  TeacherWebLogin.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    url = json['url'];
    password = json['password'];
    username = json['username'];
    email = json['email'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['url'] = url;
    _data['password'] = password;
    _data['username'] = username;
    _data['email'] = email;
    _data['notes'] = notes;
    return _data;
  }
}