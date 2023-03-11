import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../app_test.dart';
import '../keys.dart';

var names = ['Personal', 'Developer', 'Work', 'Home'];

Future<void> groupCRUD(WidgetTester tester) async {
  // say create 4 new groups []
  for(var i = 0; i < 4; i++) await groupCreate(tester, i);
  // update just one of them and also []
  await groupUpdate(tester, 0);
  // now delete all of them via []
  for(var i = 0; i < 4; i++) await groupDelete(tester, i);
}
Future<void> groupCreate(WidgetTester tester, int index) async {
  await setUpPage(tester, groupsButtonKey);
  // find, confirm and press the Add Group Button
  final addButton = find.byKey(const Key('addGroupButton'));
  expect(addButton, findsOneWidget);
  await tester.tap(addButton);
  await tester.pumpAndSettle();
  // find, confirm and enter text into the Group Name Text Field
  final groupTextField = find.byKey(const Key('groupNameTextFormField'));
  expect(groupTextField, findsOneWidget);
  await tester.enterText(groupTextField, names[index]);
  await tester.pumpAndSettle();
  await savePage(tester, groupSaveButton);
  // find and confirm the new Group List Tile
  final tileObject = find.byWidgetPredicate((w) => w is ListTile && names[index].compareTo((w.title as Text).data!) == 0);
  expect(tileObject, findsOneWidget);
  ListTile tile = tester.firstWidget(tileObject); 
  expect(names[index], (tile.title! as Text).data);         
  await goBack(tester);
}
Future<void> groupUpdate(WidgetTester tester, int index) async {
  await setUpPage(tester, groupsButtonKey);
  await findAndTapTheGroup(tester, index, EditOrDelete.edit);
  // now find the group name 
  final groupTextField = find.byKey(const Key('groupNameTextFormField'));
  expect(groupTextField, findsOneWidget);
  TextFormField tff = tester.firstWidget(groupTextField); 
  names[index] = '${tff.controller!.text} Edited';
  tff.controller!.text = names[0];
  await tester.pumpAndSettle();  
  await savePage(tester, groupSaveButton);
  await goBack(tester);  
}
Future<void> groupDelete(WidgetTester tester, int index) async {
  await setUpPage(tester, groupsButtonKey);
  await findAndTapTheGroup(tester, index, EditOrDelete.delete);
  await goBack(tester);   
}
Future<void> findAndTapTheGroup(WidgetTester tester, int index, EditOrDelete value) async {
  // find the ListTile, get the IconButton and obtain its key, find the button by key and tap it.
  final tileObject = find.byWidgetPredicate((w) => w is ListTile && names[index].compareTo((w.title as Text).data!) == 0);
  expect(tileObject, findsOneWidget);
  ListTile tile = tester.firstWidget(tileObject); 
  SizedBox box = tile.trailing as SizedBox;
  Row row = box.child as Row;
  IconButton ib = row.children[value.index] as IconButton;
  final editButton = find.byKey(ib.key!);
  await tester.tap(editButton);
  await tester.pumpAndSettle();  
}
enum EditOrDelete {edit, delete}
