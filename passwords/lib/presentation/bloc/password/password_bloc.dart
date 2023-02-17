import 'package:bloc/bloc.dart';
import 'password_bloc_events.dart';
import 'password_bloc_states.dart';
import '../../config/injection_container.dart';
import '../../../domain/usecases/password_usecase.dart';
import '../../../domain/entities/password.dart';
import '../../../data/models/params.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {

  PasswordUser passwordUser = sl<PasswordUser>();

  PasswordBloc() : super(PasswordInitialState()) {
    on<PasswordRequestData>((event, emit) => _getPasswordsFromDB(event, emit)); 
    on<PasswordRequestAllData>((event, emit) => _getAllPasswordsFromDB(event, emit));
    on<UpdatePasswordEvent>((event, emit) => _updatePassword(event, emit)); 
    on<InsertPasswordEvent>((event, emit) => _insertPassword(event, emit)); 
    on<DeletePasswordEvent>((event, emit) => _deletePassword(event, emit)); 
    on<InsertBlindPasswordEvent>((event, emit) => _insertBlindPassword(event, emit)); 
  }
  void _getPasswordsFromDB(PasswordRequestData event, Emitter<PasswordState> emit) async {
    emit(PasswordLoadingState());
    final either = await passwordUser.getPasswords();
    either.fold(
      (failure) => PasswordErrorState(message: failure.message),
      (list) => emit(PasswordListState(passwords: list)),
    );
  }
  void _getAllPasswordsFromDB(PasswordRequestAllData event, Emitter<PasswordState> emit) async {
    emit(PasswordLoadingState());
    final either = await passwordUser.getAllPasswords();
    either.fold(
      (failure) => PasswordErrorState(message: failure.message),
      (list) => emit(PasswordListState(passwords: list)),
    );
  }  
  void _updatePassword(UpdatePasswordEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoadingState());
    final either = await passwordUser.updatePassword(Params.password(password: event.password));
    either.fold(
      (failure) => PasswordErrorState(message: failure.message),
      (list) => emit(PasswordListState(passwords: list)),
    );
  }
  void _deletePassword(DeletePasswordEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoadingState());
    final either = await passwordUser.deletePassword(Params.id(id: event.id));
    either.fold(
      (failure) => PasswordErrorState(message: failure.message),
      (list) => emit(PasswordListState(passwords: list)),
    );
  }   
  void _insertPassword(InsertPasswordEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoadingState());
    final either = await passwordUser.insertPassword(Params.password(password: event.password));       
    either.fold(
      (failure) => PasswordErrorState(message: failure.message),
      (list) => emit(PasswordListState(passwords: list)),
    );  
  }
  void _insertBlindPassword(InsertBlindPasswordEvent event, Emitter<PasswordState> emit) async {
    final either = await passwordUser.insertPassword(Params.password(password: event.password));       
    either.fold(
      (failure) => PasswordErrorState(message: failure.message),
      (list) => null,
    );  
  }         
}
