import '../../../domain/entities/group.dart';

abstract class GroupState {}

// class UserInitialState extends GroupState {}
class GroupInitialState extends GroupState {}
// class UserEmptyState extends GroupState {}

// class UserLoadingState extends GroupState {}
class GroupLoadingState extends GroupState {}

// class UserErrorState extends GroupState {
//   final String message;
//   UserErrorState({required this.message});
// }
class GroupErrorState extends GroupState {
  final String message;
  GroupErrorState({required this.message});
}
// class UserDataState extends GroupState {
//   final User user;
//   UserDataState({
//     required this.user,
//   });
// }

// class UsersListState extends GroupState {
//   final List<User> users;
//   UsersListState({required this.users});
// }
class GroupsListState extends GroupState {
  final List<Group> groups;
  GroupsListState({required this.groups});
}


