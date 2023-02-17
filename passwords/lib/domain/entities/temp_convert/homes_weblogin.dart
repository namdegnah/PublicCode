import 'dart:convert';
List<HomesWebLogin> modelHWLJson(String str) => List<HomesWebLogin>.from(json.decode(str).map((x) => HomesWebLogin.fromJson(x)));


class HomesWebLogin {
  HomesWebLogin({
    required this.group,
    required this.type,
    required this.description,
    required this.password,
    required this.email,
    required this.username,
    required this.notes,
    required this.url,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String password;
  late final String email;
  late final String username;
  late final String notes;
  late final String url;
  
  HomesWebLogin.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    password = json['password'];
    email = json['email'];
    username = json['username'];
    notes = json['notes'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['password'] = password;
    _data['email'] = email;
    _data['username'] = username;
    _data['notes'] = notes;
    _data['url'] = url;
    return _data;
  }
}