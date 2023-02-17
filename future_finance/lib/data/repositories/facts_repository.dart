import '../../presentation/widgets/common_widgets.dart';
import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../presentation/config/constants.dart';
import '../../domain/entities/recurrence.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transfer.dart';
import '../datasources/data_sources.dart';
import '../models/facts_base.dart';
import '../../presentation/config/injection_container.dart';

class FactsRepositoryImp extends FactsRepository {
  final AppDataSource dataSource;
  final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  FactsRepositoryImp({required this.dataSource });

  Future<Either<Failure, List<User>>> getUsers() async {
    try{
      var _users;
      DialogRepository dialogRepository = sl<DialogRepository>(); 
      final _usersB = await dialogRepository.getUsers();
      _usersB.fold(
        (failure) => throw(failure),
        (list) => _users = list,
      );
      return Right(_users);
     } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
    
  @override 
  Future<Either<Failure, FactsBase>> facts([int? user_id]) async {
    try{

      DialogRepository dialogRepository = sl<DialogRepository>(); 

      int id = user_id == null ? getCurrentUserId() : user_id;
      //Accounts
      var _accounts, _recurrences, _categories, _users, _addInterests;
      final _accountB = await dialogRepository.getAccounts();
      _accountB.fold(
        (failure) => throw(failure),
        (list) => _accounts = list,
      );//Recurrences
      final _recurrenceB = await dialogRepository.getRecurrences();
      _recurrenceB.fold(
        (failure) => throw(failure),
        (list) => _recurrences = list,
      );
      //Categories
      final _categoryB = await dialogRepository.getCategories();
      _categoryB.fold(
        (failure) => throw(failure),
        (list) => _categories = list,
      );
      //Users
      final _usersB = await dialogRepository.getUsers();
      _usersB.fold(
        (failure) => throw(failure),
        (list) => _users = list,
      ); 
      //Users
      final _addInterestB = await dialogRepository.getAddInterest();
      _addInterestB.fold(
        (failure) => throw(failure),
        (list) => _addInterests = list,
      );            
      //Transactions
      final _dataTn = await dataSource.getAllDataFullIntQuery(TransactionNames.tableName, [TransactionNames.user_id, TransactionNames.usedForCashFlow, TransactionNames.processed], [id, AppConstants.usedInCashFlowYes, AppConstants.processedNo]);
      final _transactions = await _dbToTnList(_dataTn);
      //Transfers
      final _dataTr = await dataSource.getAllDataFullIntQuery(TransfersNames.tableName, [TransfersNames.user_id, TransfersNames.usedForCashFlow, TransfersNames.processed], [id, AppConstants.usedInCashFlowYes, AppConstants.processedNo]);      
      final _transfers = await _dbToTrList(_dataTr);
      //FactsBase
      final _facts = FactsBase(accounts: _accounts, categories: _categories, recurrences: _recurrences, transactions: _transactions, transfers: _transfers, users: _users, addinterests: _addInterests);
      return Right(_facts);
     } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  List<Recurrence> _dbToRModelList(List<Map<String, dynamic>> data){
    final List<Recurrence> _items = data.map(
      (item) => Recurrence(
        id: item[RecurrenceNames.id],
        title: item[RecurrenceNames.title],
        description: item[RecurrenceNames.description],
        iconPath: item[RecurrenceNames.iconPath],
        type: item[RecurrenceNames.type],
        noOccurences: item[RecurrenceNames.noOccurences],
        endDate: item[RecurrenceNames.endDate] == null ? null : DateTime.parse(item[RecurrenceNames.endDate]),       
      ),
    ).toList(); 
    return _items;    
  }
  List<Category> _dbToCList(List<Map<String, dynamic>> data){
    final List<Category> _items = data.map(
      (item) => Category(
        id: item[CategoryNames.id],
        categoryName: item[CategoryNames.categoryName],
        description: item[CategoryNames.description],
        iconPath: item[CategoryNames.iconPath],
        usedForCashFlow: item[CategoryNames.usedForCashFlow] == 1 ? true : false,        
      ),
    ).toList(); 
    return _items;    
  }
  List<Transaction> _dbToTnList(List<Map<String, dynamic>> data){
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
  List<Transfer> _dbToTrList(List<Map<String, dynamic>> data){
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
        processed: item[TransactionNames.processed],     
      ),
    ).toList(); 
    return _items;    
  }  
}