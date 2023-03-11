part of 'http_bloc.dart';

abstract class HttpState {}

class HttpInitialState extends HttpState {}


class HttpEmptyState extends HttpState {}

class HttpLoadingState extends HttpState {}

class HttpErrorState extends HttpState {
  final String message;
  HttpErrorState({required this.message});
}


class HttpMatchListState extends HttpState {
    final BestTeam bestTeam;
    HttpMatchListState({required this.bestTeam});
}

