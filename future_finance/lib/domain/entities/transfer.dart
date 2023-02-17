import '../../data/models/trans_base_abstract.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Transfer extends TransBase {

  var formatDate = DateFormat('dd-MM-yy'); 
  
  int fromAccountId;
  int toAccountId;
  int categoryId;
  int recurrenceId;
  bool usedForCashFlow;
  Transfer({
    required id,
    required user_id,
    required title,
    required description,
    required processed,
    required this.fromAccountId,
    required this.toAccountId,
    required this.categoryId,
    required this.recurrenceId,
    required amount,
    required plannedDate,
    this.usedForCashFlow = true,
    
  }) : super(id: id, user_id: user_id, title: title, description: description, plannedDate: plannedDate, amount: amount, processed: processed);

  DateTime get finish => plannedDate ?? DateTime.now();
 
  set finish(DateTime c) {
    if(c != null && c != plannedDate){
      plannedDate = c;
    }
  }
  Widget showDateSetting(){
    if(plannedDate == null){
      return const Text('No Date Chosen');
    } else {
      return Text('Planned Date: ${formatDate.format(plannedDate!)}');
    }   
  }  
}