import 'group.dart';
import 'type.dart';

class Password {
  Password({
    required this.id,
    required this.groupId,
    required this.typeId,
    this.password,
    required this.notes,
    required this.description,
    this.url,
    this.username,
    this.email,
    this.accountNumber,
    this.pin,
    this.sortCode,
    this.digit3SecurityCode,
    this.digit4SecurityCode,
    this.phoneNumber,
    this.name,
    this.cardNumber,
    this.amexCardNumber,
    this.expiryDate,
    this.passcode,
    this.passwordValidationId,
    this.groups,
    this.types,
    this.isValidated,
  });
  late int id;
  late int groupId;
  late int typeId;
  late String? password;
  late String notes;
  late String description;
  late String? url;
  late String? username;
  late String? email;
  late String? accountNumber;
  late String? pin;
  late String? sortCode;
  late String? digit3SecurityCode;
  late String? digit4SecurityCode;
  late String? phoneNumber;
  late String? name;
  late String? cardNumber;
  late String? amexCardNumber;
  late String? expiryDate;
  late String? passcode;
  late int? passwordValidationId;
  late bool? isValidated;
  late List<Type>? types;
  late List<Group>? groups;
  // could this simply hold the passwordvalidation ie strong, medium or weak



  Password.fromJson(Map<String, dynamic> json){
    id = json['id'];
    groupId = json['groupId'];
    typeId = json['typeId'];
    password = json['password'];
    notes = json['notes']; 
    description = json['description'];
    url = json['url'];
    username = json['username'];
    email = json['email'];
    accountNumber = json['accountNumber'];
    pin = json['pin'];
    sortCode = json['sortCode'];
    digit3SecurityCode = json['digit3SecurityCode'];
    digit4SecurityCode = json['digit4SecurityCode'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    cardNumber = json['cardNumber'];
    amexCardNumber = json['amexCardNumber'];
    expiryDate = json['expiryDate'];
    passcode = json['passcode'];
    passwordValidationId = json['passwordValidationId'];
    isValidated = json['isValidated'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['"id"'] = id;
    data['"groupId"'] = groupId;
    data['"typeId"'] = typeId;
    data['"password"'] = '"$password"';
    data['"notes"'] = convertLineBreaks(notes); // this needs to change
    data['"description"'] = '"$description"';
    data['"url"'] = '"$url"';
    data['"username"'] = '"$username"';
    data['"email"'] = '"$email"';
    data['"accountNumber"'] = '"$accountNumber"';
    data['"pin"'] = '"$pin"';
    data['"sortCode"'] = '"$sortCode"';
    data['"digit3SecurityCode"'] = '"$digit3SecurityCode"';
    data['"digit4SecurityCode"'] = '"$digit4SecurityCode"';
    data['"phoneNumber"'] = '"$phoneNumber"';
    data['"name"'] = '"$name"';
    data['"cardNumber"'] = '"$cardNumber"';
    data['"amexCardNumber"'] = '"$amexCardNumber"';
    data['"expiryDate"'] = '"$expiryDate"';
    data['"passcode"'] = '"$passcode"';
    data['"passwordValidationId"'] = passwordValidationId ?? 0;
    data['"isValidated"'] = isValidated ?? 0;
    return data;
  }    
}
String convertLineBreaks(String input){
  String output = '';
  for(var i = 0; i < input.length; i++){
    if(input.codeUnitAt(i) != 10){
      output = output + input[i];
    } else {
      output = output + '\\n';
    }
  }
  return '"$output"';
}
