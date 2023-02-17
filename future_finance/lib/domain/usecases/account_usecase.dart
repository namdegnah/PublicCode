import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/accounts/account.dart';
import '../entities/accounts/account_savings.dart';
import '../entities/accounts/account_simple_savings.dart';
import '../repositories/repositories_all.dart';
import '../../../data/models/dialog_base.dart';

class AccountUser extends UseCase<List<Account>, Params>{
  final AccountRepository repository;
  AccountUser({required this.repository});
  late List<Account> accounts;  
  
  @override
  Future<Either<Failure, List<Account>>> call(Params params) async {
    int user_id = params.id!;
    return await repository.accountList(user_id);
  }
  Future<Either<Failure, DialogBase>> accountsDialogs(Params params) async {
    return await repository.accountsAndDetails();
  }
  Future<Either<Failure, DialogBase>> insertAccount(Params params) async {
    Account account = params.account!;
    return  await repository.insertAccount(account);
  }
  Future<Either<Failure, DialogBase>> updateAccount(Params params) async {
    Account account = params.account!;
    return await repository.updateAccount(account);
  }
  Future<Either<Failure, DialogBase>> deleteAccount(Params params) async {
    Account account = params.account!;
    return await repository.deleteAccount(account);
  }
  Future<Either<Failure, DialogBase>> insertAccountSavings(Params params) async {
    AccountSavings accountSaving = params.accountSavings!;
    return await repository.insertAccountSavings(accountSaving);
  }  
  Future<Either<Failure, DialogBase>> updateAccountSavings(Params params) async {
    AccountSavings accountSavings = params.accountSavings!;
    return await repository.updateAccount(accountSavings);
  }  
  Future<Either<Failure, DialogBase>> sharedAccount(Params params) async {
    int id = params.id!;
    Account account = params.account!;
    return await repository.shareAccount(account, id);
  }  
  Future<Either<Failure, Account>> account(Params params) async {
    Account account = params.account!;
    return await repository.account(account);
  }  
  Future<Either<Failure, DialogBase>> insertAccountSimpleSavings(Params params) async {
    AccountSimpleSavings accountSimpleSaving = params.accountSimpleSavings!;
    return await repository.insertAccountSimpleSavings(accountSimpleSaving);
  }
  Future<Either<Failure, DialogBase>> updateAccountSimpleSavings(Params params) async {
    AccountSimpleSavings accountSimpleSavings = params.accountSimpleSavings!;
    return await repository.updateAccount(accountSimpleSavings);
  }     
}