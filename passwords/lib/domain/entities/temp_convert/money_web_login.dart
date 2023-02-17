import 'dart:convert';
List<MoneyWebLogin> modelMWLJson(String str) => List<MoneyWebLogin>.from(json.decode(str).map((x) => MoneyWebLogin.fromJson(x)));

class MoneyWebLogin {
  MoneyWebLogin({
    required this.group,
    required this.type,
    required this.description,
    required this.url,
    required this.password,
    required this.email,
    required this.notes,
    required this.username,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String url;
  late final String password;
  late final String email;
  late final String notes;
  late final String username;
  
  MoneyWebLogin.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    url = json['url'];
    password = json['password'];
    email = json['email'];
    notes = json['notes'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['url'] = url;
    _data['password'] = password;
    _data['email'] = email;
    _data['notes'] = notes;
    _data['username'] = username;
    return _data;
  }
}