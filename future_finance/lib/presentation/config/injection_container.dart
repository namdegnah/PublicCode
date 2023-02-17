import '../../core/util/general_util.dart';
import 'package:get_it/get_it.dart';
import '../../presentation/config/navigation/app_navigation.dart';
import '../../data/models/d_base.dart';
import '../../data/datasources/data_sources.dart';
import '../../data/datasources/local_data_source_imp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import '../../domain/entities/setting.dart';
import '../../domain/entities/accounts/account_simple_savings.dart';

// usecases
import '../../domain/usecases/user_usecase.dart';
import '../../domain/usecases/account_usecase.dart';
import '../../domain/usecases/dialog_usecase.dart';
import '../../domain/usecases/recurrence_usecase.dart';
import '../../domain/usecases/category_usecase.dart';
import '../../domain/usecases/transaction_usecase.dart';
import '../../domain/usecases/transfer_usecase.dart';
import '../../domain/usecases/facts_usecase.dart';
import '../../domain/usecases/setting_usecase.dart';
// repository implementation
import '../../domain/repositories/repositories_all.dart';
import '../../data/repositories/user_repository_imp.dart';
import '../../data/repositories/account_repository_imp.dart';
import '../../data/repositories/dialog_repository_imp.dart';
import '../../data/repositories/recurrence_repository_imp.dart';
import '../../data/repositories/category_repository_imp.dart';
import '../../data/repositories/transaction_repository_imp.dart';
import '../../data/repositories/transfer_repository_imp.dart';
import '../../data/repositories/facts_repository.dart';
import '../../data/repositories/setting_repository_imp.dart';
// bloc exports
import '../../presentation/bloc/users/user_bloc_exports.dart';
import '../../presentation/bloc/accounts/account_bloc_exports.dart';
import '../../presentation/bloc/dialog/dialog_bloc_exports.dart';
import '../../presentation/bloc/recurrences/recurrence_bloc_exports.dart';
import '../../presentation/bloc/categories/categories_bloc_exports.dart';
import '../../presentation/bloc/transactions/transaction_bloc_exports.dart';
import '../../presentation/bloc/transfers/transfer_bloc_exports.dart';
import '../../presentation/bloc/facts/facts_bloc_exports.dart';
import '../../presentation/bloc/settings/setting_bloc_exports.dart';

final sl = GetIt.instance;

Future<void> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();
  setUpShared(sharedPreferences);
  sl.registerLazySingleton(() => sharedPreferences);
  final appNavigation = AppNavigation();
  sl.registerLazySingleton(() => appNavigation);
  await database();
  // db.execute('PRAGMA foreign_keys = ON;');

  // All
  sl.registerLazySingleton<AppDataSource>(() => LocalDataSource());
  // Users
  sl.registerFactory(() => UserBloc());
  sl.registerLazySingleton(() => UserUser(repository: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImp(dataSource: sl()));
  // Accounts
  sl.registerFactory(() => AccountsBloc());
  sl.registerLazySingleton(() => AccountUser(repository: sl())); 
  sl.registerLazySingleton<AccountRepository>(() => AccountRepositoryImp(dataSource: sl())); 
  // Dialog
  sl.registerFactory(() => DialogBloc());
  sl.registerLazySingleton(() => DialogUser(repository: sl())); 
  sl.registerLazySingleton<DialogRepository>(() => DialogRepositoryImp(dataSource: sl())); 
  // Recurrences
  sl.registerFactory(() => RecurrencesBloc());
  sl.registerLazySingleton(() => RecurrenceUser(repository: sl())); 
  sl.registerLazySingleton<RecurrenceRepository>(() => RecurrenceRepositoryImp(dataSource: sl()));  
  // Categories
  sl.registerFactory(() => CategoriesBloc());
  sl.registerLazySingleton(() => CategoryUser(repository: sl())); 
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImp(dataSource: sl()));  
  // Transactions
  sl.registerFactory(() => TransactionsBloc());
  sl.registerLazySingleton(() => TransactionUser(repository: sl())); 
  sl.registerLazySingleton<TransactionRepository>(() => TransactionRepositoryImp(dataSource: sl())); 
   // Transfers
  sl.registerFactory(() => TransferBloc());
  sl.registerLazySingleton(() => TransferUser(repository: sl())); 
  sl.registerLazySingleton<TransferRepository>(() => TransferRepositoryImp(dataSource: sl()));    
  // Facts
  sl.registerFactory(() => FactsBloc());
  sl.registerLazySingleton(() => FactsUser(repository: sl())); 
  sl.registerLazySingleton<FactsRepository>(() => FactsRepositoryImp(dataSource: sl()));   
  // Settings
  sl.registerFactory(() => SettingBloc());
  sl.registerLazySingleton(() => SettingUser(repository: sl())); 
  sl.registerLazySingleton<SettingRepository>(() => SettingRepositoryImp(dataSource: sl()));  
  //here is where we register the settings class which finds the user's settings, or creates a new default set if no user is yet created.
  sl.registerLazySingleton(() => Setting());
  Setting setting = sl<Setting>();
  setting.setUp();  
}

void setUpShared(SharedPreferences sharedPreferences){
  // User_id the unique identifier of the user
  int? _userChoice = sharedPreferences.getInt(AppConstants.userId);
  if(_userChoice == null) sharedPreferences.setInt(AppConstants.userId, AppConstants.defaultUserId);
  // Maximum account number used due to several account types which all share a unique number to make most code simpler
  int? _maxAccountNumber = sharedPreferences.getInt(AppConstants.maxAccountNumber);
  if(_maxAccountNumber == null) sharedPreferences.setInt(AppConstants.maxAccountNumber, AppConstants.startAccountNumber); 
  // Flag for the App to run code just once when started
  sharedPreferences.setInt(AppConstants.doOnce, AppConstants.doOnceNotDone);
  // Date the App was last run - essential for auto processing which keeps the app up to date
  int? _lastDate = sharedPreferences.getInt(AppConstants.lastDate);
  if(_lastDate == null) sharedPreferences.setInt(AppConstants.lastDate, GeneralUtil.intFromTime(DateTime.now())); 
}