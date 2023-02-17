import '../../../domain/entities/user.dart';

abstract class UserEvent{}

class UserRequestData extends UserEvent{}

class InsertUserEvent extends UserEvent{
  final User user;
  InsertUserEvent({required this.user});
}
class DeleteUserEvent extends UserEvent{
  final int id;
  DeleteUserEvent({required this.id});
}
class UpdateUserEvent extends UserEvent{
  final User user;
  UpdateUserEvent({required this.user});
}
