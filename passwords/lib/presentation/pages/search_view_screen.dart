import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'password_search_screen.dart';
import '../bloc/password/password_bloc.dart';
import '../bloc/password/password_bloc_events.dart';
import '../bloc/password/password_bloc_states.dart';

class SearchViewScreen extends StatelessWidget {
  const SearchViewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildPage(context);
  }
}
Builder buildPage(BuildContext context) {
  BlocProvider.of<PasswordBloc>(context).add(PasswordRequestAllData());
  return Builder(
    builder: (context) {
      final passwordsState = context.watch<PasswordBloc>().state;
      if (passwordsState is PasswordErrorState) {
        return const Text('Empty State');
      } else if (passwordsState is PasswordLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (passwordsState is Error) {
        return const Text('Error Error Error');
      } else if (passwordsState is PasswordListState) {
        return PasswordSearchScreen(data: passwordsState.passwords);
      }
      return const Text('A Widget');
    },
  );
}
