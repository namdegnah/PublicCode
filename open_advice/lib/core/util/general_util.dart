import 'package:flutter/material.dart';

class GeneralUtil {
  static Future<String> getAppName() async {

    String appName = 'macf.db';
    return removeSpaces(
        appName); 
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
extension xy on List<int> {
  int total() {
    int tot = 0;
    for (int x in this) {
      tot += x;
    }
    return tot;
  }
}

extension contName on Widget {
  addContainer(double pad) {
    return Container(
      padding: EdgeInsets.all(pad),
      margin: EdgeInsets.all(pad),
      child: this,
    );
  }
}

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

extension wall on Widget {
  Widget paddAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);
}


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
