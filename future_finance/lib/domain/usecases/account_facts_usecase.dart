
import '../../presentation/widgets/common_widgets.dart';
import '../entities/accounts/account_classes.dart';
import '../../presentation/pages/paint/bar_loader.dart';
import '../../core/util/general_util.dart';
import '../entities/accounts/account_savings.dart';
import '../entities/transaction.dart';
import '../../presentation/config/constants.dart';
import '../entities/accounts/account.dart';
import '../entities/accounts/cash_item.dart';
import '../entities/accounts/cash_action.dart';
import '../../core/util/date_time_extension.dart';
import 'package:intl/intl.dart';
import '../../presentation/config/injection_container.dart';
import '../entities/accounts/account_balance_at.dart';
import '../entities/transfer.dart';
import '../../presentation/bloc/transactions/transaction_bloc_exports.dart' as TN;
import '../../presentation/bloc/transfers/transfer_bloc_exports.dart' as TF;
import '../../../domain/entities/setting.dart';
import '../usecases/account_consolidate.dart';

extension accountConsolidation on List<Account> {

  List<CashItem> consolidate({required DateTime start, required DateTime finish}){
    DateTime day = start;
    CashItem item;
    DataRow row;
    List<DataRow> rows = [];
    while(day.isBeforeOrEqual(finish)){
      row = DataRow();
      for(Account account in this){        
        item = (account.cashFlow.firstWhere((element) => element.action!.plannedDate.areDatesEqual(day), orElse: () => CashItem.noCashItem()));
        if (!item.noCashItem()) row.items.add(item);
        if(row.time == null && !item.noCashItem()){          
          if(item.action != null) row.time = item.action!.plannedDate;
        }
        item.noCashItem() ? row.data.add(0.0) : row.data.add(item.balance);        
      }
      if(!row.isEmpty()) rows.add(row);
      day = day.plusOneDay();
    }
    return rows.cashItems();
  }
}

extension accountProcess on Account {

