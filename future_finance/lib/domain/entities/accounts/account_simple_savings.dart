import '../accounts/account_add_interest.dart';
import '../accounts/cash_action.dart';
import 'account.dart';
import '../../../presentation/config/constants.dart';
import '../../../presentation/widgets/common_widgets.dart';
import '../../../data/models/facts_base.dart';
import 'account_classes.dart';

class AccountSimpleSavings extends Account with InterestPerDay {

  double _savingsRate = 0.0;
  int _addInterestId = AddInterestNames.no_add_interest;
  double _chargeRate = 0.0;
  int _chargeRecurrenceId = RecurrenceNames.no_recurrence;
  DateTime? _accountStart;
  DateTime? _accountEnd;
  double _interestAccrued = 0.0;
  DateTime? _lastInterestAdded = null;
  double _tempInterestAccrued = 0.0;
  // this now has _addInterest and no longer and rateRecurrenceId
  AccountSimpleSavings({
    required DateTime? lastInterestAdded, 
    required double interestAccrued, 
    required double savingsRate, 
    required int addInterestId,
    required DateTime? accountStart, 
    required DateTime? accountEnd,
    required double chargeRate, 
    required int chargeRecurrenceId, 
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
      this._addInterestId = addInterestId;
      this._chargeRate = chargeRate;
      this._chargeRecurrenceId = chargeRecurrenceId;
      this._accountStart = accountStart;
      this._accountEnd = accountEnd;
      this._tempInterestAccrued = 0.0;
    }
    
  double get interestAccrued => _interestAccrued;
  double get savingsRate => _savingsRate;
  int get addInterestId => _addInterestId; 
  double get chargeRate => _chargeRate;
  int get chargeRecurrenceId => _chargeRecurrenceId;
  DateTime? get accountStart => _accountStart;
  DateTime? get accountEnd => _accountEnd;
  DateTime? get lastInterestAdded => _lastInterestAdded;
  double get tempInterestAccrued => _tempInterestAccrued;

  set interestAccrued(double interestAccrued) => _interestAccrued = interestAccrued;
  set savingsRate(double savingsRate) => _savingsRate = savingsRate;
  set addInterestId(int addInterestId) => _addInterestId = addInterestId;
  set chargeRate(double chargeRate) => _chargeRate = chargeRate;
  set chargeRecurrenceId(int chargeRecurrenceId) => _chargeRecurrenceId = chargeRecurrenceId;
  set accountStart(DateTime? accountStart) => _accountStart = accountStart;
  set accountEnd(DateTime? accountEnd) => _accountEnd = accountEnd;
  set lastInterestAdded(DateTime? lastInterestAdded) => _lastInterestAdded = lastInterestAdded;
  set tempInterestAccrued(double tempInterestAccrud) => _tempInterestAccrued = tempInterestAccrud;

  double interestPerDay(){
    double dailyInterestRate = _savingsRate/100.0/numberOfDaysThisYear();
    return dailyInterestRate * balance;
  }
  @override
  void addInterestThisDay(DateTime day){
    _interestAccrued += interestPerDay();
    lastInterestAdded = day;
  }
  @override
  void addTempInterestThisDay(DateTime day) => _tempInterestAccrued += interestPerDay();
  
  @override
  List<CashAction> getActions(FactsBase factsbase, DateTime startDate, DateTime finishDate){
    AddInterest addInterest = factsbase.addinterests!.firstWhere((acct) => acct.id == _addInterestId); 
    return addInterest.getActions(finishDate: finishDate, toAccount: this);
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
  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is AccountSimpleSavings &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    accountName == other.accountName &&
    chargeRecurrenceId == other.chargeRecurrenceId &&
    description == other.description &&
    balance == other.balance;

  @override
  int get hashCode => id.hashCode ^ accountName.hashCode ^ description.hashCode;      
}