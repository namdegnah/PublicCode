import '../../presentation/widgets/common_widgets.dart';
import '../../core/util/general_util.dart';
import '../entities/accounts/account_balance_at.dart';
import '../../core/usecases/usecase.dart';
import '../../data/models/params.dart';
import '../../data/models/facts_base.dart';
import '../entities/accounts/cash_action.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'facts_run_end_date.dart';
import '../entities/accounts/account_classes.dart';
import '../../core/util/date_time_extension.dart';
import '../../presentation/config/injection_container.dart';
import '../usecases/account_facts_usecase.dart';
import '../../presentation/pages/paint/bar_loader.dart';
import '../../presentation/pages/paint/scaler.dart';
import '../../presentation/bloc/accounts/account_bloc_exports.dart';
import '../usecases/factsbase_facts_usecase.dart';
import '../../presentation/config/constants.dart';
import '../entities/setting.dart';
import '../entities/accounts/account.dart';
import '../repositories/repositories_all.dart';

class FactsUser extends UseCase<FactsBase, Params>{

  final FactsRepository repository;
  FactsUser({required this.repository});
  static int accountChosenId = 0;

  Future<Either<Failure, FactsBase>> call(Params params) async {
    final resulting = await repository.facts();
    return resulting.fold(
      (failure) {
        return Left(failure);
      },
      (factsbase) {
        //This needs a try catch that returns either left of right// put in a getResults type
        DateTime cfend = sl<Setting>().endDate;
        _getActions(factsbase: factsbase, startDate: repository.today!, finishDate: cfend);      
        //for(var account in factsbase.accounts) account.process(start: repository.today);
        for(var account in factsbase.accounts) account.factsRunProcess(start: repository.today!, finish: cfend, addDatas: accountChosenId != SettingNames.barChartTotal);
        
        //total account
        factsbase.total.cashFlow = factsbase.accounts.consolidate(start: repository.today!, finish: cfend);
        factsbase.total.addData();
        factsbase.total.balance = factsbase.total_balance;     
        factsbase.voidCashAction(); 
        factsbase.accountId = accountChosenId;
        return Right(factsbase);
      },
    );    
  }
  Future<Either<Failure, void>> realUpdate() async {

    var _users, _factsbase, _default_user;
    DateTime lastDate = getLastDate();
    DateTime today = GeneralUtil.today();
        
    // _default_user = sl<Setting>().user_id;
    _default_user = getCurrentUserId();
    final resulting = await repository.getUsers();
    resulting.fold(
      (failure) {
        return Left(failure);
      },
      (list) => _users = list,
    );  
    
    for(var _user in _users){
      sl<Setting>().setUp(_user.id);
      final _factsB = await repository.facts(_user.id);
      _factsB.fold(
        (failure) {
          return Left(failure);
          },
        (factsbase) => _factsbase = factsbase,
      );
    if(sl<Setting>().autoProcess == SettingNames.autoProcessedTrue && today.isAfterOrEqual(lastDate)){
      _getActions(factsbase: _factsbase, startDate: lastDate, finishDate: today);
      for(Account account in _factsbase.accounts){          
        if(account.cashActions.length > 0){
          account.realTeam();                                     
        } 
        sl<AccountsBloc>().add(UpdateAccountEvent(account: account)); 
      }         
    }
    sl<Setting>().setUp(_default_user);
    setLastDate(today);          
    }
    return Right(null);
  } 

  Future<Either<Failure, FactsBase>> RunPause(Params params) async {
    try{
      if(getHasBeenDone() == AppConstants.doOnceNotDone) await realUpdate();
      late FactsBase _factsbase;
      final resulting = await repository.facts();
      resulting.fold(
        (failure){        
          return Left(failure);
        },
        (factsbase) => _factsbase = factsbase,
      );      
      if(getHasBeenDone() == AppConstants.doOnceNotDone) _factsbase.processedBefore(repository.today!); // now do this just once
      List<DateTime> endDates = repository.today!.endOfNextMonths(Scaler.noMonths);
      DateTime cfend = endDates.last; //This is the final endDate, say 12 months worth
      _getActions(factsbase: _factsbase, startDate: repository.today!, finishDate: cfend);
      for(var account in _factsbase.accounts){
        account.barCharData(endDates);
      }
      _factsbase.total.balances = List.generate(Scaler.noMonths, (index) => getNew(index));
      int i = 0;
      for(var tbalance in _factsbase.total.balances){
        for(var account in _factsbase.accounts){
          tbalance.balance += account.balances[i].balance;
        }
        _factsbase.total.loaders.add(BarLoader(height: tbalance.balance, value: 0, label: ''));
        i++;
      }
      return Right(_factsbase); 
      } on Exception catch(error){
        return Left(CodeFailure(error.toString()));
    }
  }
  AccountBalanceAt getNew(int index){
    return AccountBalanceAt(monthNo: index);
  }
  void _getActions({required FactsBase factsbase, required DateTime startDate, required DateTime finishDate}){
    if(factsbase.accounts.isNotEmpty){
      List<CashAction> actions = factsbase.transfers.process(facts: factsbase, startDate: startDate, finishDate: finishDate); // process all the transfers in one line using extensions
      actions.addAll(factsbase.transactions.process(facts: factsbase, startDate: startDate, finishDate: finishDate)); // process and add all the transactions in one line using extensions
      //now change this
      for(var account in factsbase.accounts) if(account is InterestPerDay) actions.addAll((account as InterestPerDay).getActions(factsbase, startDate, finishDate));
      // for(var account in factsbase.accounts) if(account is InterestPerDay) actions.addAll((account as InterestPerDay).addTransactions(factsbase).process(facts: factsbase, startDate: startDate, finishDate: finishDate)); // so here we add the transactions and use the recurrence to add all necessary cash actions for the cash run end date
      for(var action in actions) action.account.cashActions.add(action); // copy all the CashActions to the Account.      
    }
  }
}