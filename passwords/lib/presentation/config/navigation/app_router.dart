import 'package:flutter/material.dart';
import 'navigation_paths.dart';
import '../../pages/groups_screen.dart';
import '../../pages/home_screen.dart';
import '../../pages/types_screen.dart';
import '../../pages/passwords_screen.dart';
import '../../pages/start_up.dart';
import '../../pages/restore_screen.dart';
import '../../pages/search_view_screen.dart';
import '../constants.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    
    var arg = settings.arguments;


    switch (settings.name) {
      case NavigationPaths.homeBackup:
        return MaterialPageRoute(
          builder: (_) => const StartUp(option: StartUpScreens.backup),
        );
      case NavigationPaths.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
          ),
        );
      case NavigationPaths.groups:
        return MaterialPageRoute(
          builder: (_) => const GroupsScreen(key: Key('GroupsRouter'),),          
        );
      case NavigationPaths.type:
        return MaterialPageRoute(
          builder: (_) => const TypesScreen(key: Key('TypesRouter'),),
        );
      case NavigationPaths.password:
        return MaterialPageRoute(
          builder: (_) => const PasswordsScreen(key: Key('passwordRouter'),),
        );  
      case NavigationPaths.restore:
        return MaterialPageRoute(
          builder: (_) => const RestoreScreen(key: Key('restoreRouter'),),
        );  
      case NavigationPaths.search:
        return MaterialPageRoute(
          builder: (_) => const SearchViewScreen(key: Key('searchRouter'),),
        );                                            
      default:
        return null;
    }
  }
}