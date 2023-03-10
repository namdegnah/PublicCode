import 'package:flutter/material.dart';
import 'navigation_paths.dart';
import '../../pages/next_page.dart';
import '../../pages/home_sink.dart';
import '../../widgets/mortgage_calculator_widget.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    
    // var arg = settings.arguments;


    switch (settings.name) {
      case NavigationPaths.next:
        return MaterialPageRoute(
          builder: (_) => const NextPage(),
        );
      case NavigationPaths.footabll:
        return MaterialPageRoute(
          builder: (_) => const HomeSink(key: Key('FootballScreen'),),
        );
      case NavigationPaths.mortgage:
        return MaterialPageRoute(
          builder: (_) => const MortgageCalculatorWidget(key: Key('mortgageCalculatorScreen'),),          
        );
      // case NavigationPaths.type:
      //   return MaterialPageRoute(
      //     builder: (_) => const TypesScreen(key: Key('TypesRouter'),),
      //   );
      // case NavigationPaths.password:
      //   return MaterialPageRoute(
      //     builder: (_) => const PasswordsScreen(key: Key('passwordRouter'),),
      //   );  
      // case NavigationPaths.restore:
      //   return MaterialPageRoute(
      //     builder: (_) => const RestoreScreen(key: Key('restoreRouter'),),
      //   );  
      // case NavigationPaths.search:
      //   return MaterialPageRoute(
      //     builder: (_) => const SearchViewScreen(key: Key('searchRouter'),),
      //   );                                            
      default:
        return null;
    }
  }
}