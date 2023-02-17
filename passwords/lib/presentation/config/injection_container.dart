import 'package:get_it/get_it.dart';
import '../../presentation/config/navigation/app_navigation.dart';
import '../../data/models/d_base.dart';
import '../../data/datasources/data_sources.dart';
import '../../data/datasources/local_data_source_imp.dart';
// block
import '../bloc/group/group_bloc.dart';
import '../bloc/type/type_bloc.dart';
import '../bloc/password/password_bloc.dart';
import '../bloc/setup/setup_bloc.dart';
// usecase
import '../../domain/usecases/group_usecase.dart';
import '../../domain/usecases/type_usecase.dart';
import '../../domain/usecases/setup_usecase.dart';
import '../../domain/usecases/password_usecase.dart';
// repositories
import '../../domain/repositories/repositories_all.dart';
import '../../data/repositories/group_repository_imp.dart';
import '../../data/repositories/type_repository_imp.dart';
import '../../data/repositories/setup_repository_imp.dart';
import '../../data/repositories/password_repository_imp.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import '../../data/models/data_set.dart';
import '../../domain/entities/password_filter.dart';

final sl = GetIt.instance;

Future<void> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();
  final dataSet = DataSet();
  sl.registerLazySingleton(() => dataSet);
  final passwordFilter = PasswordFilter();
  sl.registerLazySingleton(() => passwordFilter);
  sharedPreferences.setInt(AppConstants.userId, AppConstants.defaultUserId);
  sl.registerLazySingleton(() => sharedPreferences);
  final appNavigation = AppNavigation();
  sl.registerLazySingleton(() => appNavigation);
  final db = await database();
  db.execute('PRAGMA foreign_keys = ON;');

  // All
  sl.registerLazySingleton<AppDataSource>(() => LocalDataSource());
  sl.registerFactory(() => GroupBloc());
  sl.registerLazySingleton(() => GroupUser(repository: sl()));
  sl.registerFactory(() => TypeBloc());  
  sl.registerLazySingleton(() => TypeUser(repository: sl()));
  sl.registerFactory(() => SetupBloc());   
  sl.registerLazySingleton(() => SetupUser(repository: sl()));
  sl.registerFactory(() => PasswordBloc());    
  sl.registerLazySingleton(() => PasswordUser(repository: sl()));
  sl.registerLazySingleton<GroupRepository>(() => GroupRepositoryImp(dataSource: sl())); 
  sl.registerLazySingleton<TypeRepository>(() => TypeRepositoryImp(dataSource: sl()));  
  sl.registerLazySingleton<SetupRepository>(() => SetupRepositoryImp(dataSource: sl()));
  sl.registerLazySingleton<PasswordRepository>(() => PasswordRepositoryImp(dataSource: sl()));
}