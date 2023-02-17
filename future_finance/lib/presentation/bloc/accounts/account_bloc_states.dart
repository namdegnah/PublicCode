import 'package:meta/meta.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../data/models/dialog_base.dart';

@immutable
abstract class AccountsBlocState{
}
class AccountsInitialState extends AccountsBlocState{}

class Empty extends AccountsBlocState{}
class Loading extends AccountsBlocState{}
class Error extends AccountsBlocState{
  final String message;
  Error({required this.message});
}
class AccountState extends AccountsBlocState{
  final Account account;
  AccountState({required this.account});
}
class AccountsState extends AccountsBlocState{
  final List<Account> accounts;
  AccountsState({required this.accounts});
}
class AccountsDeleteState extends AccountsBlocState{
  final List<String> transactions;
  final List<String> transfers;
  AccountsDeleteState({required this.transactions, required this.transfers});
}
class AccountsDialogState extends AccountsBlocState{
  final DialogBase db;
  AccountsDialogState({required this.db});
}
