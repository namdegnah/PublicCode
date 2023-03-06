import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/http/http_bloc.dart';
import 'best_team_screen.dart';

class HomeSink extends StatelessWidget {
  const HomeSink({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildPage(context);
  }
}

Builder buildPage(BuildContext context) {
  BlocProvider.of<HttpBloc>(context).add(MatchesRequestData());
  return Builder(
    builder: (context) {
      final userState = context.watch<HttpBloc>().state;
      if (userState is HttpErrorState) {
        return const Text('ERROR State');
      } else if (userState is HttpLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (userState is Error) {
        return const Text('well');
      } else if (userState is HttpMatchListState) {
        return BestTeamScreen(bestTeam: userState.bestTeam);
      }
      
      return const Text('A Widget');
    },
  );
}