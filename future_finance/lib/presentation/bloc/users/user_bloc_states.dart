import '../../../domain/entities/user.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserEmptyState extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String message;
  UserErrorState({required this.message});
}

class UserDataState extends UserState {
  final User user;
  UserDataState({
    required this.user,
  });
}

class UsersListState extends UserState {
  final List<User> users;
  UsersListState({required this.users});
}


