import '../entities/accounts/cash_item.dart';
import '../entities/accounts/cash_action.dart';

class DataRow{
  late double _balance;
  DateTime? _day;
  List<double> data = [];
  List<CashItem> _items = [];
  List<CashAction> _actions = [];
  DataRow();

  bool isEmpty(){
    var bal = data.fold(0.0, (previousValue, element) => previousValue + element);
    if (bal == 0.0) return true;
    return false;
  }
  set balance(double balance) => _balance = balance;
  set time(DateTime? day) => _day = day;
  set actions(List<CashAction> actions) => _actions = actions;
  double get balance {    
    _balance = data.fold(0.0, (previousValue, element) => previousValue + element);
    return _balance;
  }
   
  List<CashItem> get items => _items;
  double get thisBalance => _balance;
  DateTime? get time => _day;
  List<CashAction> get actions => _actions;
}
extension consolidations on List<DataRow> {

  List<CashItem> cashItems(){
    CashItem item;
    List<CashAction> rowActions;
    List<CashItem> cashFlow = [];
    copyDown();
    createBalance();
    for(var row in this){ 
      rowActions = [];   
      for(var it in row.items){        
        rowActions.addAll(it.allActions());
      }
      item = CashItem(balance: row.thisBalance);
      item.action = rowActions[0];
      if(rowActions.length > 1) {
        item.isMulti = true;
        item.actions = [];
        for(var i = 1; i < rowActions.length; i++){
          item.actions!.add(rowActions[i]);
        }
      }
      cashFlow.add(item);
    }
    return cashFlow;
  }  
  void copyDown(){
    DataRow row;
    DataRow prev;
    for(var i = 1; i < this.length; i++){
      prev = this[i - 1];
      row = this[i];      
      for(var j = 0; j < row.data.length; j++){
        if(row.data[j] == 0.0) row.data[j] = prev.data[j];
      }
    }
  }
  void createBalance(){
    for(var row in this){
      row.balance;
    }
  }
}