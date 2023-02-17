import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/usecases/dialog_usecase.dart';
import '../../../data/models/params.dart';
import 'dialog_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/dialog_base.dart';
import '../../config/injection_container.dart';


class DialogBloc extends Bloc<DialogBlocEvent, DialogBlocState> {
  final DialogUser dialogUser = sl<DialogUser>();
  DialogBloc() : super(DialogInitialState()){
    on<DialogFullEvent>((event, emit) => _getDialogFull(event, emit));
    on<DialogAccountsEvent>((event, emit) => _getDialogAccounts(event, emit));
    on<DialogRecurrenceEvent>((event, emit) => _getDialogRecurrences(event, emit));
    on<DialogCategoriesEvent>((event, emit) => _getDialogCategories(event, emit));
    on<DialogUsersEvent>((event, emit) => _getDialogUsers(event, emit));
    on<DialogAccountTypesEvent>((event, emit) => _getDialogAcountTypes(event, emit));
  }
  void _getDialogFull(DialogFullEvent event, Emitter<DialogBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await dialogUser.call(Params());
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogbase) => emit(DialogFullState(data: dialogbase)),      
    );
  }
  void _getDialogAccounts(DialogAccountsEvent event, Emitter<DialogBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await dialogUser.dialogAccounts();
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogbase) => emit(DialogAccountsState(data: dialogbase),),      
    );
  }
  void _getDialogRecurrences(DialogRecurrenceEvent event, Emitter<DialogBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await dialogUser.dialogRecurrences();
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogbase) => emit(DialogRecurrencesState(data: dialogbase),),      
    );
  }
  void _getDialogCategories(DialogCategoriesEvent event, Emitter<DialogBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await dialogUser.dialogCategories();
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogbase) => emit(DialogCategoriesState(data: dialogbase),),      
    );
  }
  void _getDialogUsers(DialogUsersEvent event, Emitter<DialogBlocState> emit) async {
    final failureOrDialogBase = await dialogUser.dialogUsers();
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogbase) => emit(DialogUsersState(data: dialogbase),),      
    );    
  }
  void _getDialogAcountTypes(DialogAccountTypesEvent event, Emitter<DialogBlocState> emit) async {
    final failureOrDialogBase = await dialogUser.dialogAccountTypes();
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogbase) => emit(DialogAccountTypeState(data: dialogbase),),      
    );
  }

}
  
    
  
