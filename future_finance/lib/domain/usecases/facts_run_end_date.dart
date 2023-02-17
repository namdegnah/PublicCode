import '../../presentation/config/constants.dart';
import '../../data/models/facts_base.dart';
import '../entities/accounts/account.dart';
import '../entities/accounts/cash_action.dart';
import '../entities/category.dart';
import '../entities/recurrence.dart';
import '../entities/transaction.dart';
import '../entities/transfer.dart';
import '../../core/util/date_time_extension.dart';
import 'recurrence_facts_usecase.dart';


extension process_transfers on List<Transfer> {
  List<CashAction> process({required FactsBase facts, required DateTime startDate, required DateTime finishDate}){
    List<CashAction> actions = [];
    for(Transfer trans in this){
      if(trans.recurrenceId == 0){        
        Account toAccount = facts.accounts.firstWhere((acct) => acct.id == trans.toAccountId); 
        Account fromAccount = facts.accounts.firstWhere((acct) => acct.id == trans.fromAccountId); 
        Category category = facts.categories.firstWhere((catg) => catg.id == trans.categoryId);       
        bool used = trans.usedForCashFlow && toAccount.usedForCashFlow && fromAccount.usedForCashFlow && category.usedForCashFlow;        
        bool valid = trans.plannedDate!.isAfterOrEqual(startDate) && trans.plannedDate!.isBeforeOrEqual(finishDate) && trans.processed == SettingNames.userArchiveFalse;
        if(used && valid){
          actions.add(CashAction(tb: trans, account: toAccount, amount: trans.amount, plannedDate: trans.plannedDate!));
          actions.add(CashAction(tb: trans, account: fromAccount, amount: -1 * trans.amount, plannedDate: trans.plannedDate!));
        }
      } else {
        Account toAccount = facts.accounts.firstWhere((acct) => acct.id == trans.toAccountId); 
        Account fromAccount = facts.accounts.firstWhere((acct) => acct.id == trans.fromAccountId);
        bool used = trans.usedForCashFlow && toAccount.usedForCashFlow && fromAccount.usedForCashFlow;
        if(used){
          Recurrence recurrence = facts.recurrences.firstWhere((rec) => rec.id == trans.recurrenceId);
          actions.addAll(recurrence.process(startDate: startDate, finishDate: finishDate, tb: trans, toAccount: toAccount, fromAccount: fromAccount));
        }        
      }
    }
    return actions;
  }
}

extension process_transactions on List<Transaction> {
  List<CashAction> process({required FactsBase facts, required DateTime startDate, required DateTime finishDate}){
    List<CashAction> actions = [];
    for(Transaction trans in this){
      if(trans.recurrenceId == 0){ // a one off
        Account account = facts.accounts.firstWhere((acct) => acct.id == trans.accountId);
        Category category = facts.categories.firstWhere((catg) => catg.id == trans.categoryId);
        bool used = trans.usedForCashFlow && account.usedForCashFlow && category.usedForCashFlow;
        bool valid = trans.plannedDate!.isAfterOrEqual(startDate) && trans.plannedDate!.isBeforeOrEqual(finishDate) && trans.processed == SettingNames.userArchiveFalse;
        double am;
        trans.credit ? am = trans.amount : am = -1 * trans.amount;
        if(used && valid){
          if ((trans.processed == SettingNames.processed_interest_temp) && (trans.amount == AppConstants.noBalance)) {
            actions.add(CashActionDayEvent(tb: trans, account: account, amount: am, plannedDate: trans.plannedDate!));
          } else {
            actions.add(CashAction(tb: trans, account: account, amount: am, plannedDate: trans.plannedDate!));
          }
          
        }     
      } else { // a recurrence
        Account account = facts.accounts.firstWhere((acct) => acct.id == trans.accountId);
        Category category = facts.categories.firstWhere((catg) => catg.id == trans.categoryId);
        bool used = trans.usedForCashFlow && account.usedForCashFlow && category.usedForCashFlow;
        if(used){
          Recurrence recurrence = facts.recurrences.firstWhere((rec) => rec.id == trans.recurrenceId);
          actions.addAll(recurrence.process(startDate: startDate, finishDate: finishDate, tb: trans, toAccount: account, fromAccount: null));
        }        
      }
    }
    return actions;
  } 
}


