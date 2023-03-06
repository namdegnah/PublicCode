import 'package:get_it/get_it.dart';
import '../../presentation/config/navigation/app_navigation.dart';
import '../../data/datasources/data_sources.dart';
import '../../data/datasources/local_data_source_imp.dart';
import '../../domain/usecases/matches_user.dart';
import '../../domain/usecases/best_team_user.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../data/repositories/http_repository_imp.dart';
import '../bloc/http/http_bloc.dart';
final sl = GetIt.instance;

Future<void> init() async {
  final appNavigation = AppNavigation();
  sl.registerLazySingleton(() => appNavigation);
  sl.registerLazySingleton<AppDataSource>(() => LocalDataSource());
  sl.registerFactory(() => HttpBloc());  
  sl.registerLazySingleton<HttpRepository>(() => HttpRepositoryImp(dataSource: sl()));
  sl.registerLazySingleton(() => MatchesUser(repository: sl()));
  sl.registerLazySingleton(() => BestTeamUser(repository: sl()));  
}