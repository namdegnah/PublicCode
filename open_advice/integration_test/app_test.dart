import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:open_advice/main.dart.' as app;
import 'package:open_advice/presentation/config/injection_container.dart' as di;


void main(){

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const total = 8;
  Future<Widget> createWidgetUnderTest(bool initialise) async {
    if(initialise) await di.init();
    return const app.MyApp();
  }
  group('App Testing', () {

    testWidgets('Click on the button $total times', (WidgetTester tester) async {
      
      await tester.pumpWidget(await createWidgetUnderTest(true));
               
      final button = find.byKey(const Key('floatfloat'));
      for(var i = 0; i < total; i++){
        await tester.tap(button);
      } 
      await tester.pumpAndSettle();
      expect(button, findsOneWidget);
      final textObject = find.byKey(const Key('counterTextcounterText'));
      Text text = tester.firstWidget(textObject);
      int value = int.parse(text.data!);
      expect(value, total);
      await Future.delayed(const Duration(seconds: 3));
    });

    testWidgets('click on the button and find a particular password', (tester) async {
      await tester.pumpWidget(await createWidgetUnderTest(false));

      final buttonObject = find.byKey(const Key('loadnextpage'));
      expect(buttonObject, findsOneWidget);
      await tester.tap(buttonObject);
      await tester.pumpAndSettle();
      final textSObject = find.byKey(const Key('nextpagenextpage'));
      expect(textSObject, findsOneWidget);
      final tileObject = find.byWidgetPredicate((w) => w is ListTile && 'Udemy'.compareTo((w.title as Text).data!) == 0);
      expect(tileObject, findsOneWidget);
      ListTile tile = tester.firstWidget(tileObject);
      print(tile.subtitle);
      final sem = tester.getSemantics(tileObject);
      await Future.delayed(const Duration(seconds: 3));
    });
    testWidgets('click on the button and find the best team', (tester) async {
      await tester.pumpWidget(await createWidgetUnderTest(false));
      final buttonObject = find.byKey(const Key('btfootball'));
      expect(buttonObject, findsOneWidget);
      await tester.tap(buttonObject);
      await tester.pumpAndSettle();
      final textSObject = find.byKey(const Key('bestteamname'));
      expect(textSObject, findsOneWidget);
      Text teamName = tester.firstWidget(textSObject);
      print('Best team is ${teamName.data}');
      await Future.delayed(const Duration(seconds: 5));
    });    
  });
}