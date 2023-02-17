import 'package:flutter/material.dart';

import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/injection_container.dart';
import '../../presentation/config/navigation/app_navigation.dart';

  Future<void> loadHomePage() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.home);
  }
  Future<void> loadGroups() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.groups);
  }
  Future<void> loadTypes() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.type);
  }
  Future<void> loadPasswords() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.password);
  }
  Future<void> restore() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.restore);
  } 
  Future<void> backup(BuildContext context) async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.homeBackup);
  }   
  Future<void> search() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.search);
  }

