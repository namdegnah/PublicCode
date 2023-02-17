part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {
  final ThemeData? themeData;
  ThemeInitial({required this.themeData});
}

class ThemeChosenState extends ThemeState {
  final ThemeData? themeData;
  ThemeChosenState({required this.themeData});
}
