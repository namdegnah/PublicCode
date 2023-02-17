part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeChangedEvent extends ThemeEvent {
  final AppTheme theme;
  ThemeChangedEvent({required this.theme});
}
