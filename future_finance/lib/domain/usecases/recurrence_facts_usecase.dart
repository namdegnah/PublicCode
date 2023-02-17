import '../entities/recurrence.dart';
import '../entities/accounts/cash_action.dart';
import '../../domain/entities/transaction.dart';
import '../../data/models/trans_base_abstract.dart';
import '../entities/accounts/account.dart';
import '../../core/util/date_time_extension.dart';
import '../../presentation/config/constants.dart';

extension factsRun on Recurrence {

  DateTime? getEndDate(TransBase tb){
    var c = noOccurences ?? 0;
    DateTime? ans;
    if(c == 0 && endDate == null){
      ans = null;
    }
    if(c > 0 && endDate == null){
      switch(type){
      case Recurrence.week:
        ans= DateTime(tb.plannedDate!.year, tb.plannedDate!.month, tb.plannedDate!.day + ((noOccurences! - 1) * 7));
      break;
      case Recurrence.month:
         ans= DateTime(tb.plannedDate!.year, tb.plannedDate!.month + (noOccurences! - 1), tb.plannedDate!.day);  
      break;
      case Recurrence.quarter:
         ans= DateTime(tb.plannedDate!.year, tb.plannedDate!.month + (3 * (noOccurences! - 1)), tb.plannedDate!.day);
      break;
      case Recurrence.year:
        ans= DateTime(tb.plannedDate!.year + (noOccurences! - 1), tb.plannedDate!.month, tb.plannedDate!.day);
      break;
      }
    }
    if(c == 0 && endDate != null){
      ans = endDate;
    }    
    return ans;
  }
  
