import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  HttpOverrides.global = _MyHttpOverrides(); // Setting a customer override that'll use an unmocked HTTP client
  var uri = 'https://www.google.com/';
  testWidgets(
    'Test with HTTP enabled',
    (tester) async {
      await tester.runAsync(() async { // Use `runAsync` to make real asynchronous calls
        expect(
          (await http.Client().get(Uri.parse(uri))).statusCode,
          200,
        );
      });
    },
  );
}

class _MyHttpOverrides extends HttpOverrides {}