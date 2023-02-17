import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/account_usecase.dart';
import '../../../data/models/params.dart';
import 'account_bloc_exports.dart';
import '../../config/injection_container.dart';
import '../../widgets/common_widgets.dart';

class AccountsBloc extends Bloc<AccountsBlocEvent, AccountsBlocState> {
  final AccountUser accountUser = sl<AccountUser>();
  AccountsBloc() : super(AccountsInitialState()){
    on<GetAccountEvent>((event, emit) => _getAccount(event, emit));
    on<GetAccountsEvent>((event, emit) => _getAccounts(event, emit));
    on<InsertAccountEvent>((event, emit) => _insertAccount(event, emit));
    on<InsertAccountSavingsEvent>((event, emit) => _insertAccountSavings(event, emit));
    on<InsertAccountSimpleSavingsEvent>((event, emit) => _insertAccountSimpleSavings(event, emit));
    on<DeleteAccountEvent>((event, emit) => _deleteAcccount(event, emit));
    on<UpdateAccountEvent>((event, emit) => _updateAccount(event, emit));
    on<UpdateAccountSavingsEvent>((event, emit) => _updateAccountSavings(event, emit));
    on<UpdateAccountSimpleSavingsEvent>((event, emit) => _updateAccountSimpleSavings(event, emit));
    on<InsertSharedAccount>((event, emit) => _insertSharedAccount(event, emit));
  }

  void _getAccount(GetAccountEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrAccount = await accountUser.account(Params(account: event.account));
    failureOrAccount.fold(
      (failure) => emit(Error(message: failure.message)),
      (account) => emit(AccountState(account: account)),
    );
  }
  void _getAccounts(GetAccountsEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    int user_id = getNextAccountNumber();
    final failureOrDialogBase = await accountUser.accountsDialogs(Params.id(id: user_id));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );
  }
  // Plain account
  void _insertAccount(InsertAccountEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await accountUser.insertAccount(Params(account: event.account));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );    
  }
  void _updateAccount(UpdateAccountEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await accountUser.updateAccount(Params(account: event.account));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );
  }
  // delete any account type
  void _deleteAcccount(DeleteAccountEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await accountUser.deleteAccount(Params(account: event.account));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );    
  }
  // Account Saving
  void _insertAccountSavings(InsertAccountSavingsEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await accountUser.insertAccountSavings(Params.accountSavings(accountSavings: event.accountSavings));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );    
  }
  void _updateAccountSavings(UpdateAccountSavingsEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await accountUser.updateAccountSavings(Params.accountSavings(accountSavings: event.accountSavings));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );
  }  
  // Share an account
  void _insertSharedAccount(InsertSharedAccount event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await accountUser.sharedAccount(Params.shareAccount(account: event.account, id: event.id));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );
  } 
  // Account Simple Saving
  void _insertAccountSimpleSavings(InsertAccountSimpleSavingsEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await accountUser.insertAccountSimpleSavings(Params.accountSimpleSavings(accountSimpleSavings: event.accountSimpleSavings));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );    
  }
  void _updateAccountSimpleSavings(UpdateAccountSimpleSavingsEvent event, Emitter<AccountsBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await accountUser.updateAccountSimpleSavings(Params.accountSimpleSavings(accountSimpleSavings: event.accountSimpleSavings));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(AccountsDialogState(db: dialogBase)),      
    );
  }       
}