import 'package:flutter/material.dart';
import 'package:flutterstrap/flutterstrap.dart';

class FCard extends StatelessWidget {
  const FCard({
    Key? key,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.borderOnForeground = true,
    this.margin,
    this.child,
    this.semanticContainer = true,
  }) : super(key: key);

  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final bool borderOnForeground;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final bool semanticContainer;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterstrapTheme.of(context);
    return Card(
      color: color ?? theme.cardColor,
      shadowColor: shadowColor ?? theme.cardShadowColor,
      surfaceTintColor: surfaceTintColor ?? theme.cardSurfaceTintColor,
      elevation: elevation ?? theme.cardElevation,
      borderOnForeground: borderOnForeground,
      margin: theme.cardMargin ?? margin,
      semanticContainer: semanticContainer,
      shape: RoundedRectangleBorder(
        borderRadius: theme.cardBorderRadius ?? BorderRadius.circular(0),
      ),
      child: (theme.cardPadding != null
          ? Padding(
              padding: theme.cardPadding!,
              child: child,
            )
          : child),
    );
  }
}
