import '../../../domain/entities/password_field.dart';
import '../../../data/models/data_set.dart';

abstract class SetupState {}

class SetupInitialState extends SetupState {}
class SetupLoadingState extends SetupState {}
class SetupErrorState extends SetupState {
  final String message;
  SetupErrorState({required this.message});
}
class SetupDataState extends SetupState {
  final DataSet dataSet;
  SetupDataState({required this.dataSet});
}


