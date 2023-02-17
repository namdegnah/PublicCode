class TempClass {
  TempClass({
    required this.group,
    required this.type,
    required this.description,
    required this.notes,
    required this.url,
    required this.username,
    required this.password,
    required this.email,
    required this.website,
    required this.Field1,
    required this.Field2,
    required this.Field3,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String notes;
  late final String url;
  late final String username;
  late final String password;
  late final String email;
  late final String website;
  late final String Field1;
  late final String Field2;
  late final String Field3;
  
  TempClass.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    notes = json['notes'];
    url = json['url'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    website = json['website'];
    Field1 = json['Field1'];
    Field2 = json['Field2'];
    Field3 = json['Field3'];
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
    _data['website'] = website;
    _data['Field1'] = Field1;
    _data['Field2'] = Field2;
    _data['Field3'] = Field3;
    return _data;
  }
}