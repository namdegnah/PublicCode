import '../../../domain/entities/password.dart';

abstract class PasswordState {}

class PasswordInitialState extends PasswordState {}

class PasswordLoadingState extends PasswordState {}

class PasswordErrorState extends PasswordState {
  final String message;
  PasswordErrorState({required this.message});
}
class PasswordListState extends PasswordState {
  final List<Password> passwords;
  PasswordListState({required this.passwords});
}


