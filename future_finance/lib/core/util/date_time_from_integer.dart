import 'package:dartz/dartz.dart';
import '../errors/error_export.dart';
class DateTimeFromInteger{
  Either<Failure, DateTime> convertIntegerToDate(int number){
    try{
      String start = number.toString();
      String? _days = start.substring(6, 8);
      int? days = int.tryParse(_days);
      days = days ?? 0;
      days -= 10;
      String _months = start.substring(4, 6);
      int? months = int.tryParse(_months);
      months = months ?? 0;
      months -= 10;
      String _years = start.substring(0, 4);
      int? years = int.tryParse(_years);
      years = years ?? 0;
      years -= 1000;
      if(years < 0) throw DateConversionFailure('Invalid years $years');
      if(months < 0 || months > 12) throw DateConversionFailure('Invalid months $months');
      if(days < 0 || days > 31) throw DateConversionFailure('Invalid days $days');
      DateTime ans = DateTime(years, months, days);
      return Right(ans);
    } on DateConversionFailure catch(error) {
        return Left(error);
      //return Left(DateConversionFailure('Invalid number that can not be converted to a number $number'));
    } on Exception catch(error) {
      return Left(DateConversionFailure(error.toString()));
    }  
  }
  Either<Failure, int> convertDateTimeToInteger(DateTime input){
    try{
      int days = input.day + 10;
      int months = input.month + 10;
      int years = input.year + 1000;
      String all = years.toString() + months.toString() + days.toString();
      int? ans = int.tryParse(all);
      if(ans == null) throw DateConversionFailure('could not convert date to integer $input');
      return Right(ans);
    } on DateConversionFailure {
      return Left(DateConversionFailure('Invalid date that can not be encoded to a number $input'));
    } on Exception catch(error){
       return Left(DateConversionFailure(error.toString()));
    }
  }    
}