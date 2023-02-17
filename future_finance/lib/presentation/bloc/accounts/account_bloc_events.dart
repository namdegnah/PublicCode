import '../../../domain/entities/accounts/account.dart';
import '../../../domain/entities/accounts/account_savings.dart';
import '../../../domain/entities/accounts/account_simple_savings.dart';

abstract class AccountsBlocEvent{}

class GetAccountsEvent extends AccountsBlocEvent{}
// Plain Account
class GetAccountEvent extends AccountsBlocEvent{
  final Account account;
  GetAccountEvent({required this.account});
}
class InsertAccountEvent extends AccountsBlocEvent{
  final Account account;
  InsertAccountEvent({required this.account});
}
class UpdateAccountEvent extends AccountsBlocEvent{
  final Account account;
  UpdateAccountEvent({required this.account});
}
class DeleteAccountEvent extends AccountsBlocEvent{
  final Account account;
  DeleteAccountEvent({required this.account});
}
class UpdateAccountOnlyEvent extends AccountsBlocEvent{
  final Account account;
  UpdateAccountOnlyEvent({required this.account});
}
// Share and account
class InsertSharedAccount extends AccountsBlocEvent{
  final Account account;
  final int id;
  InsertSharedAccount({required this.account, required this.id});
}
// Account Saving
class InsertAccountSavingsEvent extends AccountsBlocEvent{
  final AccountSavings accountSavings;
  InsertAccountSavingsEvent({required this.accountSavings});
}
class UpdateAccountSavingsEvent extends AccountsBlocEvent{
  final AccountSavings accountSavings;
  UpdateAccountSavingsEvent({required this.accountSavings});
}
// Account Simple Saving
class InsertAccountSimpleSavingsEvent extends AccountsBlocEvent{
  final AccountSimpleSavings accountSimpleSavings;
  InsertAccountSimpleSavingsEvent({required this.accountSimpleSavings});
}
class UpdateAccountSimpleSavingsEvent extends AccountsBlocEvent{
  final AccountSimpleSavings accountSimpleSavings;
  UpdateAccountSimpleSavingsEvent({required this.accountSimpleSavings});
}