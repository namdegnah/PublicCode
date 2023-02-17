import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/theme/app_themes.dart';
import 'package:flutter/material.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(themeData: appThemeData[AppTheme.greenLight])) {
    on<ThemeChangedEvent>((event, emit) => themeChangedStateOutput(event, emit));    
  }
  void themeChangedStateOutput(ThemeChangedEvent event, Emitter<ThemeState> emit){
    emit(ThemeChosenState(themeData: appThemeData[event.theme])); 
  }
}