  realTeam(){
    DateTime today = GeneralUtil.today();
    this.cashActions.sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
    //now find which is earlier lastRun or this._lastInterestAdded if it InterestPerDay
    DateTime start = getLastDate();
    if (this is AccountSavings) {
       start = (this as AccountSavings).lastInterestAdded!.plusOneDay();
    } 
    int i = 0;
    DateTime day = start;
    CashAction action;
    List<int> later = [];
    
    while(day.isBeforeOrEqual(today)){
      while(i < this.cashActions.length && this.cashActions[i].plannedDate.areDatesEqual(day)){
        action = this.cashActions[i];
        if(action.isPlainAccount()){
          this.balance += action.amount;
          action.tb!.processed = SettingNames.autoProcessedTrue;
          _updateCashAction(action);
        } else {
          later.add(i);
        }
        i++;
        if (i >= this.cashActions.length) break;
      }
      //if InterestPerDay then add the interest
      addAccountInterest(day);
      for(int i in later){
        action = this.cashActions[i];
        //if the cash action is OnThisDay action it
        if(action.amount == AppConstants.noBalance && action is OnThisDay){
          this.balance += (action as OnThisDay).transferInterestAndReturn()!;
        }         
      }
      later = [];
      day = day.plusOneDay();
    }
  }
  void _updateCashAction(CashAction action){

      if(action.tb is Transfer){
        Transfer tf = action.tb as Transfer;
        if(tf.recurrenceId == 0){
          sl<TF.TransferBloc>().add(TF.UpdateProcessedEvent(id: action.tb!.id));
        }       
      } else if(action.tb is Transaction) {
        Transaction tn = action.tb as Transaction;        
        if(tn.recurrenceId == 0 && tn.id != AccountSavingsNames.generatedTransaction){
          sl<TN.TransactionsBloc>().add(TN.UpdateProcessedEvent(id: action.tb!.id));
        }        
      } // else if neither do nothing needs updating     
  }
  barCharData(List<DateTime> endDates){
    if(this.usedForCashFlow){
      DateTime day = GeneralUtil.today();
      List<int> later = [];
      int i = 0;
      CashAction action;      
      this.cashActions.sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
      for(var endDate in endDates){
        this.balances.add(AccountBalanceAt(monthNo: endDate.month, balance: i == 0 ? this.balance: this.balances.last.balance ));                
        while(i < cashActions.length && day.isBeforeOrEqual(endDate)){
          while(this.cashActions[i].plannedDate.areDatesEqual(day)){
            action = this.cashActions[i];
            if(action.isPlainAccount()){
               this.balances.last.balance += cashActions[i].amount; 
            } else {
              later.add(i);
            }
            i++;
            if (i == this.cashActions.length) break;            
          }
          //if InterestPerDay then add the interest
          addAccountInterest(day);
          for(int i in later){
            action = this.cashActions[i];
            //if the cash action is OnThisDay action it
            if(action.amount == AppConstants.noBalance && action is OnThisDay) this.balance += (action as OnThisDay).transferTempInterestAndReturn()!;         
          }
          later = [];          
          day = day.plusOneDay();
        }
        this.loaders.add(BarLoader(height: this.balances.last.balance, value: 0, label: ''));
      }
    }
  }
  factsRunProcess({required DateTime start, required DateTime finish, bool addDatas = true}){
    DateTime day = start; int i = 0;
    CashAction action;
    List<int> later = [];
    if(this.usedForCashFlow){
      this.cashActions.sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
      cashFlow.add(CashItem(action: CashAction(tb: null, plannedDate: start, amount: balance, account: this), balance: balance)); //Start of cash flow
      while(day.isBeforeOrEqual(finish)){
        while(i < this.cashActions.length && this.cashActions[i].plannedDate.areDatesEqual(day)){
          action = this.cashActions[i];
          if(action.isPlainAccount()){ // no interest per day or on this day
            cashFlow.add(CashItem(balance: action.amount + cashFlow.last.balance, action: action));
          } else {
            later.add(i);
          }
          i++;
          if (i == this.cashActions.length) break;
        }
        //if InterestPerDay then add the interest
        addAccountInterest(day);
        for(int j in later){
          action = this.cashActions[j];
          //if the cash action is OnThisDay action it
          if(action.amount == AppConstants.noBalance && action is OnThisDay){
            cashFlow.add(CashItem(balance: (action as OnThisDay).transferTempInterestAndReturn()! + cashFlow.last.balance, action: action));
          }         
        }
        later = [];        
        day = day.plusOneDay();
      }
      compress();
      if(addDatas) addData();             
    }
  }
  addAccountInterest(DateTime day){
    bool addInterest = false;
    if(this is InterestPerDay){
      bool ongoing = (this as InterestPerDay).accountEnd == null;      
      if(this is InterestPerDay){
        if(day.isAfterOrEqual((this as InterestPerDay).accountStart!)){
          // we are after the start so now check if ongoing, if so add the interest
          if(ongoing){
            addInterest = true;
          } else {
            // not ongoing so now check if before the end date
            if(day.isBeforeOrEqual((this as InterestPerDay).accountEnd!)){
              addInterest = true;
            } else {
              // so we are after the end date and not ongoing so don't add the daily interest
              addInterest = false;
            }
          }
        }
      }      
    }
    if(addInterest) (this as InterestPerDay).addTempInterestThisDay(day); 
  }
  compress(){
    int i = 0;
    while(i + 1 < cashFlow.length){
      CashItem current = cashFlow[i];
      CashItem next = cashFlow[i + 1];
      if(current.action!.plannedDate.areDatesEqual(next.action!.plannedDate)){
        current.isMulti = true;
        if(current.actions == null) current.actions = [];
        current.actions!.add(next.action!);
        current.balance = next.balance;
        cashFlow.removeAt(i + 1);  
      } else {
        i++;
      }
    }     
  }
  addData(){
   
    String currencySymbol =Currencies.currencyValue(sl<Setting>().currency);
    String output;
    var numb = NumberFormat.currency(symbol: currencySymbol, decimalDigits: 0);
    var smallNumb = NumberFormat.currency(symbol: currencySymbol, decimalDigits: 2);
    var datt = DateFormat('dd/MM/yy');
    for(CashItem item in cashFlow){
      output = '';
      if(item.isMulti){
        output = output + 'Multi : \n';
        output = output + (item.action!.tb == null 
          ? 'Start of Cash Flow : ' + numb.format(this.balance) 
          : item.action!.tb!.title + ' : ' + numb.format(item.action!.amount));
          for(var action_a in item.actions!){          
            output = output + '\n' + (item.action!.tb == null ? 'Start of Cash Flow : ' : action_a.tb!.title)
             + 
            (action_a.amount.abs() <= 10 ? smallNumb.format(action_a.amount) : numb.format(action_a.amount));
          }        
      } else {
        output = (item.action!.tb == null 
          ? 'Start of Cash Flow' : (item.action!.amount.abs() <= 10 ? smallNumb.format(item.action!.amount) : numb.format(item.action!.amount)) + 
          ' : ' + item.action!.tb!.title);
      }
      output = output + '\n\n balance: ' + smallNumb.format(item.balance);
      output += '\n date: ' + datt.format(item.action!.plannedDate);
      item.dialogData = output;
      item.summary = datt.format(item.action!.plannedDate) + ' ' +  numb.format(item.balance);
    }
  }
}