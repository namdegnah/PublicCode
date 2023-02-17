import 'dart:convert';
List<GamesWebLogin> modelGWLJson(String str) => List<GamesWebLogin>.from(json.decode(str).map((x) => GamesWebLogin.fromJson(x)));

class GamesWebLogin {
  GamesWebLogin({
    required this.group,
    required this.type,
    required this.description,
    required this.notes,
    required this.url,
    required this.username,
    required this.password,
    required this.email,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String notes;
  late final String url;
  late final String username;
  late final String password;
  late final String email;
  
  GamesWebLogin.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    notes = json['notes'];
    url = json['url'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['notes'] = notes;
    _data['url'] = url;
    _data['username'] = username;
    _data['password'] = password;
    _data['email'] = email;
    return _data;
  }
}