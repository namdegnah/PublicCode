import 'package:flutter/material.dart';
import 'presentation/config/injection_container.dart' as di;
import 'presentation/pages/my_home_page.dart';
import 'presentation/config/navigation/app_router.dart';
import 'presentation/config/navigation/app_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/http/http_bloc.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<HttpBloc>(create: (context) => HttpBloc(),),          
      ],      
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Test and Test Again',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: 'Testing'),
            navigatorKey: di.sl<AppNavigation>().navigatorKey,
            onGenerateRoute: appRouter.onGenerateRoute,      
          );
        }
      ),
    );
  }
}


