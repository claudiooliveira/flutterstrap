import 'package:flutterstrap/flutterstrap.dart';
import 'package:flutter/material.dart';

enum FIconButtonType { outlined, contained }

// ignore: must_be_immutable
class FIconButton extends StatelessWidget {
  FIconButton(
    this.icon, {
    Key? key,
    this.onPressed,
    this.color = ThemeColor.primary,
    this.type = FIconButtonType.contained,
    this.size = FButtonSize.standard,
    this.disabled = false,
    this.loading = false,
  }) : super(key: key);

  late FlutterstrapTheme _theme;
  final VoidCallback? onPressed;
  final ThemeColor color;
  final FIconButtonType type;
  final FButtonSize size;
  final IconData icon;
  final bool disabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    _theme = FlutterstrapTheme.of(context);
    if (type == FIconButtonType.outlined) {
      return SizedBox(
        width: _iconSize * 2,
        height: _iconSize * 2,
        child: OutlinedButton(
          key: key,
          onPressed: disabled || loading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            primary: _borderColor,
            backgroundColor: _backgroundColor,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: _theme.buttonBorderRadius,
            ),
            side: BorderSide(
              width: 2,
              color: _borderColor,
            ),
          ),
          child: _child,
        ),
      );
    }
    return SizedBox(
      width: _iconSize * 2,
      height: _iconSize * 2,
      child: ElevatedButton(
        key: key,
        onPressed: disabled || loading ? null : onPressed,
        style: _style,
        child: _child,
      ),
    );
  }

  Widget get _child {
    if (loading) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: _iconColor,
          ),
        ),
      );
    }
    return Center(
      child: Icon(
        icon,
        color: _iconColor,
        size: _iconSize,
      ),
    );
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
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
    );
    return defStyle;
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

    if (type == FIconButtonType.outlined) {
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

  Color get _iconColor {
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

    if (type == FIconButtonType.outlined) {
      textColor = {
        ThemeColor.primary: _theme.primaryColor,
        ThemeColor.secondary: _theme.secondaryColor,
        ThemeColor.success: _theme.successColor,
        ThemeColor.danger: _theme.dangerColor,
        ThemeColor.warning: _theme.warningColor,
        ThemeColor.info: _theme.infoColor,
        ThemeColor.light: _theme.lightColor,
        ThemeColor.dark: _theme.darkColor,
      };
    }

    return textColor[color] ?? _theme.primaryTextColor;
  }

  double get _iconSize {
    Map<FButtonSize, double> iconSize = {
      FButtonSize.large: _theme.buttonLargeIconSize,
      FButtonSize.standard: _theme.buttonStandardIconSize,
      FButtonSize.small: _theme.buttonSmallIconSize,
    };

    return iconSize[size] ?? _theme.buttonStandardIconSize;
  }
}
