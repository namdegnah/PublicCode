import '../../../domain/entities/group.dart';

abstract class GroupEvent{}

class GroupRequestData extends GroupEvent{}

class InsertGroupEvent extends GroupEvent{
  final Group group;
  InsertGroupEvent({required this.group});
}
class DeleteGroupEvent extends GroupEvent{
  final int id;
  DeleteGroupEvent({required this.id});
}
class UpdateGroupEvent extends GroupEvent{
  final Group group;
  UpdateGroupEvent({required this.group});
}
class InsertBlindGroupEvent extends GroupEvent {
  final Group group;
  InsertBlindGroupEvent({required this.group});
}