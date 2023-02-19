import 'package:dartz/dartz.dart';
import '../../presentation/config/injection_container.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/error_export.dart';
import '../../domain/entities/transfer.dart';
import '../../data/models/dialog_base.dart';
import '../../domain/repositories/repositories_all.dart';
import '../datasources/data_sources.dart';
import '../../presentation/config/constants.dart';
import '../../data/repositories/dialog_repository_imp.dart';
import '../../data/repositories/category_repository_imp.dart';
import '../../data/repositories/recurrence_repository_imp.dart';
import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/recurrence.dart';
import '../../core/util/general_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Future<List<Transfer>> _TransferOrFailure();

class TransferRepositoryImp extends TransferRepository {
  final AppDataSource dataSource;
  TransferRepositoryImp({required this.dataSource});  

  Future<Either<Failure, ServerSuccess>> updateProcess(int id) async {
    try{
      await dataSource.update(TransfersNames.tableName, id, getMap(TransfersNames.processed, SettingNames.autoProcessedTrue));
      return Right(ServerSuccess('Updated Transfer processed flag'));
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }   
  }
  Future<Either<Failure, List<Transfer>>> insertTransfer(Transfer transfer) async {
    return await _getResults(() async{
      await dataSource.insert(TransfersNames.tableName, _toTransfer(transfer));    
      return await _transferList();
    });
  }
  Future<Either<Failure, DialogBase>> dialogList(List<String> tableNames) async {
    try{
      DialogRepositoryImp dri = sl<DialogRepository>() as DialogRepositoryImp;
      CategoryRepositoryImp cri = sl<CategoryRepository>() as CategoryRepositoryImp;
      RecurrenceRepositoryImp rri = sl<RecurrenceRepository>() as RecurrenceRepositoryImp;
      late List<Account> accounts;
      late List<Category> categories;
      late List<Recurrence> recurrences;
      //Get the accounts for this user - does this violate 'the only place to get accounts? Seems to miss other account types to me
      var _accounts = await dri.getAccounts();
      _accounts.fold(
        (failure) => throw failure,
        (list) => accounts = list,
      );
      // int user_id = sl<SharedPreferences>().getInt(AppConstants.userId)!;
      // String whereClause = UserAccountNames.tableName + "." + UserAccountNames.user_id + " = " + user_id.toString();
      // final _accounts = await dataSource.getDataLinkWhere(tableName: AccountNames.tableName, linkTable: UserAccountNames.tableName, tableField: AccountNames.id, linkField: UserAccountNames.account_id, whereClause: whereClause);
      // accounts = dri.toAccounts(_accounts);
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
  Future<Either<Failure, List<Transfer>>> transferList() async {
    return await _getResults(() async {
      return await _transferList();
    });
  }
  Future<Either<Failure, Transfer>> transfer(int id) async {
    try{
      final _dataList = await dataSource.getAllDataWhere(TransfersNames.tableName, id);
      final List<Transfer> _items = _dbToList(_dataList);
      return Right(_items[0]);        
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, List<Transfer>>> deleteTransfer(int id) async {
    try{
      await dataSource.delete(TransfersNames.tableName, id);
      return Right(await _transferList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, List<Transfer>>> updateTransfer(Transfer transfer) async {
    try{
      await dataSource.update(TransfersNames.tableName, transfer.id, _toTransfer(transfer));
      return Right(await _transferList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<List<Transfer>> _transferList() async {
    int user_id = sl<SharedPreferences>().getInt(AppConstants.userId)!;
    final _dataList = await dataSource.getAllDataFullIntQuery(TransfersNames.tableName , [TransfersNames.processed, TransfersNames.user_id], [SettingNames.autoProcessedFalse, user_id]);    
    return _dbToList(_dataList);
  }
  List<Transfer> _dbToList(List<Map<String, dynamic>> data){
    final List<Transfer> _items = data.map(
      (item) => Transfer(
        id: item[TransfersNames.id],
        user_id: item[TransfersNames.user_id],
        title: item[TransfersNames.title],
        description: item[TransfersNames.description],
        plannedDate: item[TransfersNames.plannedDate] == null ? null : DateTime.parse(item[TransfersNames.plannedDate]),
        amount: item[TransfersNames.amount],
        toAccountId: item[TransfersNames.toAccountId],
        fromAccountId: item[TransfersNames.fromAccountId],
        categoryId: item[TransfersNames.categoryId],
        recurrenceId: item[TransfersNames.recurrenceId],        
        usedForCashFlow: item[TransfersNames.usedForCashFlow] == 1 ? true : false,  
        processed: item[TransfersNames.processed],    
      ),
    ).toList(); 
    return _items;    
  }
  Future<Either<Failure, List<Transfer>>> _getResults(_TransferOrFailure transferOrFailure) async {
    try{
      final transferList = await transferOrFailure();
      return Right(transferList);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  Map<String, dynamic> _toTransfer(Transfer transfer){
    int user_id = sl<SharedPreferences>().getInt(AppConstants.userId)!;
    return {
      TransfersNames.title: transfer.title,
      TransfersNames.description: transfer.description,
      TransfersNames.user_id: user_id,
      TransfersNames.plannedDate: transfer.plannedDate == null ? null : transfer.plannedDate!.toIso8601String(),
      TransfersNames.amount: transfer.amount,
      TransfersNames.toAccountId: transfer.toAccountId,
      TransfersNames.fromAccountId: transfer.fromAccountId,
      TransfersNames.categoryId: transfer.categoryId,
      TransfersNames.recurrenceId: transfer.recurrenceId,
      TransfersNames.usedForCashFlow: transfer.usedForCashFlow == true ? 1 : 0,
      TransfersNames.processed: transfer.processed,
    };
  }
}