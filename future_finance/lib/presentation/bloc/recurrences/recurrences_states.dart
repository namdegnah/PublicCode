import 'package:meta/meta.dart';
import '../../../domain/entities/recurrence.dart';

@immutable
abstract class RecurrencesBlocState{}

class RecurrencesInitialState extends RecurrencesBlocState{}
// class RecurrencesBlocStateChild extends RecurrencesBlocState{
//   RecurrencesBlocStateChild();
// }
class Empty extends RecurrencesBlocState{}
class Loading extends RecurrencesBlocState{}
class Error extends RecurrencesBlocState{
  final String message;
  Error({required this.message});
}
class RecurrenceState extends RecurrencesBlocState{
  final Recurrence recurrence;
  RecurrenceState({required this.recurrence});
}
class RecurrencesState extends RecurrencesBlocState{
  final List<Recurrence> recurrences;
  RecurrencesState({required this.recurrences});
}
class RecurrenceDeleteState extends RecurrencesBlocState{
  final List<String> transactions;
  final List<String> transfers;
  RecurrenceDeleteState({required this.transactions, required this.transfers});
}