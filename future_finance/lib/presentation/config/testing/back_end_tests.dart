// usecases
import '../../../domain/usecases/category_usecase.dart';
import '../../../domain/usecases/account_usecase.dart';
import '../../../domain/usecases/recurrence_usecase.dart';
import '../../../domain/usecases/transfer_usecase.dart';
// entities
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/recurrence.dart';
import '../../../domain/entities/transfer.dart';
// repositories
import '../../../data/repositories/account_repository_imp.dart';
import '../../../data/repositories/category_repository_imp.dart';
import '../../../data/repositories/recurrence_repository_imp.dart';
import '../../../data/repositories/transfer_repository_imp.dart';
// common
import '../../../data/models/params.dart';
import '../../../data/datasources/local_data_source_imp.dart';
import '../../../data/models/dialog_base.dart';

class CrudTesting{

  Future<List<String>> testCRUD(List<String> input) async {

    input = await testAccountCRUD(input);
    input = await testCategoryCRUD(input);
    input = await testRecurrenceCRUD(input);
    input = await testTransferCRUD(input);
    return input;
  }

  // set up
  String uniqueDescription = 'Z1z2Z3z4Z5z6Z7z8Z9';
  Params p = Params.id(id: 1); // set the user_id to 1
  LocalDataSource lds = LocalDataSource();
  late AccountRepositoryImp accountRepositoryImp;
  late CategoryRepositoryImp categoryRepositoryImp;
  late RecurrenceRepositoryImp recurrenceRepositoryImp;
  late TransferRepositoryImp transferRepositoryImp;
  late AccountUser accountUser;
  late CategoryUser categoryUser;
  late RecurrenceUser recurrenceUser;
  late TransferUser transferUser;

