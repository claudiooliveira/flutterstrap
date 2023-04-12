import 'package:flutterstrap/flutterstrap.dart';
import 'package:flutter/material.dart';

class FThemeController extends ChangeNotifier {
  FThemeController({
    required this.theme,
  });

  FlutterstrapTheme theme;

  setTheme(FlutterstrapTheme theme) {
    this.theme = theme;
    notifyListeners();
  }
}
