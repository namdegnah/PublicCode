import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/group/group_list.dart';
import '../bloc/group/group_bloc.dart';
import '../bloc/group/group_bloc_events.dart';
import '../bloc/group/group_bloc_states.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildPage(context);
  }
}

Builder buildPage(BuildContext context) {
  BlocProvider.of<GroupBloc>(context).add(GroupRequestData());
  return Builder(
    builder: (context) {
      final groupsState = context.watch<GroupBloc>().state;
      if (groupsState is GroupErrorState) {
        return const Text('Empty State');
      } else if (groupsState is GroupLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (groupsState is Error) {
        return const Text('Error Error Error');
      } else if (groupsState is GroupsListState) {
        return GroupList(groupsState.groups);
      }
      return const Text('A Widget');
    },
  );
}
