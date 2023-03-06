import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:passwords/main.dart.';
import 'package:passwords/presentation/pages/home_screen.dart';
import 'package:passwords/presentation/config/navigation/app_router.dart';
import 'package:passwords/presentation/config/navigation/app_navigation.dart';
import 'package:passwords/presentation/config/injection_container.dart' as di;
import 'package:passwords/presentation/config/constants.dart';
import 'package:passwords/main.dart' as app;
void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<Widget> createWidgetUnderTest() async {
    // final AppRouter _appRouter = AppRouter();
    await di.init();
    return MyApp();
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,        
    //   title: 'Widget Test Todo List',
    //   home: HomeScreen(),
    //   navigatorKey: di.sl<AppNavigation>().navigatorKey,
    //   onGenerateRoute: _appRouter.onGenerateRoute,      
    // );
  }  
  group(
    'Password Integration Tests',
    (){
      testWidgets(
        'Open AppDrawer and find the all ListTiles',
        (tester) async {
          // app.main();
          // await tester.pumpAndSettle();
          await tester.pumpWidget(await createWidgetUnderTest());
          // await tester.pump();
          final ScaffoldState state = tester.firstState(find.byType(Scaffold));       
          state.openDrawer(); 
          // await tester.pump();  
          // final backup = find.byIcon(Icons.backup);
          // expect(backup, findsOneWidget);
          // final home = find.byKey(Key('HomeAppDrawer'));      
          // expect(home, findsOneWidget);
          // final groups = find.byKey(Key('GroupsAppsDrawer'));      
          // expect(groups, findsOneWidget);
          // final types = find.byKey(Key('TypesAppsDrawer'));      
          // expect(types, findsOneWidget);
          // final passwords = find.byKey(Key('PasswordsAppsDrawer'));      
          // expect(passwords, findsOneWidget);
          // final search = find.byKey(Key('SearchAppsDrawer'));      
          // expect(search, findsOneWidget); 
          // await tester.pump();
          // await tester.ensureVisible(home);
          // await tester.tap(home); 
          await Future.delayed(Duration(seconds: 5));
          // await tester.pumpAndSettle();                                      
        }
      );
    });
}