  List<CashAction> process({required DateTime startDate, required DateTime finishDate, required TransBase tb, required Account toAccount, Account? fromAccount}){
    List<CashAction> actions = [];
    var c = noOccurences ?? 0;
    if(c == 0 && endDate == null){
      actions = toFactsRunEnd(startDate: startDate, finishDate: finishDate, tb: tb, toAccount: toAccount, fromAccount: fromAccount);
    }
    if(c > 0 && endDate == null){
      actions = toOccurenceEnd(startDate: startDate, finishDate: finishDate, tb: tb, toAccount: toAccount, fromAccount: fromAccount);
    }
    if(c == 0 && endDate != null){
      actions = toEndDate(finishDate: finishDate, startDate: startDate, tb: tb, toAccount: toAccount, fromAccount: fromAccount);
    }
    return actions;    
  }
  List<CashAction> toFactsRunEnd({required DateTime startDate, required DateTime finishDate, required TransBase tb, required Account toAccount, Account? fromAccount}){
    List<CashAction> actions = [];
    
    switch(type){
      case Recurrence.week:
        DateTime nextDate = tb.plannedDate!.getWeeklyNextDate(startDate);
        while(nextDate.isBeforeOrEqual(finishDate)){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: nextDate);
          nextDate = DateTime(nextDate.year, nextDate.month, nextDate.day + 7);
        }
      break;
      case Recurrence.month:
        DateTime nextDate = tb.plannedDate!.getMonthlyNextDate(startDate);
        while(nextDate.isBeforeOrEqual(finishDate)){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: nextDate);
          nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
        }        
      break;
      case Recurrence.quarter:
        DateTime nextDate = tb.plannedDate!.getQuarterlyNextDate(startDate);
        while(nextDate.isBeforeOrEqual(finishDate)){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: nextDate);
          nextDate = DateTime(nextDate.year, nextDate.month + 3, nextDate.day);
        }      
      break;
      case Recurrence.year:
        DateTime nextDate = tb.plannedDate!.getYearlyNextDate(startDate);
        while(nextDate.isBeforeOrEqual(finishDate)){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: nextDate);
          nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
        }      
      break;
    }
    return actions;    
  }
  List<CashAction> toEndDate({required DateTime startDate, required DateTime finishDate, required TransBase tb, required Account toAccount, Account? fromAccount}){
    List<CashAction> actions = [];

    switch(type){
      case Recurrence.week:
        DateTime nextDate = tb.plannedDate!.getWeeklyNextDate(startDate);
        while(nextDate.isBeforeOrEqual(finishDate) && nextDate.isBeforeOrEqual(endDate!)){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: nextDate);
          nextDate = DateTime(nextDate.year, nextDate.month, nextDate.day + 7);
        }
      break;
      case Recurrence.month:
        DateTime nextDate = tb.plannedDate!.getMonthlyNextDate(startDate);
        while(nextDate.isBeforeOrEqual(finishDate) && nextDate.isBeforeOrEqual(endDate!)){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: nextDate);
          nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
        }        
      break;
      case Recurrence.quarter:
        DateTime nextDate = tb.plannedDate!.getQuarterlyNextDate(startDate);
        while(nextDate.isBeforeOrEqual(finishDate) && nextDate.isBeforeOrEqual(endDate!)){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: nextDate);
          nextDate = DateTime(nextDate.year, nextDate.month + 3, nextDate.day);
        }      
      break;
      case Recurrence.year:
        DateTime nextDate = tb.plannedDate!.getYearlyNextDate(startDate);
        while(nextDate.isBeforeOrEqual(finishDate) && nextDate.isBeforeOrEqual(endDate!)){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: nextDate);
          nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
        }      
      break;
    }
    return actions;    
  }
  List<CashAction> toOccurenceEnd({required DateTime startDate, required DateTime finishDate, required TransBase tb, required Account toAccount, Account? fromAccount}){
    List<CashAction> actions = [];
    
    switch(type){
      case Recurrence.week:
        OcurrenceSince od = startDate.ocurrenceWeeklySinceStart(plannedDate: tb.plannedDate!);
        while(od.nextDate.isBeforeOrEqual(finishDate) && od.noPaid < noOccurences!){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: od.nextDate);
          od.noPaid++;
          od.nextDate = DateTime(od.nextDate.year, od.nextDate.month, od.nextDate.day + 7);
        }
      break;
      case Recurrence.month:
        OcurrenceSince od = startDate.ocurrenceMonthlySinceStart(plannedDate: tb.plannedDate!);
        while(od.nextDate.isBeforeOrEqual(finishDate) && od.noPaid < noOccurences!){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: od.nextDate);
          od.noPaid++;
          od.nextDate = DateTime(od.nextDate.year, od.nextDate.month + 1, od.nextDate.day);
        }        
      break;
      case Recurrence.quarter:
        OcurrenceSince od = startDate.ocurrenceQuarterlySinceStart(plannedDate: tb.plannedDate!);
        while(od.nextDate.isBeforeOrEqual(finishDate) && od.noPaid < noOccurences!){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: od.nextDate);
          od.noPaid++;
          od.nextDate = DateTime(od.nextDate.year, od.nextDate.month + 3, od.nextDate.day);
        }      
      break;
      case Recurrence.year:
        OcurrenceSince od = startDate.ocurrenceYearlySinceStart(plannedDate: tb.plannedDate!);
        while(od.nextDate.isBeforeOrEqual(finishDate) && od.noPaid < noOccurences!){
          actions = addTransferOrTransaction(tb: tb, fromAccount: fromAccount, toAccount: toAccount, actions: actions, date: od.nextDate);
          od.noPaid++;
          od.nextDate = DateTime(od.nextDate.year + 1, od.nextDate.month, od.nextDate.day);
        }      
      break;
    }
    return actions;    
  }
  List<CashAction> addTransferOrTransaction({required List<CashAction> actions, required TransBase tb, required Account toAccount, Account? fromAccount, required DateTime date}){
    if(fromAccount == null){
      double am = tb.amount;
      Transaction trans = tb as Transaction;
      if(!trans.credit) am = -1 * am;
      if(trans.amount == AppConstants.noBalance && (trans.processed == SettingNames.processed_interest_temp)) {
        actions.add(CashActionDayEvent(tb: tb, account: toAccount, plannedDate: date, amount: am));
      } else {
        actions.add(CashAction(tb: tb, account: toAccount, plannedDate: date, amount: am));
      }      
    } else {
      actions.add(CashAction(tb: tb, account: toAccount, plannedDate: date, amount: tb.amount)); 
      actions.add(CashAction(tb: tb, account: fromAccount, plannedDate: date, amount: -1 * tb.amount));
    }
    return actions;   
  }    
}