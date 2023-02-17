enum ElevatedButtons { lightMode, darkMode, lightModeBold, darkModeBold }

extension ElevatedButtonInfo on ElevatedButtons {
  String get explanation {
    switch (this) {
      case ElevatedButtons.lightMode:
        return 'Simple Elevated Button';
      case ElevatedButtons.darkMode:
        return 'Medium Elevated Button';
      case ElevatedButtons.lightModeBold:
        return 'Large Elevated Button';
      case ElevatedButtons.darkModeBold:
        return 'Wide Elevated Button';
      default:
        return 'No Elevated Button Type';
    }
  }
}
