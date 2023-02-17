import 'package:flutter/material.dart';
import 'navigation_paths.dart';
import '../../pages/users_screen.dart';
import '../../pages/home_screen.dart';
import '../../pages/accounts_screen.dart';
import '../../pages/recurrences_screen.dart';
import '../../pages/categories_screen.dart';
import '../../pages/transactions_screen.dart';
import '../../pages/transfers_screen.dart';
import '../../pages/settings_screen.dart';
import '../../config/testing/test_results.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case NavigationPaths.home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
          ),
        );
      case NavigationPaths.users:
        return MaterialPageRoute(
          builder: (_) => const UsersScreen(key: Key('UsersScreen'),),          
        );
      case NavigationPaths.accounts:
        return MaterialPageRoute(
          builder: (_) => const AccountsScreen(key: Key('AccountsScreen'),),          
        ); 
      case NavigationPaths.recurrences:
        return MaterialPageRoute(
          builder: (_) => RecurrencesScreen(),          
        ); 
      case NavigationPaths.categories:
        return MaterialPageRoute(
          builder: (_) => CategoriesScreen(),          
        );
      case NavigationPaths.transactions:
        return MaterialPageRoute(
          builder: (_) => TransactionsScreen(),          
        ); 
      case NavigationPaths.transfers:
        return MaterialPageRoute(
          builder: (_) => TransfersScreen(),          
        ); 
      case NavigationPaths.settings:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),          
        );
      case NavigationPaths.testing:
        return MaterialPageRoute(
          builder: (_) => TestResults(),          
        );                                                                           
      default:
        return null;
    }
  }
}