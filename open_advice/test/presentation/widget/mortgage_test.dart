import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:open_advice/presentation/widgets/mortgage_calculator_widget.dart';

void main(){

  setUp(() {
  });  

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: MortgageCalculatorWidget(),
    );
  }
  testWidgets(
    "Morgage Calculator",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      final amount = find.byKey(const Key('mortgageAmount'));
      await tester.enterText(amount, '250000');
      final rate = find.byKey(const Key('interestRate'));
      await tester.enterText(rate, '3.25');
      final period = find.byKey(const Key('mortgagePeriod'));
      await tester.enterText(period, '20');
      final button = find.byKey(const Key('calculateMortgage'));
      await tester.tap(button);
      await tester.pump();
      final repayment = find.byKey(const Key('monthlyRepayment'));
      final TextFormField text = tester.firstWidget(repayment);
      String stringValue = text.controller!.text;
      stringValue = stringValue.substring(1, stringValue.length); //take off the curency symbol
      double value = double.parse(stringValue);     
      expect(value, 1417.99);
    },
  );   
}