import 'package:bloc/bloc.dart';
import 'group_bloc_events.dart';
import 'group_bloc_states.dart';
import '../../config/injection_container.dart';
import '../../../domain/entities/group.dart';
import '../../../domain/usecases/group_usecase.dart';
import '../../../data/models/params.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {

  GroupUser groupUser = sl<GroupUser>();

  GroupBloc() : super(GroupInitialState()) {
    on<GroupRequestData>((event, emit) => _getGroupsFromDB(event, emit));
    on<InsertGroupEvent>((event, emit) => _insertGroup(event, emit));
    on<DeleteGroupEvent>((event, emit) => _deleteGroup(event, emit));
    on<UpdateGroupEvent>((event, emit) => _updateGroup(event, emit));
    on<InsertBlindGroupEvent>((event, emit) => _insertBlindGroup(event, emit));    
  }
  void _getGroupsFromDB(GroupRequestData event, Emitter<GroupState> emit) async {
    emit(GroupLoadingState());
    final either = await groupUser.getGroups();
    either.fold(
      (failure) => GroupErrorState(message: failure.message),
      (list) => emit(GroupsListState(groups: list)),
    );
  }   
  void _insertGroup(InsertGroupEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoadingState());
    final either = await groupUser.insertGroup(Params.group(group: Group(id: -1, name: event.group.name)));       
    either.fold(
      (failure) => GroupErrorState(message: failure.message),
      (list) => emit(GroupsListState(groups: list)),
    );  
  } 
  void _insertBlindGroup(InsertBlindGroupEvent event, Emitter<GroupState> emit) async {
    final either = await groupUser.insertGroup(Params.group(group: Group(id: -1, name: event.group.name)));       
    either.fold(
      (failure) => GroupErrorState(message: failure.message),
      (list) => null,
    );  
  }  
  void _deleteGroup(DeleteGroupEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoadingState());
    final either = await groupUser.deleteGroup(Params.id(id: event.id));
    either.fold(
      (failure) => GroupErrorState(message: failure.message),
      (list) => emit(GroupsListState(groups: list)),
    );
  }    
  void _updateGroup(UpdateGroupEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoadingState());
    final either = await groupUser.updateGroup(Params.group(group: event.group));
    either.fold(
      (failure) => GroupErrorState(message: failure.message),
      (list) => emit(GroupsListState(groups: list)),
    );
  }  
}
