import 'package:flutter/material.dart';
import 'package:flutterstrap/flutterstrap.dart';

enum FAlertType {
  info,
  warning,
  error,
  success,
}

class FAlert extends StatelessWidget {
  const FAlert({
    Key? key,
    required this.color,
    required this.backgroundColor,
    required this.type,
    required this.text,
    this.title,
    this.textColor,
  }) : super(key: key);

  final Color color;
  final Color backgroundColor;
  final FAlertType type;
  final String? title;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterstrapTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.cardBorderRadius,
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.x1,
        horizontal: Spacing.x2,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Center(
              child: Icon(
                _icon,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: Spacing.x1),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null && title!.isNotEmpty)
                  Flexible(
                    child: FText.styled(title!),
                  ),
                Flexible(
                  child: FText.styled(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData get _icon {
    Map<FAlertType, IconData> iconMap = {
      FAlertType.info: Icons.info,
      FAlertType.warning: Icons.warning,
      FAlertType.error: Icons.error,
      FAlertType.success: Icons.check,
    };
    return iconMap[type]!;
  }
}
