import 'package:passwords/data/models/d_base.dart' as dbase;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:passwords/presentation/config/injection_container.dart' as di;
import 'package:passwords/main.dart' as app;
import 'crud_tests/group_test.dart' as groups;
import 'crud_tests/type_test.dart' as types;



void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Future<Widget> createWidgetUnderTest(bool initialise) async {
    if(initialise) await di.init();
    dbase.cleanDatabase();
    return const app.MyApp();
  } 
  group(
    'Password Integration Tests',
    (){
      testWidgets(
        'Open AppDrawer and find the all ListTiles',
        (tester) async {
          await tester.pumpWidget(await createWidgetUnderTest(true));
          // await groups.groupCRUD(tester);
          await types.typeCRUD(tester);
          // groups.groupUpdate(tester, groupName);
          // groups.groupDelete(tester, groupName);
          // types.typeCreate(tester, groupName, type);
          // passwords.passwordCreate(tester, etc);
          // passwords.passwordUpdate(tester, etc);
          // passwords.passwordDelete(tester, etc);
          // then open the app to find no data
          // Wait if during the test development
          await Future.delayed(const Duration(seconds: 3));                                           
        }
      );
    });
}
Future<void> setUpPage(WidgetTester tester, Key key) async {
  final button = find.byKey(key);
  expect(button, findsOneWidget);
  await tester.tap(button);
  await tester.pumpAndSettle();  
}
Future<void> savePage(WidgetTester tester, Key key) async {
  final saveButton = find.byKey(key);
  expect(saveButton, findsOneWidget);   
  await tester.tap(saveButton);
  await tester.pumpAndSettle();
}
Future<void> goBack(WidgetTester tester) async {
  final NavigatorState navigator = tester.state(find.byType(Navigator));
  navigator.pop();
  await tester.pump();
}