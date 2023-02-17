import 'package:bloc/bloc.dart';
import 'user_bloc_events.dart';
import 'user_bloc_states.dart';
import '../../config/injection_container.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/user_usecase.dart';
import '../../../data/models/params.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserUser userUser = sl<UserUser>();
  

  UserBloc() : super(UserInitialState()) {
    on<UserRequestData>((event, emit) => _getUsersFromDB(event, emit));
    on<InsertUserEvent>((event, emit) => _insertUser(event, emit));
    on<DeleteUserEvent>((event, emit) => _deleteUser(event, emit));
    on<UpdateUserEvent>((event, emit) => _updateUser(event, emit));    
  }
  void _getUsersFromDB(UserRequestData event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final either = await userUser.getUsers();
    either.fold(
      (failure) => UserErrorState(message: failure.message),
      (list) => emit(UsersListState(users: list)),
    );
  }
  void _insertUser(InsertUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final either = await userUser.insertUser(Params.user(user: User(id: -1, name: event.user.name, email: event.user.email, password: event.user.password)));       
    either.fold(
      (failure) => UserErrorState(message: failure.message),
      (list) => emit(UsersListState(users: list)),
    );  
  }  
  void _deleteUser(DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final either = await userUser.deleteUser(Params.id(id: event.id));
    either.fold(
      (failure) => UserErrorState(message: failure.message),
      (list) => emit(UsersListState(users: list)),
    );
  }  
  void _updateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final either = await userUser.updateUser(Params.user(user: event.user));
    either.fold(
      (failure) => UserErrorState(message: failure.message),
      (list) => emit(UsersListState(users: list)),
    );
  }  
}
