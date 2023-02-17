import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/accounts/account_savings.dart';
import '../../domain/entities/accounts/account_simple_savings.dart';
import '../models/dialog_base.dart';
import 'package:dartz/dartz.dart';
import '../datasources/data_sources.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/util/general_util.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../presentation/config/constants.dart';
import '../../presentation/config/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/widgets/common_widgets.dart';
import '../../core/util/date_time_extension.dart';

typedef _AccountOrFailure = Future<List<Account>> Function();
typedef Future<DialogBase> _DialogOrFailure();

class AccountRepositoryImp extends AccountRepository {
  final AppDataSource dataSource;
  AccountRepositoryImp({required this.dataSource});

  @override
  Future<Either<Failure, Account>> getAccountSimpleSavingsByID(int id) async {
    try{
      late var _dataList;
      late final List<Account> _items;
      _dataList = await dataSource.getAllDataWhere(AccountSimpleSavingsNames.tableName, id);
      _items = fromDBtoListAccountSimpleSavings(_dataList);
      return Right(_items[0]);        
      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  @override
  Future<Either<Failure, Account>> account(Account account) async {
    try{
      late var _dataList;
      late final List<Account> _items;
      if(account is AccountSimpleSavings){
        _dataList = await dataSource.getAllDataWhere(AccountSimpleSavingsNames.tableName, account.id);
        _items = fromDBtoListAccountSimpleSavings(_dataList);
      } else if (account is AccountSavings){
        _dataList = await dataSource.getAllDataWhere(AccountSavingsNames.tableName, account.id);
        _items = fromDBtoListAccountSavings(_dataList);
      } else {
        _dataList = await dataSource.getAllDataWhere(AccountNames.tableName, account.id);
        _items = fromDBtoAccountList(_dataList);
      }
      return Right(_items[0]);        
      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Account>>> accountList(int user_id) async {
    return await _getResults(() async {
      return await _accountList(user_id);
    });
  } 
  @override
  Future<Either<Failure, DialogBase>> accountsAndDetails() async {

    return await _getDialogResults(() async {
      return await _dialogBase();
    });
  }

  @override
  Future<Either<Failure, DialogBase>> deleteAccount(Account account) async {

    try{
      if(account is AccountSimpleSavings){
        await dataSource.delete(AccountSimpleSavingsNames.tableName, account.id);
      } else if(account is AccountSavings){
        await dataSource.delete(AccountSavingsNames.tableName, account.id);
      } else if (account is Account){
        await dataSource.delete(AccountNames.tableName, account.id);        
      }
      await dataSource.deleteWhere(TransactionNames.tableName, TransactionNames.accountId, account.id);
      await dataSource.deleteWhere(TransfersNames.tableName, TransfersNames.fromAccountId, account.id);
      await dataSource.deleteWhere(TransfersNames.tableName, TransfersNames.toAccountId, account.id);              
      return Right(await _dialogBase());          
          
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> doesUserShareAccout(Account account, int account_id, int user_id) async {
    try{ 
      if(!account.isNoAccount()) {
        var resultSet;
        if(account is AccountSavings){
          resultSet = await dataSource.getAllDataFullIntQuery(UserSavingsNames.tableName, [UserSavingsNames.user_id, UserSavingsNames.account_id], [user_id, account.id]);
        } else if(account is Account){
          resultSet = await dataSource.getAllDataFullIntQuery(UserAccountNames.tableName, [UserAccountNames.user_id, UserAccountNames.account_id], [user_id, account.id]);
        } 
        if(resultSet == null) return Right(false);     
        return (Right(resultSet.length > 0));        
      } else {
        return Right(false);
      }
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, DialogBase>> insertAccount(Account account) async {
    return await _getDialogResults(() async{
      int account_id = await dataSource.insert(AccountNames.tableName, _toAccount(account, getNextAccountNumber()));
      await dataSource.insert(UserAccountNames.tableName, _toUserAccount(account_id));    
      return await _dialogBase(id: account_id);
    }); 
  }

  @override
  Future<Either<Failure, DialogBase>> shareAccount(Account account, int id) {
    // TODO: implement shareAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DialogBase>> updateAccount(Account account) async {

    try{
      if(account is AccountSavings){
        await dataSource.update(AccountSavingsNames.tableName, GeneralUtil.decodeIdAndType(account.id).id, _toDBfromListAccountSavings(account)); // must decode the account_id for updates 
      } else if (account is AccountSimpleSavings){
        await dataSource.update(AccountSimpleSavingsNames.tableName, account.id, _toDBfromListAccountSimpleSavings(account)); // must decode the account_id for updates 
      } else if (account is Account){
        await dataSource.update(AccountNames.tableName, account.id, _toAccount(account, account.id)); // must decode the account_id for updates 
      } 
      
     
      return Right(await _dialogBase());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
        return Left(ServerFailure(error.toString()));
    }
  }
  @override
  Future<Either<Failure, DialogBase>> insertAccountSavings(AccountSavings account) async {
    return await _getDialogResults(() async {
      account.id = getNextAccountNumber();
      int account_id = await dataSource.insert(AccountSavingsNames.tableName, _toDBfromListAccountSavings(account));
      await dataSource.insert(UserSavingsNames.tableName, _toUserAccountSaving(account_id)); 
      return await _dialogBase();
    });
  }  
  @override
  Future<Either<Failure, DialogBase>> insertAccountSimpleSavings(AccountSimpleSavings account) async {

    return await _getDialogResults(() async {
      account.id = getNextAccountNumber();
      int account_id = await dataSource.insert(AccountSimpleSavingsNames.tableName, _toDBfromListAccountSimpleSavings(account));
      await dataSource.insert(UserSimpleSavingsNames.tableName, _toUserAccountSimpleSaving(account_id)); 
      return await _dialogBase(id: account_id);
    });
  }     
  Future<List<Account>> _accountList(int userId) async {
    DialogRepository dr = sl<DialogRepository>();
    late List<Account> _list;
    var _accounts = await dr.getAccounts();
    _accounts.fold(
      (failure) => throw Left(failure),
      (list) => _list = list,
    );
    return _list;
  }
  @override
  List<Account> fromDBtoAccountList(List<Map<String, dynamic>> data){

    final List<Account> _items = data.map(
      (item) => Account(
        id: item[AccountNames.id],
        accountName: item[AccountNames.accountName],
        description: item[AccountNames.description],
        balance: item[AccountNames.balance],
        usedForCashFlow: item[AccountNames.usedForCashFlow] == 1 ? true : false,        
      ),
    ).toList(); 
    return _items;    
  }       
  Future<Either<Failure, List<Account>>> _getResults(_AccountOrFailure accountOrFailure) async {
    try{
      final accountList = await accountOrFailure();
      return Right(accountList);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<DialogBase> _dialogBase({int? id}) async {
    DialogRepository dialogRepository = sl<DialogRepository>(); 
    DialogBase db = DialogBase();
    db.id = id;
    var _accounts, _accountTypes, _recurrences, _users, _interests;
    final _accountsB = await dialogRepository.getAccounts();
    _accountsB.fold(
      (failure) => throw(failure),
      (list) => _accounts = list,
    );
    db.accounts = _accounts;
    final _accountTypeB = await dialogRepository.getAccountTypes();
    _accountTypeB.fold(
      (failure) => throw(failure),
      (list) => _accountTypes = list,
    );
    db.accountTypes = _accountTypes;
    final _accountTypeC = await dialogRepository.getRecurrences();
    _accountTypeC.fold(
      (failure) => throw(failure),
      (list) => _recurrences = list,
    );
    db.recurrences = _recurrences;
    final _usersB = await dialogRepository.getUsers();
    _usersB.fold(
      (failure) => throw(failure),
      (list) => _users = list,
    );
    db.users = _users;
    final _interestB = await dialogRepository.getAddInterest();
    _interestB.fold(
      (failure) => throw(failure),
      (list) => _interests = list,
    );
    db.addInterests = _interests;    
    return db;
  }
  Future<Either<Failure, DialogBase>> _getDialogResults(_DialogOrFailure dialogOrFailure) async {
    try{
      final dialogBase = await dialogOrFailure();
      return Right(dialogBase);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  Map<String, Object> _toAccount(Account account, int id){
    return {
      AccountNames.id: id,
      AccountNames.accountName: account.accountName,
      AccountNames.description: account.description,
      AccountNames.balance: account.balance,
      AccountNames.usedForCashFlow: account.usedForCashFlow,
    };
  }
  Map<String, Object> _toUserAccount(int account_id){

    return {
      UserAccountNames.user_id: sl<SharedPreferences>().getInt(AppConstants.userId)!,
      UserAccountNames.account_id: account_id,
    };
  }
  Map<String, Object> _toDBfromListAccountSavings(AccountSavings account){

    return {
      AccountNames.id: account.id,
      AccountNames.accountName: account.accountName,
      AccountNames.description: account.description,
      AccountNames.balance: account.balance,
      AccountNames.usedForCashFlow: account.usedForCashFlow,
      AccountSavingsNames.savingsRate: account.savingsRate,
      AccountSavingsNames.save_recurrenceId: account.rateRecurrenceId,
      AccountSavingsNames.chargeRate: account.chargeRate,
      AccountSavingsNames.charge_recurrenceId: account.chargeRecurrenceId,
      AccountSavingsNames.accountStart: GeneralUtil.intFromTime(account.accountStart!),
      AccountSavingsNames.accountEnd: GeneralUtil.intForEndDate(account.accountEnd),
      AccountSavingsNames.lastInterestAdded: account.lastInterestAdded == null ? GeneralUtil.intFromTime(account.accountStart!.lessOneDay()) : GeneralUtil.intFromTime(account.lastInterestAdded!),
      AccountSavingsNames.interestAccrued: account.interestAccrued,
      AccountSavingsNames.capitalCeiling: account.capitalCeiling,
      AccountSavingsNames.savingsAccountId: account.savingsAccountId,
      AccountSavingsNames.chargeAccountId: account.chargeAccountId,
    };
  }
  List<AccountSavings> fromDBtoListAccountSavings(List<Map<String, dynamic>> data){
    final List<AccountSavings> _items = data.map(
      (item) => AccountSavings(
        id: item[AccountNames.id],
        accountName: item[AccountNames.accountName],
        description: item[AccountNames.description],
        balance: item[AccountNames.balance],
        usedForCashFlow: item[AccountNames.usedForCashFlow] == 1 ? true : false,
        savingsRate: item[AccountSavingsNames.savingsRate],
        rateRecurrenceId: item[AccountSavingsNames.save_recurrenceId],      
        chargeRate: item[AccountSavingsNames.chargeRate],
        chargeRecurrenceId: item[AccountSavingsNames.charge_recurrenceId],
        accountStart: GeneralUtil.timeFromInt(item[AccountSavingsNames.accountStart]),
        accountEnd: GeneralUtil.timeFromEndDate(item[AccountSavingsNames.accountEnd]),
        lastInterestAdded: GeneralUtil.timeFromInt(item[AccountSavingsNames.lastInterestAdded]),
        interestAccrued: item[AccountSavingsNames.interestAccrued],
        capitalCeiling: item[AccountSavingsNames.capitalCeiling],
        savingsAccountId: item[AccountSavingsNames.savingsAccountId],
        chargeAccountId: item[AccountSavingsNames.chargeAccountId],
      ),
    ).toList(); 
    return _items;
  }  
  Map<String, Object> _toDBfromListAccountSimpleSavings(AccountSimpleSavings account){

    return {
      AccountNames.id: account.id,
      AccountNames.accountName: account.accountName,
      AccountNames.description: account.description,
      AccountNames.balance: account.balance,
      AccountNames.usedForCashFlow: account.usedForCashFlow,
      AccountSimpleSavingsNames.savingsRate: account.savingsRate,
      AccountSimpleSavingsNames.addInterestId: account.addInterestId,
      AccountSimpleSavingsNames.chargeRate: account.chargeRate,
      AccountSimpleSavingsNames.charge_recurrenceId: account.chargeRecurrenceId,
      AccountSimpleSavingsNames.accountStart: GeneralUtil.intFromTime(account.accountStart!),
      AccountSimpleSavingsNames.accountEnd: GeneralUtil.intForEndDate(account.accountEnd),      
      AccountSimpleSavingsNames.lastInterestAdded: account.lastInterestAdded == null ? GeneralUtil.intFromTime(account.accountStart!.lessOneDay()) : GeneralUtil.intFromTime(account.lastInterestAdded!),
      AccountSimpleSavingsNames.interestAccrued: account.interestAccrued,
    };
  }
  List<AccountSimpleSavings> fromDBtoListAccountSimpleSavings(List<Map<String, dynamic>> data){
    final List<AccountSimpleSavings> _items = data.map(
      (item) => AccountSimpleSavings(
        id: item[AccountNames.id],
        accountName: item[AccountNames.accountName],
        description: item[AccountNames.description],
        balance: item[AccountNames.balance],
        usedForCashFlow: item[AccountNames.usedForCashFlow] == 1 ? true : false,
        savingsRate: item[AccountSavingsNames.savingsRate],
        addInterestId: item[AccountSimpleSavingsNames.addInterestId],      
        chargeRate: item[AccountSavingsNames.chargeRate],
        chargeRecurrenceId: item[AccountSavingsNames.charge_recurrenceId],
        accountStart: GeneralUtil.timeFromInt(item[AccountSimpleSavingsNames.accountStart]),
        accountEnd: GeneralUtil.timeFromEndDate(item[AccountSimpleSavingsNames.accountEnd]),
        lastInterestAdded: GeneralUtil.timeFromInt(item[AccountSimpleSavingsNames.lastInterestAdded]),
        interestAccrued: item[AccountSavingsNames.interestAccrued],
      ),
    ).toList(); 
    return _items;
  }  
  Map<String, Object> _toUserAccountSaving(int account_id){    
    return {
      UserSavingsNames.user_id: getCurrentUserId(),
      UserSavingsNames.account_id: account_id,
    };    
  } 
  Map<String, Object> _toUserAccountSimpleSaving(int account_id){    
    return {
      UserSimpleSavingsNames.user_id: getCurrentUserId(),
      UserSimpleSavingsNames.account_id: account_id,
    };    
  }                 
}
// }