import '../../../domain/entities/type.dart';

abstract class TypeEvent{}

class TodoRequestData extends TypeEvent{}
class TypeRequestData extends TypeEvent{}

class InsertTypeEvent extends TypeEvent{
  final Type type;
  InsertTypeEvent({required this.type});
}
class DeleteTypeEvent extends TypeEvent{
  final Type type;
  DeleteTypeEvent({required this.type});
}
class UpdateTypeEvent extends TypeEvent{
  final Type type;
  UpdateTypeEvent({required this.type});
}
class InsertTypeFieldEvent extends TypeEvent {
  final Type type;
  InsertTypeFieldEvent({required this.type});
}
class InsertBlindTypeEvent extends TypeEvent{
  final Type type;
  InsertBlindTypeEvent({required this.type});
}