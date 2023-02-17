import '../../../core/util/date_time_extension.dart';
import 'account.dart';
import '../../../presentation/config/constants.dart';
import '../transaction.dart';
import '../recurrence.dart';
import '../../../presentation/widgets/common_widgets.dart';
import '../../../data/models/facts_base.dart';
import 'account_classes.dart';
import '../accounts/cash_action.dart';

class AccountSavings extends Account with InterestPerDay {

  double _savingsRate = 0.0;
  int _rateRecurrenceId = RecurrenceNames.no_recurrence;
  double _chargeRate = 0.0;
  int _chargeRecurrenceId = RecurrenceNames.no_recurrence;
  DateTime? _accountStart;
  DateTime? _accountEnd;  
  double _interestAccrued = 0.0;
  double _capitalCeiling = 0.0;
  int _savingsAccountId = AccountNames.no_account;
  int _chargeAccountId = AccountNames.no_account;
  DateTime? _lastInterestAdded = null;
  double _tempInterestAccrued = 0.0;
  int? _accountInterestPaidIntoId;

  AccountSavings({
    required DateTime? lastInterestAdded, 
    required double capitalCeiling, 
    required double interestAccrued, 
    required double savingsRate, 
    required int rateRecurrenceId, 
    required DateTime? accountStart, 
    required DateTime? accountEnd,    
    required double chargeRate, 
    required int chargeRecurrenceId, 
    required int savingsAccountId, 
    required int chargeAccountId, 
    required int id, 
    required String accountName, 
    required String description, 
    required double balance, 
    required bool  usedForCashFlow,
    int? accountInterestPaidIntoId,    
  }) : 
    super(id: id, accountName: accountName, description: description, balance: balance, usedForCashFlow: usedForCashFlow){
      this._lastInterestAdded = lastInterestAdded;
      this._interestAccrued = interestAccrued;
      this._savingsRate = savingsRate;
      this._rateRecurrenceId = rateRecurrenceId;
      this._chargeRate = chargeRate;
      this._chargeRecurrenceId = chargeRecurrenceId;
      this._accountStart = accountStart;
      this._accountEnd = accountEnd;      
      this. _capitalCeiling = capitalCeiling;
      this._savingsAccountId = savingsAccountId;
      this._chargeAccountId = chargeAccountId;
      this._tempInterestAccrued = 0.0;
      this._accountInterestPaidIntoId = accountInterestPaidIntoId;
    }
    
  double get interestAccrued => _interestAccrued;
  double get savingsRate => _savingsRate;
  int get rateRecurrenceId => _rateRecurrenceId;
  double get chargeRate => _chargeRate;
  int get chargeRecurrenceId => _chargeRecurrenceId;
  DateTime? get accountStart => _accountStart;
  DateTime? get accountEnd => _accountEnd;  
  double get capitalCeiling => _capitalCeiling;
  int get savingsAccountId => _savingsAccountId;
  int get chargeAccountId => _chargeAccountId;
  DateTime? get lastInterestAdded => _lastInterestAdded;
  double get tempInterestAccrued => _tempInterestAccrued;
  int? get accountInterestPaidIntoId => _accountInterestPaidIntoId;

  set interestAccrued(double interestAccrued) => _interestAccrued = interestAccrued;
  set savingsRate(double savingsRate) => _savingsRate = savingsRate;
  set rateRecurrenceId(int rateRecurrenceId) => _rateRecurrenceId = rateRecurrenceId;
  set chargeRate(double chargeRate) => _chargeRate = chargeRate;
  set chargeRecurrenceId(int chargeRecurrenceId) => _chargeRecurrenceId = chargeRecurrenceId;
  set accountStart(DateTime? accountStart) => _accountStart = accountStart;
  set accountEnd(DateTime? accountEnd) => _accountEnd = accountEnd;  
  set capitalCeiling(double capitalCeiling) => _capitalCeiling = capitalCeiling;
  set savingsAccountId(int savingsAccountId) => _savingsAccountId = savingsAccountId;
  set chargeAccountId(int chargeAccountId) => _chargeAccountId = chargeAccountId;
  set lastInterestAdded(DateTime? lastInterestAdded) => _lastInterestAdded = lastInterestAdded;
  set tempInterestAccrued(double tempInterestAccrud) => _tempInterestAccrued = tempInterestAccrud;
  set accountInterestPaidIntoId(int? accountId) => _accountInterestPaidIntoId = accountId;

  double interestPerDay(){
    double dailyInterestRate = _savingsRate/100.0/numberOfDaysThisYear();
    return dailyInterestRate * (balance > _capitalCeiling && _capitalCeiling > 0.0 ? _capitalCeiling : balance);
  }
  void addInterestThisDay(DateTime day){
    _interestAccrued += interestPerDay();
    lastInterestAdded = day;
  }
  void addTempInterestThisDay(DateTime day) => _tempInterestAccrued += interestPerDay();

  List<CashAction> getActions(FactsBase factsbase, DateTime startDate, DateTime finishDate){
    List<CashAction> actions = [];


    return actions;
  }  
  List<Transaction> addTransactions(FactsBase factsBase)  {

    Recurrence charge = factsBase.recurrences.firstWhere((recurrence) => recurrence.id == _chargeRecurrenceId);
    Recurrence rate = factsBase.recurrences.firstWhere((recurrence) => recurrence.id == _rateRecurrenceId);

    //Create the transactions for 
    List<Transaction> _transactions = [];
    // the charges
    int user_id = getCurrentUserId();
    Transaction _charges = Transaction(
      accountId: this.id, 
      user_id: user_id, 
      title: 'Account Charges', 
      description: 'charges', 
      plannedDate: _accountStart!.plusDuration(charge.type), 
      amount: _chargeRate, 
      processed: SettingNames.autoProcessedFalse, 
      usedForCashFlow: true,
      categoryId: CategoryNames.bank_charges_category_id,
      credit: false,
      id: AccountSavingsNames.generatedTransaction,
      recurrenceId: _chargeRecurrenceId,
    );
    _transactions.add(_charges);
    Transaction _interestPayment = Transaction(
      accountId: this.id, 
      user_id: user_id, 
      title: 'Interest Accrued', 
      description: 'interest', 
      plannedDate: _accountStart!.plusDuration(rate.type), 
      amount: AppConstants.noBalance, 
      processed: SettingNames.processed_interest_temp, 
      usedForCashFlow: true,
      categoryId: CategoryNames.bank_interest_category_id,
      credit: true,
      id: AccountSavingsNames.generatedTransaction,
      recurrenceId: _rateRecurrenceId,
    );
    _interestAccrued = 0.0;
    _transactions.add(_interestPayment);

    return _transactions;
  }
  double getInterestAndTransfer(){
    double _ans = interestAccrued;
    interestAccrued = 0.0;
    return _ans;
  } 
  double getTempInterestAndTransfer(){
    double _ans = tempInterestAccrued;
    tempInterestAccrued = 0.0;
    return _ans;
  }   
}

