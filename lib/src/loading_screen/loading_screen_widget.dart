import 'package:flutterstrap/flutterstrap.dart';
import 'package:flutter/material.dart';

class FLoadingScreenWidget extends StatelessWidget {
  const FLoadingScreenWidget({
    Key? key,
    required this.isLoading,
    required this.child,
    this.backgroundColor,
    this.strokeWidth,
    this.loadingWidget,
  }) : super(key: key);

  final bool isLoading;
  final Color? backgroundColor;
  final double? strokeWidth;
  final Widget? loadingWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterstrapTheme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(children: [
        child,
        if (isLoading)
          Align(
            alignment: Alignment.center,
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.white.withOpacity(0.7),
              ),
              child: Center(
                child: loadingWidget ??
                    SizedBox(
                      width: 42,
                      height: 42,
                      child: CircularProgressIndicator(
                        strokeWidth: strokeWidth ?? 5,
                        color: theme.primaryColor,
                      ),
                    ),
              ),
            ),
          ),
      ]);
    });
  }
}
