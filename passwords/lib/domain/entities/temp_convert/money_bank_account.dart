import 'dart:convert';
List<MoneyBankAccount> modelMBAomJson(String str) => List<MoneyBankAccount>.from(json.decode(str).map((x) => MoneyBankAccount.fromJson(x)));

class MoneyBankAccount {
  MoneyBankAccount({
    required this.group,
    required this.type,
    required this.description,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.passcode,
    required this.pin,
    required this.sortCode,
    required this.accountNumber,
    required this.notes,
  });
  late final String group;
  late final String type;
  late final String description;
  late final String password;
  late final String name;
  late final String phoneNumber;
  late final String passcode;
  late final String pin;
  late final String sortCode;
  late final int accountNumber;
  late final String notes;
  
  MoneyBankAccount.fromJson(Map<String, dynamic> json){
    group = json['group'];
    type = json['type'];
    description = json['description'];
    password = json['password'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    passcode = json['passcode'];
    pin = json['pin'];
    sortCode = json['sortCode'];
    accountNumber = json['accountNumber'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group;
    _data['type'] = type;
    _data['description'] = description;
    _data['password'] = password;
    _data['name'] = name;
    _data['phoneNumber'] = phoneNumber;
    _data['passcode'] = passcode;
    _data['pin'] = pin;
    _data['sortCode'] = sortCode;
    _data['accountNumber'] = accountNumber;
    _data['notes'] = notes;
    return _data;
  }
}