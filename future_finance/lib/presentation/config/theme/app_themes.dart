import 'green_light_theme.dart';
import 'green_dark_theme.dart';
import 'blue_dark_theme.dart';
import 'blue_light_theme.dart';

enum AppTheme {
  greenLight,
  greenDark,
  blueLight,
  blueDark,
}

extension AppThemeInfo on AppTheme {
  String get explanation {
    switch (this) {
      case AppTheme.greenLight:
        return 'Green Light Theme';
      case AppTheme.greenDark:
        return 'Green Dark Theme';
      case AppTheme.blueLight:
        return 'Blue Light Theme';
      case AppTheme.blueDark:
        return 'Blue Dark Theme';
    }
  }
}

final appThemeData = {
  AppTheme.greenLight: greenLightTheme,
  AppTheme.greenDark: greenDarkTheme,
  AppTheme.blueLight: blueLightTheme,
  AppTheme.blueDark: blueDarkTheme,
};
