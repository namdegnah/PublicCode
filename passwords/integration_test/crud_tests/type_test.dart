import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../app_test.dart';
import '../keys.dart';

var names = ['Website', 'Developer', 'Work', 'Home'];
var fields = [true, false, false, false, false, false, false, false, false, true, false, false, false, false];
  late Finder wizzardNextButton;
  late Finder wizzardAddButton;
  
Future<void> typeCRUD(WidgetTester tester) async {

  await typeCreate(tester, 0);
}

Future<void> typeCreate(WidgetTester tester, int index) async {
  await setUpPage(tester, typesButtonKey);
  // find and press the add button to create a new type
  final addButton = find.byKey(addTypeButton);
  expect(addButton, findsOneWidget);
  await tester.tap(addButton);
  await tester.pumpAndSettle();
  // find, confirm and enter text into the Group Name Text Field
  final typeTextField = find.byKey(typeNameText);
  expect(typeTextField, findsOneWidget);
  await tester.enterText(typeTextField, names[index]);
  await tester.pumpAndSettle();
  await savePage(tester, typeSaveButton);
  // setup the wizzard Next and Add Buttons
  wizzardNextButton = find.byKey(typeWizardNextButton);
  expect(wizzardNextButton, findsOneWidget);
  wizzardAddButton = find.byKey(typeWizzardAddButton);
  expect(wizzardAddButton, findsOneWidget); 
  // now go through the wizzard  
  await passwordChoice(tester, passwordMediumType);
  await descriptionChoice(tester);
  for(var i = 0; i < 14; i++){
    await choices(tester, fields[i]);
  }
  await savePage(tester, typeWizzardSaveButton);
  await goBack(tester);
}
Future<void> typeUpdate(WidgetTester tester) async {}
Future<void> typeDelete(WidgetTester tester) async {}
Future<void> passwordChoice(WidgetTester tester, Key key) async {
  // select strength password, click the add and next buttons  
  final strengthPassword = find.byKey(key);
  expect(strengthPassword, findsOneWidget);
  await tester.tap(strengthPassword);
  await tester.pumpAndSettle();
  await tester.tap(wizzardAddButton);
  await tester.pumpAndSettle();
  await tester.tap(wizzardNextButton);
  await tester.pumpAndSettle();  
}
Future<void> descriptionChoice(WidgetTester tester) async {
  await tester.tap(wizzardNextButton);
  await tester.pumpAndSettle();  
}

Future<void> choices(WidgetTester tester, bool choice) async {
  if(choice) {
    await tester.tap(wizzardAddButton);
    await tester.pumpAndSettle();    
  }
  await tester.tap(wizzardNextButton);
  await tester.pumpAndSettle();  
}
