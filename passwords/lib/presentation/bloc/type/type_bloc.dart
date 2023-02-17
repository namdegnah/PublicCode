import 'package:bloc/bloc.dart';
import '../../config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'type_bloc_events.dart';
import 'type_bloc_states.dart';
import '../../config/injection_container.dart';
import '../../../domain/entities/type.dart';
import '../../../data/models/data_set.dart';
import '../../../domain/usecases/type_usecase.dart';
import '../../../data/models/params.dart';

class TypeBloc extends Bloc<TypeEvent, TypeState> {
  TypeUser todoUser = sl<TypeUser>();
  TypeUser typeUser = sl<TypeUser>();

  TypeBloc() : super(TypeInitialState()) {
    on<TypeRequestData>((event, emit) => _getTypesFromDB(event, emit)); 
    on<InsertTypeEvent>((event, emit) => _insertType(event, emit)); 
    on<DeleteTypeEvent>((event, emit) => _deleteType(event, emit));
    on<UpdateTypeEvent>((event, emit) => _updateType(event, emit));
    on<InsertTypeFieldEvent>((event, emit) => _insertTypeField(event, emit));
    on<InsertBlindTypeEvent>((event, emit) => _insertBlindType(event, emit)); 
  }
  void _getTypesFromDB(TypeRequestData event, Emitter<TypeState> emit) async {
    emit(TypeLoadingState());
    final either = await typeUser.getTypes();
    either.fold(
      (failure) => TypeErrorState(message: failure.message),
      (list) => emit(TypeListState(types: list)),
    );
  }  
  void _insertType(InsertTypeEvent event, Emitter<TypeState> emit) async {
    emit(TypeLoadingState());
    final either = await typeUser.insertType(Params.type(type: Type(id: -1, name: event.type.name, fields: event.type.fields, passwordValidationId: event.type.passwordValidationId)));       
    either.fold(
      (failure) => TypeErrorState(message: failure.message),
      // (list) => emit(TypeListState(types: list)),      
      (list) {
        list.setTypeFields();
        sl<DataSet>().types = list;
        emit(TypeListState(types: list));
      }
    );  
  }  
  void _insertBlindType(InsertBlindTypeEvent event, Emitter<TypeState> emit) async {
    final either = await typeUser.insertType(Params.type(type: Type(id: -1, name: event.type.name, fields: event.type.fields, passwordValidationId: event.type.passwordValidationId)));       
    either.fold(
      (failure) => TypeErrorState(message: failure.message),    
      (list) => null,
    );  
  }     
  void _deleteType(DeleteTypeEvent event, Emitter<TypeState> emit) async {
    emit(TypeLoadingState());
    final either = await typeUser.deleteType(Params.type(type: event.type));
    either.fold(
      (failure) => TypeErrorState(message: failure.message),
      (list) => emit(TypeListState(types: list)),
    );
  }     
  void _updateType(UpdateTypeEvent event, Emitter<TypeState> emit) async {
    emit(TypeLoadingState());
    final either = await todoUser.updateType(Params.type(type: event.type));
    either.fold(
      (failure) => TypeErrorState(message: failure.message),
      (list) => emit(TypeListState(types: list)),
    );
  }
  void _insertTypeField(InsertTypeFieldEvent event, Emitter<TypeState> emit) async {
    emit(TypeLoadingState());
    final either = await typeUser.insertType(Params.type(type: Type(id: -1, name: event.type.name, fields: event.type.fields, passwordValidationId: event.type.passwordValidationId)));       
    either.fold(
      (failure) => TypeErrorState(message: failure.message),
      // (list) => emit(TypeListState(types: list)),      
      (list) {
        list.setTypeFields();
        sl<DataSet>().types = list;
        emit(TypeListState(types: list));
      }
    );  
  }     
}
