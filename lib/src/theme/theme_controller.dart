import 'package:flutterstrap/flutterstrap.dart';
import 'package:flutter/material.dart';

class FThemeController extends ChangeNotifier {
  FThemeController({
    required this.theme,
  });

  FlutterstrapTheme<FlutterstrapColorScheme> theme;

  setTheme(FlutterstrapTheme<FlutterstrapColorScheme> theme) {
    this.theme = theme;
    notifyListeners();
  }
}