  // create an account, update it, retrieve it, delete it
  Future<List<String>> testAccountCRUD(List<String> results) async {
    accountRepositoryImp = AccountRepositoryImp(dataSource: lds);
    accountUser = AccountUser(repository: accountRepositoryImp);
    late DialogBase db;
    late Account retrievedAccount;
    bool result = false;
    Account account = Account(id: -1, accountName: 'testing', balance: 0.0, description: 'a');
    Params p = Params(account: account);
    // Create
    var _dialog = await accountUser.insertAccount(p);
    _dialog.fold(
      (failure) => result = false,
      (dbase) {
        result = true;
        db = dbase;
      }
    );
    // Update
    account.id = db.id!;
    if(result == true){
      late List<Account> accounts;
      account.description = uniqueDescription;
      var _updateAccount = await accountUser.updateAccount(p);
      _updateAccount.fold(
        (failure) => result = false,
        (db) => accounts = db.accounts!,
      );
    }
    // Retrieve
    if(result == true){
      var _account = await accountUser.account(p);
      _account.fold(
        (failure) => result = false,
        (theAccount) {
          result = true;
          retrievedAccount = theAccount;
        } 
      );
    }
    // Check
    if(retrievedAccount.description.compareTo(account.description) == 0){
      result = true;
    } else {
      result = false;
    }
    // Delete
    if(result == true){
      var _delete = await accountUser.deleteAccount(p);
      _delete.fold(
        (failure) => result = false,
        (dbase) {
          result = true;
          db = dbase;
        }
      );
    }
    results.add('Account tests: $result');
    return results;
    }  
  // create a category, update it, retrieve it, delete it
  Future<List<String>> testCategoryCRUD(List<String> results) async {
    categoryRepositoryImp = CategoryRepositoryImp(dataSource: lds);
    categoryUser = CategoryUser(repository: categoryRepositoryImp);
    late List<Category> categories;
    bool result = false;
    Category category = Category(id: -1, categoryName: 'testing', description: 'a', iconPath: 'a');
    Params p = Params.category(category: category);
    late Category retrievedCategory;
    // Create
    var _dialog = await categoryUser.insertCategory(p);
    _dialog.fold(
      (failure) => result = false,
      (categoryList) {
        result = true;
        categories = categoryList;
      }
    );
    categories.sort((a, b) => a.id.compareTo(b.id),);
    category.id = categories.last.id;
    p = Params.category(category: category);
    // Update
    if(result == true){
      category.description = uniqueDescription;
      var _updateCategory = await categoryUser.updateCategory(p);
      _updateCategory.fold(
        (failure) => result = false,
        (categoryList) {
          result = true;
          categories = categoryList;
        }
      );
    }
    // Retrieve
    p = Params.id(id: category.id);
    if(result == true){      
      var _category = await categoryUser.category(p);
      _category.fold(
        (failure) => result = false,
        (categoryValue) {
          result = true;
          retrievedCategory = categoryValue;
        } 
      );
    }
    // Check
    if(retrievedCategory.description.compareTo(category.description) == 0){
      result = true;
    } else {
      result = false;
    }    
    // Delete
    if(result == true){
      var _delete = await categoryUser.deleteCategory(p);
      _delete.fold(
        (failure) => result = false,
        (categoryList) {
          result = true;
          categories = categoryList;
        }
      );
    }
    results.add('Category tests: $result');
    return results;
    }      
  // create a recurrence, update it, retrieve it, delete it
  Future<List<String>> testRecurrenceCRUD(List<String> results) async {
    recurrenceRepositoryImp = RecurrenceRepositoryImp(dataSource: lds);
    recurrenceUser = RecurrenceUser(repository: recurrenceRepositoryImp);
    late List<Recurrence> recurrences;
    bool result = false;
    Recurrence recurrence = Recurrence(id: -1, title: 'testing', description: 'a', iconPath: 'a', type: 0);
    Params p = Params.recurrence(recurrence: recurrence);
    late Recurrence retrievedRecurrence;
    // Create
    var _dialog = await recurrenceUser.insertRecurrence(p);
    _dialog.fold(
      (failure) => result = false,
      (recurrencyList) {
        result = true;
        recurrences = recurrencyList;
      }
    );
    recurrences.sort((a, b) => a.id.compareTo(b.id),);
    recurrence.id = recurrences.last.id;
    p = Params.recurrence(recurrence: recurrence);
    // Update
    if(result == true){
      recurrence.description = uniqueDescription;
      var _updateRecurrence = await recurrenceUser.updateRecurrence(p);
      _updateRecurrence.fold(
        (failure) => result = false,
        (recurrenceList) {
          result = true;
          recurrences = recurrenceList;
        }
      );
    }
    // Retrieve
    p = Params.id(id: recurrence.id);
    if(result == true){      
      var _recurrence = await recurrenceUser.recurrence(p);
      _recurrence.fold(
        (failure) => result = false,
        (recurrenceValue) {
          result = true;
          retrievedRecurrence = recurrenceValue;
        } 
      );
    }
    // Check
    if(retrievedRecurrence.description.compareTo(recurrence.description) == 0){
      result = true;
    } else {
      result = false;
    }    
    // Delete
    if(result == true){
      var _delete = await recurrenceUser.deleteRecurrence(p);
      _delete.fold(
        (failure) => result = false,
        (recurrenceList) {
          result = true;
          recurrences = recurrenceList;
        }
      );
    }
    results.add('Recurrence tests: $result');
    return results;
    } 
  // create a transfer, update it, retrieve it, delete it
  Future<List<String>> testTransferCRUD(List<String> results) async {
    transferRepositoryImp = TransferRepositoryImp(dataSource: lds);
    transferUser = TransferUser(repository: transferRepositoryImp);
    late List<Transfer> transfers;
    bool result = false;
    Transfer transfer = Transfer(id: 1, user_id: 1, title: 'a', description: 'a', processed: 0, fromAccountId: 1, toAccountId: 1, categoryId: 1, recurrenceId: 1, amount: 0.0, plannedDate: null);
    Params p = Params.transfer(transfer: transfer);
    late Transfer retrievedTransfer;
    // Create
    var _dialog = await transferUser.insertTransfer(p);
    _dialog.fold(
      (failure) => result = false,
      (transferList) {
        result = true;
        transfers = transferList;
      }
    );
    transfers.sort((a, b) => a.id.compareTo(b.id),);
    transfer.id = transfers.last.id;
    p = Params.transfer(transfer: transfer);
    // Update
    if(result == true){
      transfer.description = uniqueDescription;
      var _updateTransfer = await transferUser.updateTransfer(p);
      _updateTransfer.fold(
        (failure) => result = false,
        (transferList) {
          result = true;
          transfers = transferList;
        }
      );
    }
    // Retrieve
    p = Params.id(id: transfer.id);
    if(result == true){      
      var _transfer = await transferUser.transfer(p);
      _transfer.fold(
        (failure) => result = false,
        (transferValue) {
          result = true;
          retrievedTransfer = transferValue;
        } 
      );
    }
    // Check
    if(retrievedTransfer.description.compareTo(transfer.description) == 0){
      result = true;
    } else {
      result = false;
    }    
    // Delete
    if(result == true){
      var _delete = await transferUser.deleteTransfer(p);
      _delete.fold(
        (failure) => result = false,
        (transferList) {
          result = true;
          transfers = transferList;
        }
      );
    }
    results.add('Transfer tests: $result');
    return results;
    }             
  }
  

