import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import 'dart:io';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';

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
class GeneralUtil {
  static Future<String> getAppName() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    String appName = 'macf.db';
    return removeSpaces(
        appName); //For Future Financial Facts this needs to be fixed for upgrades
  }

  static String removeSpaces(String toRemove) {
    return toRemove.replaceAll(RegExp(r"\s+\b|\b\s"), "");
  }

  static DateTime today() {
    DateTime d = DateTime.now();
    return DateTime(d.year, d.month, d.day);
  }

  static String dateToString(DateTime d) {
    return d.toIso8601String();
  }

  static DateTime yesterday() {
    DateTime d = DateTime.now();
    return DateTime(d.year, d.month, d.day - 1);
  }

  //My decode of a date stored as an integer, converts it back to a date
  static DateTime timeFromInt(int intTime) {
    try {
      String start = intTime.toString();
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
      DateTime ans = DateTime(years, months, days);
      return ans;
    } on Exception {
      rethrow;
    }
  }



  //My encode of a date into an integer
  static int intFromTime(DateTime time) {
    try {
      int days = time.day + 10;
      int months = time.month + 10;
      int years = time.year + 1000;
      String all = years.toString() + months.toString() + days.toString();
      int? ans = int.tryParse(all);
      ans = ans ?? 0;
      return ans;
    } on Exception {
      rethrow;
    }
  }

  //encoding account_id and account_type into one int
  static int intFromIdAndType({required int id, required int type}) {
    int nType = type * 1000;
    return nType + id;
  }

  //decoding account_id and account_type from one int
  static Parts decodeIdAndType(int value) {
    int x = value.remainder(1000);
    int y = (value - x);
    double z = y / 1000;
    int v = z.toInt();
    Parts ans = Parts(id: x, type: v);
    return ans;
  }

  static DateTime oneYearFromNow() {
    DateTime v = DateTime(
        DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
    return v;
  }

  static int numberOfDaysThisYear() {
    int year = DateTime.now().year;
    if ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)) {
      return 366;
    }
    return 365;
  }
}

extension MyList on List<int> {
  int get sum => fold(0, (a, b) => a + b);
}

// this is the method for an extension method on List<Account> or List<CashFlow> etc, iterate through the list and return what is required
// ignore: camel_case_extensions
extension xy on List<int> {
  int total() {
    int tot = 0;
    for (int x in this) {
      tot += x;
    }
    return tot;
  }
}

// ignore: camel_case_extensions
extension contName on Widget {
  addContainer(double pad) {
    return Container(
      padding: EdgeInsets.all(pad),
      margin: EdgeInsets.all(pad),
      child: this,
    );
  }
}

// ignore: camel_case_extensions
extension x1 on Text {
  buff({required double pad}) {
    String? theData = data;
    theData = theData ?? 'null';
    return Text(
      theData,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    ).addContainer(pad);
  }
}

// ignore: camel_case_extensions
extension polishName on Text {
  polish({required double pad, required double size}) {
    String? theData = data;
    theData = theData ?? 'null';    
    return Text(
      theData,
      style: TextStyle(
          color: Colors.black,
          fontSize: size,
          fontWeight: FontWeight.normal,
          shadows: const [
            Shadow(
                color: Colors.black26,
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0)
          ]),
    ).addContainer(pad);
  }
}

// ignore: camel_case_extensions
extension wall on Widget {
  Widget paddAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);
}

// ignore: camel_case_extensions
extension wlf on Widget {
  Widget paddLR(double padding) => Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: this,
      );
}

Map<String, Object> getMap(String column, int data) {
  return {
    column: data,
  };
}

class Parts {
  int type;
  int id;
  Parts({required this.type, required this.id});
}
Future<Directory> get downloadsPath async {
  try{
    Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
    return downloadsDirectory!;
  } catch (error) {
    rethrow;
  }
}
String addLineBreaks(String note){
  
  return '';
}