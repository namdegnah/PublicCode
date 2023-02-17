import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:future_finance/core/util/date_time_from_integer.dart' show DateTimeFromInteger;
import 'package:future_finance/core/errors/failures.dart' show DateConversionFailure;

void main(){
  late DateTimeFromInteger timeFromInteger;
  late int dateAsInt;
  late DateTime dateUncoded;

  setUp((){
    timeFromInteger = DateTimeFromInteger();
  });
  group('create a DateTime from an integer', () {
    test(
      'should return an date when the number is correctly encoded',
      () async {
      // arrage
      final input = DateTime(2022, 12, 31);
      // act
      final result = timeFromInteger.convertDateTimeToInteger(input);
      result.fold(
        (failure) {
          return Left(failure);
        },
        (integer) => dateAsInt = integer,      
      );      
      // assert
      expect(dateAsInt, equals(30222241));
      },
    );
    test(
      'should return a DateConversionFailure when an invalid number is not attempted to be converted to a date',
      () async {
      // arrage
      final input = 30222281;
      // act
      final result = timeFromInteger.convertIntegerToDate(input);      
      // assert
      expect(result, equals(Left(DateConversionFailure('Invalid days 71'))));
      },
    );
    test(
      'should return a valid date from a valid encoded integer',
      () async {
      // arrage
      final input = 30222241;
      // act
      final result = timeFromInteger.convertIntegerToDate(input);
      result.fold(
        (failure) {
          return Left(failure);
        },
        (date) => dateUncoded = date,      
      );      
      // assert
      expect(dateUncoded, equals(DateTime(2022, 12, 31)));
      },
    );    
  });
}