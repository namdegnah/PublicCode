import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/injection_container.dart';
import '../../presentation/config/navigation/app_navigation.dart';
import '../entities/password.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

  Future<void> loadNextPage() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.next);
  }
  Future<void> loadFootballPage() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.footabll);
  }
  Future<List<Password>> getPasswordList() async {

    List<Password> passwords = [];
    String jsondata = await readJson();
    final extractedData = json.decode(jsondata) as Map<String, dynamic>;

    List<dynamic> passwordMaps = extractedData['Passwords'];
    if (passwordMaps.isNotEmpty) {
      for (var map in passwordMaps) {
        passwords.add(Password.fromJson(map));
      }
    }

    return passwords;
  }
Future<String> readJson() async {
  try {
    return await rootBundle.loadString('assets/json/userpasswords.json');
  } catch (error) {
    rethrow;
  }
}

