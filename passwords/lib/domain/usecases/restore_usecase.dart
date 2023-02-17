import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../entities/group.dart';
import '../entities/type.dart';
import '../entities/password.dart';
import 'dart:async';
import 'dart:convert';
import '../../data/models/d_base.dart';
import '../../presentation/config/injection_container.dart' as di;
import '../../presentation/bloc/group/group_bloc.dart';
import '../../presentation/bloc/group/group_bloc_events.dart';
import '../../presentation/bloc/type/type_bloc.dart';
import '../../presentation/bloc/type/type_bloc_events.dart';
import '../../presentation/bloc/password/password_bloc.dart';
import '../../presentation/bloc/password/password_bloc_events.dart';
import '../../core/util/general_util.dart';
import 'dart:io';

Future<Text> restoreJsonData() async {
  try {
    List<Group> groups = [];
    List<Type> types = [];
    List<Password> passwords = [];
    String jsondata = await readJson();
    final extractedData = json.decode(jsondata) as Map<String, dynamic>;
    List<dynamic> groupMaps = extractedData['Groups'];
    if (groupMaps.isNotEmpty) {
      for (var map in groupMaps) {
        groups.add(Group.fromJson(map));
      }
    }
    List<dynamic> typeMaps = extractedData['Types'];
    if (typeMaps.isNotEmpty) {
      for (var map in typeMaps) {
        types.add(Type.fromJson(map));
      }
    }
    List<dynamic> passwordMaps = extractedData['Passwords'];
    if (passwordMaps.isNotEmpty) {
      for (var map in passwordMaps) {
        passwords.add(Password.fromJson(map));
      }
    }
    await cleanDatabase();
    for (var group in groups) {
      di.sl<GroupBloc>().add(InsertBlindGroupEvent(group: group));
    }
    for (var type in types) {
      di.sl<TypeBloc>().add(InsertBlindTypeEvent(type: type));
    }
    for (var password in passwords) {
      di.sl<PasswordBloc>().add(InsertBlindPasswordEvent(password: password));
    }
    return Text('restored all data');
  } catch (error) {
    throw Exception('Error in Restore $error');
  }
}

Future<String> readJson() async {
  try {
    // return await rootBundle.loadString('assets/json/userpasswords.json');

    final directory = await downloadsPath;
    final file = File('${directory.path}/userpasswords.json');
    return await file.readAsString();
  } catch (error) {
    throw error;
  }
}
