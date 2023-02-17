import '../../data/models/data_set.dart';
import 'dart:io';
import '../../core/util/general_util.dart';
import 'package:flutter/material.dart';


Future<Text> backupDataToJson(DataSet dataSet) async {

  List<String> sections = ['{']; // beginning of json
  //Groups
  var out = '"Groups": ';
  out = '$out[';
  for(var group in dataSet.groups!){
    out = '$out${group.toJson()},'; 
  }
  out = out.substring(0, out.length - 1); 
  out = '$out],';
  sections.add(out);
  //Types
  out = '"Types": ';
  out = '$out[';
  for(var type in dataSet.types!){
    out = '$out${type.toJson()},'; 
  }
  out = out.substring(0, out.length - 1); 
  out = '$out],';
  sections.add(out);
  //Passwords
  out = '"Passwords": ';
  out = '$out[';
  for(var password in dataSet.passwords!){
    out = '$out${password.toJson()},'; 
  }
  out = out.substring(0, out.length - 1); 
  out = '$out]'; // no extra comma
  sections.add(out);
  // end of file  
  out = '}';
  sections.add(out);
   // end of json
  out = '';
  for(var section in sections){
    out = '$out$section';
  }
  await saveJson(out);
return Text('backup up all data');   
}

Future<File> get _localFile async {
  try{
  final Directory directory = await downloadsPath;
  final file = File('${directory.path}/userpasswords.json');
  return file;
  } catch (error){
    rethrow;
  }
}
Future<File> saveJson(String data) async {
  try{
  final file = await _localFile;
  return file.writeAsString(data);
  } catch (error){
    rethrow;
  }
}
