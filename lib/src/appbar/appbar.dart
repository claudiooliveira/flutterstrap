import 'package:flutter/material.dart';
import 'package:flutterstrap/flutterstrap.dart';

enum FAppBarStyle { standard, inverse }

// ignore: must_be_immutable
class FAppBar extends StatelessWidget implements PreferredSizeWidget {
  FAppBar({
    Key? key,
    this.actions,
    this.title,
    this.leading,
    this.backgroundColor,
    this.style = FAppBarStyle.standard,
    this.elevation,
  }) : super(key: key);

  final List<Widget>? actions;
  final Widget? title;
  final Widget? leading;
  final Color? backgroundColor;
  final FAppBarStyle style;
  final double? elevation;
  late FlutterstrapTheme _theme;

  @override
  Widget build(BuildContext context) {
    _theme = FlutterstrapTheme.of(context);
    return AppBar(
      key: key,
      actions: actions,
      title: _title,
      leading: leading,
      backgroundColor: backgroundColor ?? _backgroundColor,
      elevation: style == FAppBarStyle.inverse ? 0 : elevation,
      iconTheme: style == FAppBarStyle.inverse
          ? IconThemeData(
              color:
                  _theme.appBarInverseTextStyle?.color, //change your color here
            )
          : null,
    );
  }

  Widget? get _title {
    if (title is Text) {
      return Text(
        (title as Text).data!,
        style: _style,
      );
    } else if (title is FText) {
      return Text(
        (title as FText).text,
        style: _style,
      );
    }
    return title;
  }

  Color? get _backgroundColor {
    Map<FAppBarStyle, Color?> backgroundColor = {
      FAppBarStyle.standard: _theme.appBarColor,
      FAppBarStyle.inverse: _theme.appBarInverseColor,
    };

    return backgroundColor[style];
  }

  TextStyle? get _style {
    Map<FAppBarStyle, TextStyle?> appBarStyle = {
      FAppBarStyle.standard: _theme.appBarTextStyle,
      FAppBarStyle.inverse: _theme.appBarInverseTextStyle,
    };

    return appBarStyle[style];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
