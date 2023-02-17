import '../entities/accounts/account_add_interest.dart';
import 'package:dartz/dartz.dart';
import '../../core/errors/error_export.dart';
import '../../data/models/dialog_base.dart';
import '../../data/models/facts_base.dart';
import '../entities/user.dart';
import '../entities/accounts/account.dart';
import '../entities/accounts/account_savings.dart';
import '../entities/accounts/account_type.dart';
import '../entities/accounts/account_simple_savings.dart';
import '../entities/recurrence.dart';
import '../entities/category.dart';
import '../entities/transaction.dart';
import '../entities/transfer.dart';
import '../entities/setting.dart';

abstract class UserRepository{
  Future<Either<Failure, List<User>>> insertUser(User user);
  Future<Either<Failure, List<User>>> userList();
  Future<Either<Failure, User>> user(int id);
  Future<Either<Failure, List<User>>> deleteUser(int id);
  Future<Either<Failure, List<User>>> updateUser(User user);
}

abstract class AccountRepository{
  Future<Either<Failure, DialogBase>> insertAccount(Account account);
  Future<Either<Failure, List<Account>>> accountList(int user_id);
  Future<Either<Failure, Account>> account(Account account);
  Future<Either<Failure, Account>> getAccountSimpleSavingsByID(int id);
  Future<Either<Failure, DialogBase>> deleteAccount(Account account);
  Future<Either<Failure, DialogBase>> updateAccount(Account account);
  Future<Either<Failure, DialogBase>> accountsAndDetails();
  Future<Either<Failure, DialogBase>> shareAccount(Account account, int id);
  Future<Either<Failure, bool>> doesUserShareAccout(Account account, int account_id, int user_id);
  List<Account> fromDBtoAccountList(List<Map<String, dynamic>> data);
  List<AccountSavings> fromDBtoListAccountSavings(List<Map<String, dynamic>> data);
  List<AccountSimpleSavings> fromDBtoListAccountSimpleSavings(List<Map<String, dynamic>> data);
  Future<Either<Failure, DialogBase>> insertAccountSavings(AccountSavings account);
  Future<Either<Failure, DialogBase>> insertAccountSimpleSavings(AccountSimpleSavings account);    
}
abstract class DialogRepository{
  Future<Either<Failure, DialogBase>> dialogFull();
  Future<Either<Failure, DialogBase>> dialogRecurrences();
  Future<Either<Failure, DialogBase>> dialogCategories();
  Future<Either<Failure, DialogBase>> dialogAccounts();
  Future<Either<Failure, DialogBase>> dialogUsers();
  Future<Either<Failure, DialogBase>> dialogAccountTypes();
  Future<Either<Failure, List<Account>>> getAccounts();
  Future<Either<Failure, List<Recurrence>>> getRecurrences();
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<AccountType>>> getAccountTypes();
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, List<AddInterest>>> getAddInterest();
}
abstract class RecurrenceRepository{
  Future<Either<Failure, List<Recurrence>>> insertRecurrence(Recurrence recurrence);
  Future<Either<Failure, List<Recurrence>>> recurrenceList();
  Future<Either<Failure, Recurrence>> recurrence(int id);
  Future<Either<Failure, List<Recurrence>>> deleteRecurrence(int id);
  Future<Either<Failure, List<Recurrence>>> updateRecurrence(Recurrence recurrence);
}
abstract class CategoryRepository{
  Future<Either<Failure, List<Category>>> insertCategory(Category category);
  Future<Either<Failure, List<Category>>> categoryList();
  Future<Either<Failure, Category>> category(int id);
  Future<Either<Failure, List<Category>>> deleteCategory(int id);
  Future<Either<Failure, List<Category>>> updateCategory(Category category);
}
abstract class TransactionRepository{
  Future<Either<Failure, List<Transaction>>> insertTransaction(Transaction transaction);
  Future<Either<Failure, List<Transaction>>> transactionList();
  Future<Either<Failure, Transaction>> transaction(int id);
  Future<Either<Failure, List<Transaction>>> deleteTransaction(int id);
  Future<Either<Failure, List<Transaction>>> updateTransaction(Transaction transaction);
  Future<Either<Failure, DialogBase>> dialogList(List<String> tableNames);
  Future<Either<Failure, ServerSuccess>> updateProcess(int id);
}
abstract class TransferRepository{
  Future<Either<Failure, List<Transfer>>> insertTransfer(Transfer transfer);
  Future<Either<Failure, List<Transfer>>> transferList();
  Future<Either<Failure, Transfer>> transfer(int id);
  Future<Either<Failure, List<Transfer>>> deleteTransfer(int id);
  Future<Either<Failure, List<Transfer>>> updateTransfer(Transfer transfer);
  Future<Either<Failure, DialogBase>> dialogList(List<String> tableNames);
  Future<Either<Failure, ServerSuccess>> updateProcess(int id);  
}
abstract class FactsRepository{
  Future<Either<Failure, FactsBase>> facts([int user_id]);
  Future<Either<Failure, List<User>>> getUsers();
  DateTime? today;
}
abstract class SettingRepository{
  Future<Either<Failure, void>> deleteUserSettings(int user_id);
  Future<Either<Failure, Setting>> instertDefaultUserSettings(int user_id);
  Future<Either<Failure, Setting>> updateUserSetting(int user_id, int setting_id, int? value, {DateTime timed});
  Future<Either<Failure, Setting>> getUserSettings(int user_id);
  Future<Either<Failure, DialogBase>> barChartSettings(int user_id, int? account_id);
}