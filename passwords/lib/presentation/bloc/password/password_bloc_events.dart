import '../../../domain/entities/password.dart';

abstract class PasswordEvent{}

class PasswordRequestData extends PasswordEvent{}
class PasswordRequestAllData extends PasswordEvent{}

class InsertPasswordEvent extends PasswordEvent{
  final Password password;
  InsertPasswordEvent({required this.password});
}
class DeletePasswordEvent extends PasswordEvent{
  final int id;
  DeletePasswordEvent({required this.id});
}
class UpdatePasswordEvent extends PasswordEvent{
  final Password password;
  UpdatePasswordEvent({required this.password});
}
class InsertBlindPasswordEvent extends PasswordEvent{
  final Password password;
  InsertBlindPasswordEvent({required this.password});
}