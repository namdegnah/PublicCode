import '../../../domain/entities/type.dart';

abstract class TypeState {}

class TodoInitialState extends TypeState {}
class TypeInitialState extends TypeState {}

class TodoEmptyState extends TypeState {}

class TodoLoadingState extends TypeState {}
class TypeLoadingState extends TypeState {}

class TodoErrorState extends TypeState {
  final String message;
  TodoErrorState({required this.message});
}
class TypeErrorState extends TypeState {
  final String message;
  TypeErrorState({required this.message});
}
// class TodoDataState extends TypeState {
//   final Todo user;
//   TodoDataState({
//     required this.user,
//   });
// }

// class TodoListState extends TypeState {
//   final List<Todo> todo;
//   TodoListState({required this.todo});
// }
class TypeListState extends TypeState {
  final List<Type> types;
  TypeListState({required this.types});
}

