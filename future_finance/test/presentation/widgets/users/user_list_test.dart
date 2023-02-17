import 'package:flutter_test/flutter_test.dart';
import 'package:future_finance/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:future_finance/presentation/widgets/users/users_list.dart';
import 'package:future_finance/presentation/config/injection_container.dart' as di;

void main(){

  final userFromDatabase =[
    User(id: 1, name: 'User 1', email: 'user1@gmail.com', password: 'a'),
    User(id: 2, name: 'User 2', email: 'user2@gmail.com', password: 'a'),
    User(id: 3, name: 'User 3', email: 'user3@gmail.com', password: 'a'),
  ];

  setUp(() {
  });  

  Widget createWidgetUnderTest() {
    WidgetsFlutterBinding.ensureInitialized();
    di.init();    
    return MaterialApp(
      debugShowCheckedModeBanner: false,        
      title: 'Widget Test User List',
      home: UserList(userFromDatabase),
    );
  }
  testWidgets(
    "title is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Users'), findsOneWidget);
    },
  );   
}