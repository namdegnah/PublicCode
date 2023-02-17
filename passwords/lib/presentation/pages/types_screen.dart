import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/type/type_list.dart';
import '../bloc/type/type_bloc.dart';
import '../bloc/type/type_bloc_events.dart';
import '../bloc/type/type_bloc_states.dart';

class TypesScreen extends StatelessWidget {
  const TypesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildPage(context);
  }
}

Builder buildPage(BuildContext context) {
  BlocProvider.of<TypeBloc>(context).add(TypeRequestData());
  return Builder(
    builder: (context) {
      final typeState = context.watch<TypeBloc>().state;
      if (typeState is TypeErrorState) {
        return const Text('Empty State');
      } else if (typeState is TypeLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (typeState is Error) {
        return const Text('well');
      } else if (typeState is TypeListState) {
        return TypeList(typeState.types);
      }
      return const Text('A Widget');
    },
  );
}
