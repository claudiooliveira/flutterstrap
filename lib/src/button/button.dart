import 'package:flutterstrap/src/spacing/spacing.dart';
import 'package:flutterstrap/src/theme/theme.dart';
import 'package:flutter/material.dart';

import 'button_text_format.dart';

enum FButtonType { text, outlined, contained, toggle }

enum FButtonSize { small, standard, large }

enum FButtonAlign { left, center, right }

// ignore: must_be_immutable
class FButton extends StatelessWidget {
  FButton(
    this.text, {
    Key? key,
    this.onPressed,
    this.color = ThemeColor.primary,
    this.expanded = false,
    this.type = FButtonType.contained,
    this.size = FButtonSize.standard,
    this.align = FButtonAlign.center,
    this.disabled = false,
    this.loading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textFormat,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final ThemeColor color;
  final bool expanded;
  final String text;
  final FButtonType type;
  final FButtonSize size;
  final FButtonAlign align;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ButtonTextFormat? textFormat;
  late FlutterstrapTheme _theme;
  final bool disabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    _theme = FlutterstrapTheme.of(context);
    if (type == FButtonType.outlined) {
      return OutlinedButton(
        key: key,
        onPressed: disabled || loading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: _borderColor,
          backgroundColor: _backgroundColor,
          padding: _padding,
          shape: RoundedRectangleBorder(
            borderRadius: _theme.buttonBorderRadius,
          ),
          side: BorderSide(
            width: 2,
            color: _borderColor,
          ),
        ),
        child: _child,
      );
    }
    return ElevatedButton(
      key: key,
      onPressed: disabled || loading ? null : onPressed,
      style: _style,
      child: _child,
    );
  }

