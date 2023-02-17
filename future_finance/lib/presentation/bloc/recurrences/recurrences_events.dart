import 'package:meta/meta.dart';
import '../../../domain/entities/recurrence.dart';

@immutable
abstract class RecurrencesBlocEvent{}

class GetRecurrencesEvent extends RecurrencesBlocEvent{}
class GetRecurrenceEvent extends RecurrencesBlocEvent{
  final int id;
  GetRecurrenceEvent({required this.id});
}
class DeleteRecurrenceEvent extends RecurrencesBlocEvent{
  final int id;
  DeleteRecurrenceEvent({required this.id});
}
class UpdateRecurrenceEvent extends RecurrencesBlocEvent{
  final Recurrence recurrence;
  UpdateRecurrenceEvent({required this.recurrence});
}
class InsertRecurrenceEvent extends RecurrencesBlocEvent{
  final Recurrence recurrence;
  InsertRecurrenceEvent({required this.recurrence});
}