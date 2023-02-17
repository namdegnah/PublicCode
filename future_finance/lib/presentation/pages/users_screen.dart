import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/users/users_list.dart';
import '../bloc/users/user_bloc.dart';
import '../bloc/users/user_bloc_events.dart';
import '../bloc/users/user_bloc_states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildPage(context);
  }
}

Builder buildPage(BuildContext context) {
  BlocProvider.of<UserBloc>(context).add(UserRequestData());
  return Builder(
    builder: (context) {
      final userState = context.watch<UserBloc>().state;
      if (userState is UserErrorState) {
        return const Text('Empty State');
      } else if (userState is UserLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (userState is Error) {
        return const Text('Error Error Error');
      } else if (userState is UsersListState) {
        return UserList(userState.users);
      }
      return const Text('A Widget');
    },
  );
}
