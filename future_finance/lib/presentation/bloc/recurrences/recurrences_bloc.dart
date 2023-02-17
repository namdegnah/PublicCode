import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/recurrence_usecase.dart';
import '../../../data/models/params.dart';
import 'recurrence_bloc_exports.dart';
import '../../config/injection_container.dart';

class RecurrencesBloc extends Bloc<RecurrencesBlocEvent, RecurrencesBlocState> {
  final RecurrenceUser recurrenceUser = sl<RecurrenceUser>();
  RecurrencesBloc() : super(RecurrencesInitialState()){
    on<GetRecurrencesEvent>((event, emit) => _getRecurrences(event, emit));
    on<GetRecurrenceEvent>((event, emit) => _getRecurrence(event, emit));
    on<InsertRecurrenceEvent>((event, emit) => _insertRecurrence(event, emit));
    on<DeleteRecurrenceEvent>((event, emit) => _deleteRecurrence(event, emit));
    on<UpdateRecurrenceEvent>((event, emit) => _updateRecurrence(event, emit));
  }

  void _getRecurrences(GetRecurrencesEvent event, Emitter<RecurrencesBlocState> emit) async {
    emit(Loading());
    final failureOrRecurrencesList = await recurrenceUser.call(Params());
    failureOrRecurrencesList.fold(
      (failure) => emit(Error(message: failure.message)),
      (recurrences) => emit(RecurrencesState(recurrences: recurrences)),      
    );    
  }
  void _getRecurrence(GetRecurrenceEvent event, Emitter<RecurrencesBlocState> emit) async {
    emit(Loading());
    final failureOrRecurrence = await recurrenceUser.recurrence(Params.id(id: event.id));
    failureOrRecurrence.fold(
      (failure) => emit(Error(message: failure.message)),
      (recurrence) => emit(RecurrenceState(recurrence: recurrence)),      
    );
  }
  void _insertRecurrence(InsertRecurrenceEvent event, Emitter<RecurrencesBlocState> emit) async {
    emit(Loading());
    final failureOrCategory = await recurrenceUser.insertRecurrence(Params.recurrence(recurrence: event.recurrence));
    failureOrCategory.fold(
      (failure) => emit(Error(message: failure.message)),
      (recurrences) => emit(RecurrencesState(recurrences: recurrences)),     
    );
  }
  void _deleteRecurrence(DeleteRecurrenceEvent event, Emitter<RecurrencesBlocState> emit) async {
    emit(Loading());
    final failureOrRecurrencesList = await recurrenceUser.deleteRecurrence(Params.id(id: event.id));
    failureOrRecurrencesList.fold(
      (failure) => emit(Error(message: failure.message)),
      (recurrences) => emit(RecurrencesState(recurrences: recurrences)),     
    );    
  }
  void _updateRecurrence(UpdateRecurrenceEvent event, Emitter<RecurrencesBlocState> emit) async {
    emit(Loading());
    final failureOrRecurrencesList = await recurrenceUser.updateRecurrence(Params.recurrence(recurrence: event.recurrence));
    failureOrRecurrencesList.fold(
      (failure) => emit(Error(message: failure.message)),
      (recurrences) => emit(RecurrencesState(recurrences: recurrences)),     
    );    
  }
}