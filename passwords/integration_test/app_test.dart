import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:passwords/presentation/pages/home_screen.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetUnderTest() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,        
      title: 'Widget Test Todo List',
      home: HomeScreen(),
    );
  }  
  group(
    'Password Integration Tests',
    (){
      testWidgets(
        'Open AppDrawer and find the home link',
        (tester) async {
          await tester.pumpWidget(createWidgetUnderTest());
          final ScaffoldState state = tester.firstState(find.byType(Scaffold));
          state.openDrawer(); 
          await tester.pump();   
          final home = find.byKey(Key('HomeAppDrawer'));      
          expect(home, findsOneWidget);
          final groups = find.byKey(Key('GroupsAppsDrawer'));      
          expect(groups, findsOneWidget);
          final types = find.byKey(Key('TypesAppsDrawer'));      
          expect(types, findsOneWidget);
          final passwords = find.byKey(Key('PasswordsAppsDrawer'));      
          expect(passwords, findsOneWidget);
          final search = find.byKey(Key('SearchAppsDrawer'));      
          expect(search, findsOneWidget);                                        
        }
      );
    });
}
