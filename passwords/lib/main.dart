import 'package:flutter/material.dart';
import 'presentation/config/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/group/group_bloc.dart';
import 'presentation/bloc/type/type_bloc.dart';
import 'presentation/bloc/theme/theme_bloc.dart';
import 'presentation/bloc/setup/setup_bloc.dart';
import 'presentation/bloc/password/password_bloc.dart';
import 'presentation/config/navigation/app_router.dart';
import 'presentation/pages/start_up.dart';
import 'presentation/config/navigation/app_navigation.dart';
import 'presentation/config/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupBloc>(create: (context) => GroupBloc(),),
        BlocProvider<TypeBloc>(create: (context) => TypeBloc(),),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc(),),
        BlocProvider<SetupBloc>(create: (context) => SetupBloc(),), 
        BlocProvider<PasswordBloc>(create: (context) => PasswordBloc()),       
      ], 
      child: Builder(
        builder: (context){
          final userState = context.watch<ThemeBloc>().state;
          if (userState is ThemeChosenState) {
            return buildWithState(context, userState.themeData);
          }
          if (userState is ThemeInitial) {
            return buildWithState(context, userState.themeData);
          }
          return const Text('A Widget');          
        },
      ),
    );
  }
}
Widget buildWithState(BuildContext context, ThemeData? themeData) {
  final AppRouter _appRouter = AppRouter();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Passwords',
    home: const StartUp(option: StartUpScreens.home,),
    theme: themeData,
    navigatorKey: di.sl<AppNavigation>().navigatorKey,
    onGenerateRoute: _appRouter.onGenerateRoute,
  );
}