import 'package:dartz/dartz.dart';
import '../../presentation/config/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/errors/error_export.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/recurrence.dart';
import '../../data/models/dialog_base.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../data/repositories/account_repository_imp.dart';
import '../../data/repositories/category_repository_imp.dart';
import '../../data/repositories/recurrence_repository_imp.dart';
import '../datasources/data_sources.dart';
import '../../presentation/config/constants.dart';
import '../../core/util/general_util.dart';

typedef Future<List<Transaction>> _TransactionOrFailure();

class TransactionRepositoryImp extends TransactionRepository {
  final AppDataSource dataSource;
  TransactionRepositoryImp({required this.dataSource});  

  Future<Either<Failure, ServerSuccess>> updateProcess(int id) async {
    try{
      await dataSource.update(TransactionNames.tableName, id, getMap(TransactionNames.processed, SettingNames.autoProcessedTrue));
    return Right(ServerSuccess('Updated Transaction Processed Flag'));
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }   
  }

  Future<Either<Failure, List<Transaction>>> insertTransaction(Transaction transaction) async {
    return await _getResults(() async{
      await dataSource.insert(TransactionNames.tableName, _toTransaction(transaction));  
      return await _transactionList();
    });
  }
  Future<Either<Failure, DialogBase>> dialogList(List<String> tableNames) async {
    try{
      AccountRepositoryImp ari = sl<AccountRepository>() as AccountRepositoryImp;
      CategoryRepositoryImp cri = sl<CategoryRepository>() as CategoryRepositoryImp;
      RecurrenceRepositoryImp rri = sl<RecurrenceRepository>() as RecurrenceRepositoryImp;
      List<Account> accounts;
      List<Category>? categories;
      List<Recurrence>? recurrences;
      //Get the accounts for this user

      int user_id = sl<SharedPreferences>().getInt(AppConstants.userId)!;
      String whereClause = UserAccountNames.tableName + "." + UserAccountNames.user_id + " = " + user_id.toString();
      final _accounts = await dataSource.getDataLinkWhere(tableName: AccountNames.tableName, linkTable: UserAccountNames.tableName, tableField: AccountNames.id, linkField: UserAccountNames.account_id, whereClause: whereClause);
      accounts = ari.fromDBtoAccountList(_accounts);
      //Now get the categories and recurrences
      final _dataList = await dataSource.getMulitipleData(tableNames);      
      int i = -1;
      for(List<Map<String, dynamic>> data in _dataList){
        i++;
        switch(tableNames[i]){
          case CategoryNames.tableName:
          categories = cri.toCategories(data);
          break;
          case RecurrenceNames.tableName:
          recurrences = rri.toRecurrence(data);
          break;          
        }
      }
      return Right(DialogBase(accounts: accounts, categories: categories, recurrences: recurrences));

    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, List<Transaction>>> transactionList() async {
    return await _getResults(() async {
      return await _transactionList();
    });
  }
  Future<Either<Failure, Transaction>> transaction(int id) async {
    try{
      final _dataList = await dataSource.getAllDataWhere(TransactionNames.tableName, id);
      final List<Transaction> _items = _dbToList(_dataList);
      return Right(_items[0]);        
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, List<Transaction>>> deleteTransaction(int id) async {
    try{
      await dataSource.delete(TransactionNames.tableName, id);
      return Right(await _transactionList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, List<Transaction>>> updateTransaction(Transaction transaction) async {
    try{
      await dataSource.update(TransactionNames.tableName, transaction.id, _toTransaction(transaction));
      return Right(await _transactionList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<List<Transaction>> _transactionList() async {
    
    int user_id = sl<SharedPreferences>().getInt(AppConstants.userId)!;
    DialogRepository dr = sl<DialogRepository>();
    AccountRepository ar = sl<AccountRepository>();
    List<Account>? _accounts;
    Account? _account;
    bool _reply = false;
    var _accountsB = await dr.getAccounts();
    var _resultB;
    _accountsB.fold(
      (failure) => throw(failure),
      (list) => _accounts = list,
    );    
    List<Transaction> answer = [];
    final _dataList = await dataSource.getAllDataFullIntQuery(TransactionNames.tableName , [TransactionNames.processed], [SettingNames.autoProcessedFalse]);
    final _transactions = _dbToList(_dataList);
    for(var trans in _transactions){
      if(trans.user_id == user_id) {
        answer.add(trans);
      } else {
        _account = _accounts!.firstWhere((acc) => acc.id == trans.accountId, orElse: () => Account.noAccount());
        _resultB = await ar.doesUserShareAccout(_account, trans.accountId, user_id);
        _resultB.fold(
          (failure) => throw(failure),
          (ans) => _reply = ans,
        );
        if(_reply) answer.add(trans);
      }
    } 
    return answer;
  }
          
  
  List<Transaction> _dbToList(List<Map<String, dynamic>> data){
    final List<Transaction> _items = data.map(
      (item) => Transaction(
        id: item[TransactionNames.id],
        user_id: item[TransactionNames.user_id],
        title: item[TransactionNames.title],
        description: item[TransactionNames.description],
        plannedDate: item[TransactionNames.plannedDate] == null ? null : DateTime.parse(item[TransactionNames.plannedDate]),
        amount: item[TransactionNames.amount],
        accountId: item[TransactionNames.accountId],
        categoryId: item[TransactionNames.categoryId],
        recurrenceId: item[TransactionNames.recurrenceId],
        credit: item[TransactionNames.credit] == 1 ? true : false, 
        usedForCashFlow: item[TransactionNames.usedForCashFlow] == 1 ? true : false,  
        processed: item[TransactionNames.processed],    
      ),
    ).toList(); 
    return _items;    
  }
  Future<Either<Failure, List<Transaction>>> _getResults(_TransactionOrFailure transactionOrFailure) async {
    try{
      final transactionList = await transactionOrFailure();
      return Right(transactionList);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  Map<String, dynamic> _toTransaction(Transaction transaction){

    int user_id = sl<SharedPreferences>().getInt(AppConstants.userId)!;
    return {
      TransactionNames.title: transaction.title,
      TransactionNames.description: transaction.description,
      TransactionNames.user_id: user_id,
      TransactionNames.plannedDate: transaction.plannedDate == null ? null : transaction.plannedDate!.toIso8601String(),
      TransactionNames.amount: transaction.amount,
      TransactionNames.accountId: transaction.accountId,
      TransactionNames.categoryId: transaction.categoryId,
      TransactionNames.recurrenceId: transaction.recurrenceId,
      TransactionNames.credit: transaction.credit,
      TransactionNames.usedForCashFlow: transaction.usedForCashFlow == true ? 1 : 0,
      TransactionNames.processed: transaction.processed,
    };
  }
  
}