import 'package:flutter/material.dart';

final CustomTheme themeSingleton = CustomTheme();

class CustomTheme with ChangeNotifier {
  
  static bool _isDarkTheme = false; 
  static bool get isDarkTheme => _isDarkTheme;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
