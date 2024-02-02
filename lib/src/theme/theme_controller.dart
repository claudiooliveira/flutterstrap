import 'package:flutterstrap/flutterstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutterstrap/src/theme/color_scheme.dart';

class FThemeController extends ChangeNotifier {
  FThemeController({
    required this.theme,
  });

  FlutterstrapTheme<FlutterstrapDefaultColorScheme> theme;

  setTheme(FlutterstrapTheme<FlutterstrapDefaultColorScheme> theme) {
    this.theme = theme;
    notifyListeners();
  }
}