  Widget get _child {
    if (loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
        children: [
          SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _textColor,
            ),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: _align,
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (prefixIcon != null)
          Icon(
            prefixIcon,
            color: _textColor,
            size: _iconSize,
          ),
        if (prefixIcon != null) const SizedBox(width: Spacing.x2),
        Text(
          _text,
          style: TextStyle(
            fontSize: _textSize,
            color: _textColor,
            fontWeight: _theme.buttonFontWeight ?? FontWeight.bold,
            fontFamily: _theme.buttonFontFamily,
          ),
        ),
        if (suffixIcon != null) const SizedBox(width: Spacing.x2),
        if (suffixIcon != null)
          Icon(
            suffixIcon,
            color: _textColor,
            size: _iconSize,
          ),
      ],
    );
  }

  String get _text {
    ButtonTextFormat format = ButtonTextFormat.none;
    if (textFormat != null) {
      format = textFormat!;
    } else if (_theme.buttonTextFormat != null) {
      format = _theme.buttonTextFormat!;
    }
    switch (format) {
      case ButtonTextFormat.none:
        return text;
      case ButtonTextFormat.lowercase:
        return text.toLowerCase();
      case ButtonTextFormat.uppercase:
        return text.toUpperCase();
      case ButtonTextFormat.capitalize:
        return _capitalizeWords(text);
    }
  }

  String _capitalizeWords(String input) {
    return input.split(" ").map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return '';
    }).join(" ");
  }

  ButtonStyle get _style {
    Map<FButtonType, MaterialStateProperty<OutlinedBorder>> shape = {
      FButtonType.text: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: _theme.buttonBorderRadius,
        ),
      ),
      FButtonType.contained: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: _theme.buttonBorderRadius,
        ),
      ),
      FButtonType.outlined: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: _theme.buttonBorderRadius,
          side: BorderSide(
            width: 6,
            color: _borderColor,
          ),
        ),
      ),
      FButtonType.toggle: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: _theme.buttonBorderRadius,
        ),
      ),
    };
    ButtonStyle defStyle = ButtonStyle(
      shape: shape[type] ??
          MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: _theme.buttonBorderRadius,
            ),
          ),
      backgroundColor: MaterialStateProperty.all<Color>(_backgroundColor),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(_padding),
      shadowColor: type == FButtonType.text
          ? MaterialStateProperty.all<Color>(Colors.transparent)
          : null,
      overlayColor: type == FButtonType.text
          ? MaterialStateProperty.resolveWith(
              (states) {
                return states.contains(MaterialState.pressed)
                    ? _textColor.withOpacity(0.1)
                    : null;
              },
            )
          : null,
    );
    return defStyle;
  }

  MainAxisAlignment get _align {
    Map<FButtonAlign, MainAxisAlignment> alignment = {
      FButtonAlign.left: MainAxisAlignment.start,
      FButtonAlign.center: MainAxisAlignment.center,
      FButtonAlign.right: MainAxisAlignment.end,
    };
    return alignment[align] ?? MainAxisAlignment.center;
  }

  Color get _backgroundColor {
    Map<ThemeColor, Color> backgroundColor = {
      ThemeColor.primary: _theme.primaryColor,
      ThemeColor.secondary: _theme.secondaryColor,
      ThemeColor.success: _theme.successColor,
      ThemeColor.danger: _theme.dangerColor,
      ThemeColor.warning: _theme.warningColor,
      ThemeColor.info: _theme.infoColor,
      ThemeColor.light: _theme.lightColor,
      ThemeColor.dark: _theme.darkColor,
    };

    if (type == FButtonType.outlined || type == FButtonType.text) {
      return Colors.transparent;
    }
    if (disabled) {
      return _theme.buttonDisabledColor;
    }
    return backgroundColor[color] ?? _theme.primaryColor;
  }

  Color get _borderColor {
    Map<ThemeColor, Color> backgroundColor = {
      ThemeColor.primary: _theme.primaryColor,
      ThemeColor.secondary: _theme.secondaryColor,
      ThemeColor.success: _theme.successColor,
      ThemeColor.danger: _theme.dangerColor,
      ThemeColor.warning: _theme.warningColor,
      ThemeColor.info: _theme.infoColor,
      ThemeColor.light: _theme.lightColor,
      ThemeColor.dark: _theme.darkColor,
    };
    if (disabled) {
      return _theme.buttonDisabledColor;
    }
    return backgroundColor[color] ?? _theme.primaryColor;
  }

  Color get _textColor {
    Map<ThemeColor, Color> textColor = {
      ThemeColor.primary: _theme.primaryTextColor,
      ThemeColor.secondary: _theme.secondaryTextColor,
      ThemeColor.success: _theme.successTextColor,
      ThemeColor.danger: _theme.dangerTextColor,
      ThemeColor.warning: _theme.warningTextColor,
      ThemeColor.info: _theme.infoTextColor,
      ThemeColor.light: _theme.lightTextColor,
      ThemeColor.dark: _theme.darkTextColor,
    };

    if (disabled) {
      return _theme.buttonDisabledTextColor.withOpacity(0.8);
    }

    if (type == FButtonType.outlined || type == FButtonType.text) {
      textColor = {
        ThemeColor.primary: _theme.primaryColor,
        ThemeColor.secondary: _theme.secondaryColor,
        ThemeColor.success: _theme.successColor,
        ThemeColor.danger: _theme.dangerColor,
        ThemeColor.warning: _theme.warningColor,
        ThemeColor.info: _theme.infoColor,
        ThemeColor.light: _theme.lightTextColor,
        ThemeColor.dark: _theme.darkColor,
      };
    }

    return textColor[color] ?? _theme.primaryTextColor;
  }

  double get _textSize {
    Map<FButtonSize, double> textSize = {
      FButtonSize.large: _theme.buttonLargeTextSize,
      FButtonSize.standard: _theme.buttonStandardTextSize,
      FButtonSize.small: _theme.buttonSmallTextSize,
    };

    return textSize[size] ?? _theme.buttonStandardTextSize;
  }

  double get _iconSize {
    Map<FButtonSize, double> iconSize = {
      FButtonSize.large: _theme.buttonLargeIconSize,
      FButtonSize.standard: _theme.buttonStandardIconSize,
      FButtonSize.small: _theme.buttonSmallIconSize,
    };

    return iconSize[size] ?? _theme.buttonStandardIconSize;
  }

  EdgeInsets get _padding {
    Map<FButtonSize, EdgeInsets> padding = {
      FButtonSize.large: _theme.buttonLargeSpacing,
      FButtonSize.standard: _theme.buttonStandardSpacing,
      FButtonSize.small: _theme.buttonSmallSpacing,
    };

    return padding[size] ?? _theme.buttonStandardSpacing;
  }
}
