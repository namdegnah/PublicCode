import '../../data/models/trans_base_abstract.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Transaction extends TransBase {

  var formatDate = DateFormat('dd-MM-yy'); 

  int accountId;
  int categoryId;
  int recurrenceId;
  bool credit;
  
  Transaction({
    required id,
    required user_id,
    required title,
    required description,
    required plannedDate,
    required amount,
    required processed,
    usedForCashFlow,
    required this.accountId,
    required this.categoryId,
    required this.recurrenceId,
    required this.credit,
    // @required this.processed,
   
  }) : super(id: id, user_id: user_id, title: title, description: description, plannedDate: plannedDate, amount: amount, usedForCashFlow: usedForCashFlow, processed: processed);

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