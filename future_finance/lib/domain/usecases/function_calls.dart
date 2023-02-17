import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/injection_container.dart';
import '../../presentation/config/navigation/app_navigation.dart';

  Future<void> loadHomePage() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.home);
  }
  Future<void> loadUsers() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.users);
  }
  Future<void> loadAccounts() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.accounts);
  }
  Future<void> loadRecurrences() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.recurrences);
  }
  Future<void> loadCategories() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.categories);
  } 
  Future<void> loadTransactions() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.transactions);
  } 
  Future<void> loadTransfers() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.transfers);
  } 
  Future<void> loadSettings() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.settings);
  } 
  Future<void> loadTesting() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.testing);
  }    