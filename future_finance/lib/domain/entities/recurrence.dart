import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'accounts/account_add_interest.dart';

class Recurrence {
  int id;
  String title;
  String description;
  String iconPath;
  int type;
  int? noOccurences;
  DateTime? endDate;

  var formatDate = DateFormat('dd-MM-yy');  

  Recurrence({

    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.type,
    this.noOccurences,
    this.endDate
  });

  static const week = 0; static const month = 1; static const quarter = 2; static const year = 3;

  final List<int> values = [0, 1, 2, 3];
  final List<String> terms = ['Weekly', 'Monthly', 'Quarterly', 'Yearly'];
  String get term => 'Type is: ${terms[type]}';
  set recType(int i){
    if(i != type){
      type = i;
    }
  }
  
  DateTime get finish => endDate!;
 
  set finish(DateTime c) {
    
    if(c != null && endDate != null && c != endDate){
      endDate = c;
    }
  }
  Widget showDateSetting(){
    if(endDate == null){
      return const Text('No Date Chosen');
    } else {
      return Text('End Date: ${formatDate.format(endDate!)}');
    }   
  }  
}