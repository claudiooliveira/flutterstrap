import 'package:flutterstrap/src/button/button.dart';
import 'package:flutterstrap/src/button/button_text_format.dart';
import 'package:flutterstrap/src/theme/theme_controller.dart';
import 'package:flutter/material.dart';

enum ThemeColor {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

abstract class FlutterstrapTheme<FlutterstrapColorScheme> {
  FlutterstrapColorScheme get colorScheme;

  //Colors
  Color get primaryColor;
  Color get secondaryColor;
  Color get successColor;
  Color get dangerColor;
  Color get warningColor;
  Color get infoColor;
  Color get lightColor;
  Color get darkColor;

  Color get primaryTextColor;
  Color get secondaryTextColor;
  Color get successTextColor;
  Color get dangerTextColor;
  Color get warningTextColor;
  Color get infoTextColor;
  Color get lightTextColor;
  Color get darkTextColor;

  Color get primaryButtonTextColor;
  Color get secondaryButtonTextColor;
  Color get successButtonTextColor;
  Color get dangerButtonTextColor;
  Color get warningButtonTextColor;
  Color get infoButtonTextColor;
  Color get lightButtonTextColor;
  Color get darkButtonTextColor;

  Color get backgroundColor;

  //AppBar
  Color? get appBarColor;
  Color? get appBarInverseColor;

  TextStyle? get appBarTextStyle;
  TextStyle? get appBarInverseTextStyle;

  //Button
  BorderRadiusGeometry get buttonBorderRadius;
  EdgeInsets get buttonLargeSpacing;
  EdgeInsets get buttonStandardSpacing;
  EdgeInsets get buttonSmallSpacing;
  double get buttonLargeTextSize;
  double get buttonStandardTextSize;
  double get buttonSmallTextSize;
  double get buttonLargeIconSize;
  double get buttonStandardIconSize;
  double get buttonSmallIconSize;
  Color get buttonDisabledColor;
  Color get buttonDisabledTextColor;
  String? get buttonFontFamily;
  FontWeight? get buttonFontWeight;

  //Text
  double get textH1Size;
  double get textH2Size;
  double get textH3Size;
  double get textH4Size;
  double get textH5Size;
  double get textH6Size;
  double get textSubtitle1Size;
  double get textSubtitle2Size;
  double get textBody1Size;
  double get textBody2Size;
  double get textCaptionSize;
  double get textOverlineSize;

  FontWeight get textH1FontWeight;
  FontWeight get textH2FontWeight;
  FontWeight get textH3FontWeight;
  FontWeight get textH4FontWeight;
  FontWeight get textH5FontWeight;
  FontWeight get textH6FontWeight;
  FontWeight get textSubtitle1FontWeight;
  FontWeight get textSubtitle2FontWeight;
  FontWeight get textBody1FontWeight;
  FontWeight get textBody2FontWeight;
  FontWeight get textCaptionFontWeight;
  FontWeight get textOverlineFontWeight;
  FontWeight get textBoldWeight;

  String? get textFontFamily;
  String? get textH1FontFamily;
  String? get textH2FontFamily;
  String? get textH3FontFamily;
  String? get textH4FontFamily;
  String? get textH5FontFamily;
  String? get textH6FontFamily;
  String? get textSubtitle1FontFamily;
  String? get textSubtitle2FontFamily;
  String? get textBody1FontFamily;
  String? get textBody2FontFamily;
  String? get textCaptionFontFamily;
  String? get textOverlineFontFamily;

  ButtonTextFormat? get buttonTextFormat;

  Color get textStandardColor;
  Color get textLightColor;

  //Icon
  Color? get defaultIconColor => textStandardColor;

  // Text fields

  Color get textInputBorderColor;
  Color get textInputFocusedBorderColor;
  Color get textInputEnabledBorderColor;
  Color? get textInputFillColor;
  BorderRadius get textInputBorderRadius;
  double get textInputBorderWidth;
  double get hintTextSize;
  FontWeight get hintTextFontWeight;
  String? get hintTextFontFamily;
  Color? get hintTextColor;
  double get labelTextSize;
  FontWeight get labelTextFontWeight;
  String? get labelTextFontFamily;
  Color? get labelTextColor;
  double get fixedLabelTextSize;
  FontWeight get fixedLabelTextFontWeight;
  String? get fixedLabelTextFontFamily;
  Color? get fixedLabelTextColor;
  double get textInputFontSize;
  FontWeight get textInputFontWeight;
  String? get textInputFontFamily;
  double get textInputErrorFontSize;
  FontWeight get textInputErrorFontWeight;
  String? get textInputErrorFontFamily;
  Color? get textInputColor;
  Color get textInputErrorColor;
  Color? get textInputErrorFillColor;
  EdgeInsets? get textInputContentPadding;

  // Bottom sheet
  TextStyle? get bottomSheetTitleStyle;
  TextStyle? get bottomSheetMessageStyle;
  double get bottomSheetCloseButtonSize;
  EdgeInsets? get bottomSheetPadding;
  Color? get bottomSheetColor;
  FButtonType get bottomSheetPrimaryButtonType;
  ThemeColor get bottomSheetPrimaryButtonColor;
  FButtonType get bottomSheetSecondaryButtonType;
  ThemeColor get bottomSheetSecondaryButtonColor;

  //Card
  Color? get cardColor;
  Color? get cardShadowColor;
  Color? get cardSurfaceTintColor;
  BorderRadiusGeometry? get cardBorderRadius;
  double? get cardElevation;
  EdgeInsetsGeometry? get cardMargin;
  EdgeInsetsGeometry? get cardPadding;

  static FlutterstrapTheme<FlutterstrapColorScheme> of<FlutterstrapColorScheme>(
      BuildContext context) {
    return FlutterstrapThemeProvider.of(context).controller.theme
        as FlutterstrapTheme<FlutterstrapColorScheme>;
  }
}

// ignore: must_be_immutable
class FlutterstrapThemeProvider extends InheritedWidget {
  FlutterstrapThemeProvider(
      {required this.controller, required Widget child, Key? key})
      : super(key: key, child: child);

  FThemeController controller;

  static FlutterstrapThemeProvider of<FlutterstrapColorScheme>(
          BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FlutterstrapThemeProvider>()!;

  @override
  bool updateShouldNotify(FlutterstrapThemeProvider oldWidget) {
    return oldWidget.controller.theme != controller.theme ||
        oldWidget.child != child;
  }
}
