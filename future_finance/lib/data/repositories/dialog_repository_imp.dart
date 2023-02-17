import '../../presentation/widgets/common_widgets.dart';
import '../../presentation/config/injection_container.dart';
import '../../domain/repositories/repositories_all.dart';
import '../datasources/data_sources.dart';
import 'package:dartz/dartz.dart';
import '../../core/errors/error_export.dart';
import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/accounts/account_savings.dart';
import '../../domain/entities/accounts/account_simple_savings.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/recurrence.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/accounts/account_type.dart';
import '../../domain/entities/accounts/account_add_interest.dart';
import '../../data/models/dialog_base.dart';
import '../../presentation/config/constants.dart';
import '../../core/util/general_util.dart';

class DialogRepositoryImp extends DialogRepository {
  final AppDataSource dataSource;
  DialogRepositoryImp({required this.dataSource});


  Future<Either<Failure, DialogBase>> dialogFull() async {
    try{
      List<User>? users;
      List<Account>? accounts;
      List<Category>? categories;
      List<Recurrence>? recurrences;
      List<AddInterest>? addInterests;

      Either<Failure, List<AddInterest>> _addInterest = await getAddInterest();
        _addInterest.fold(
          (failure) => throw(failure),
          (list) => addInterests = list,
        );      
      Either<Failure, List<User>> _users = await getUsers();
        _users.fold(
          (failure) => throw(failure),
          (list) => users = list,
        );      
      Either<Failure, List<Account>> _accounts = await getAccounts();
        _accounts.fold(
          (failure) => throw(failure),
          (list) => accounts = list,
        );
      Either<Failure, List<Category>> _categories = await getCategories();
        _categories.fold(
          (failure) => throw(failure),
          (list) => categories = list,
        );
      Either<Failure, List<Recurrence>> _recurrences = await getRecurrences();
        _recurrences.fold(
          (failure) => throw(failure),
          (list) => recurrences = list, 
        );
      return Right(DialogBase(accounts: accounts, categories: categories, recurrences: recurrences, users: users, addInterests: addInterests));

    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  @override
  Future<Either<Failure, List<AddInterest>>> getAddInterest() async {
    try{
      final _dataList= await dataSource.getData(AddInterestNames.tableName);
      return Right(toAddInterest(_dataList));      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  @override
  Future<Either<Failure, List<AccountType>>> getAccountTypes() async {
    try{
      final _dataList= await dataSource.getData(AccountTypesNames.tableName);
      return Right(toAccountTypes(_dataList));      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }   
  @override
  Future<Either<Failure, List<Recurrence>>> getRecurrences() async {
    try{
      final _dataList= await dataSource.getData(RecurrenceNames.tableName);
      return Right(toRecurrences(_dataList));      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  @override
  Future<Either<Failure,List<Category>>> getCategories() async {
    try{
      final _dataList= await dataSource.getAllDataWhereAny(CategoryNames.tableName, CategoryNames.usedForCashFlow, 1);
      return Right(toCategories(_dataList));      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try{
      final _dataList= await dataSource.getData(UserNames.tableName);
      return Right(toUsers(_dataList));      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }      
  // This is now the one place accounts are obtained, don't use any other options.
  @override
  Future<Either<Failure,List<Account>>> getAccounts() async {
    try{
      List<Account> accounts;
      int user_id = getCurrentUserId();
      AccountRepository ar = sl<AccountRepository>();
      // plain account
      String whereClause = UserAccountNames.tableName + "." + UserAccountNames.user_id + " = " + user_id.toString();
      final _dataList = await dataSource.getDataLinkWhere(tableName: AccountNames.tableName, linkTable: UserAccountNames.tableName, tableField: AccountNames.id, linkField: UserAccountNames.account_id, whereClause: whereClause);
      accounts = ar.fromDBtoAccountList(_dataList);
      // Savings Account
      whereClause = UserSavingsNames.tableName + "." + UserSavingsNames.user_id + " = " + user_id.toString();
      final _aList = await dataSource.getDataLinkWhere(tableName: AccountSavingsNames.tableName, linkTable: UserSavingsNames.tableName, tableField: AccountNames.id, linkField: UserSavingsNames.account_id, whereClause: whereClause);
      List<AccountSavings> accountSavings = ar.fromDBtoListAccountSavings(_aList);
      accounts.addAll(accountSavings);
      // Simple Savings Account
      whereClause = UserSimpleSavingsNames.tableName + "." + UserSimpleSavingsNames.user_id + " = " + user_id.toString();
      final _asList = await dataSource.getDataLinkWhere(tableName: AccountSimpleSavingsNames.tableName, linkTable: UserSimpleSavingsNames.tableName, tableField: AccountNames.id, linkField: UserSimpleSavingsNames.account_id, whereClause: whereClause);
      List<AccountSimpleSavings> accountSimpleSavings = ar.fromDBtoListAccountSimpleSavings(_asList);
      accounts.addAll(accountSimpleSavings);      
      return Right(accounts);      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, DialogBase>> dialogRecurrences() async {
    try{
      Failure? fail = null;
      late List<Recurrence> recurrences;
      Either<Failure, List<Recurrence>> _recurrences = await getRecurrences();
        _recurrences.fold(
          (failure) => fail = failure,
          (list) => recurrences = list, 
        );      
      return fail == null ? Right(DialogBase(recurrences: recurrences)) : Left(fail!);

    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  Future<Either<Failure, DialogBase>> dialogCategories() async {
    try{
      Failure? fail = null;
      late List<Category> categories;
      Either<Failure, List<Category>> _categories = await getCategories();
        _categories.fold(
          (failure) => fail = failure,
          (list) => categories = list,
        );      
      return fail == null ? Right(DialogBase(categories: categories)) : Left(fail!);
      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  Future<Either<Failure, DialogBase>> dialogAccounts() async {
    try{
      Failure? fail = null;
      late List<Account> accounts;
      Either<Failure, List<Account>> _accounts = await getAccounts();
        _accounts.fold(
          (failure) => fail = failure,
          (list) => accounts = list,
        );      
      return fail == null ? Right(DialogBase(accounts: accounts)) : Left(fail!);
      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, DialogBase>> dialogUsers() async {
    try{
      Failure? fail = null;
      late List<User> users;
      Either<Failure, List<User>> _users = await getUsers();
        _users.fold(
          (failure) => fail = failure,
          (list) => users = list,
        );
      return fail == null ? Right(DialogBase(users: users)) : Left(fail!);  
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  Future<Either<Failure, DialogBase>> dialogAccountTypes() async {
    try{
      List<AccountType> accountTypes;
      final _dataList = await dataSource.getData(AccountTypesNames.tableName);
      accountTypes = toAccountTypes(_dataList);
      return Right(DialogBase(accountTypes: accountTypes));
      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  List<AccountType> toAccountTypes(List<Map<String, dynamic>> data){
    final List<AccountType> _items = data.map(
      (item) => AccountType(
        id: item[AccountTypesNames.id],
        iconPath: item[AccountTypesNames.iconPath],
        typeName: item[AccountTypesNames.typeName],        
      ),
    ).toList(); 
    return _items;    
  }
  List<AddInterest> toAddInterest(List<Map<String, dynamic>> data){
    final List<AddInterest> _items = data.map(
      (item) => AddInterest(
        id: item[AddInterestNames.id],
        description: item[AddInterestNames.description],
        title: item[AddInterestNames.title],
        iconPath: item[AddInterestNames.iconPath],
        type: item[AddInterestNames.type],        
      ),
    ).toList(); 
    return _items;    
  }
  List<Recurrence> toRecurrences(List<Map<String, dynamic>> data){
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
  
  List<User> toUsers(List<Map<String, dynamic>> data){
    final List<User> _items = data.map(
      (item) => User(
        id: item[UserNames.id],
        name: item[UserNames.name],
        password: item[UserNames.password],
        email: item[UserNames.email],       
      ),
    ).toList(); 
    return _items;    
  }  
  List<Category> toCategories(List<Map<String, dynamic>> data){
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
                       
}