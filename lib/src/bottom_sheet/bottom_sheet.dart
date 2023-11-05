import 'package:flutter/material.dart';
import 'package:flutterstrap/flutterstrap.dart';

class FBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? body,
    TextAlign? messageTextAlign = TextAlign.center,
    TextAlign? titleTextAlign = TextAlign.start,
    bool? closeButton = false,
    bool? isDismissible,
    String? primaryButtonText,
    VoidCallback? onPrimaryButtonTap,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonTap,
    bool? resizeToAvoidBottomInset = true,
    CrossAxisAlignment? crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.center,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible ?? true,
      builder: (context) {
        return _FBottomSheetWidget<T>(
          title: title,
          message: message,
          body: body,
          closeButton: closeButton,
          primaryButtonText: primaryButtonText,
          onPrimaryButtonTap: onPrimaryButtonTap,
          secondaryButtonText: secondaryButtonText,
          onSecondaryButtonTap: onSecondaryButtonTap,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          messageTextAlign: messageTextAlign,
          titleTextAlign: titleTextAlign,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        );
      },
    );
  }

  static Future<T?> showIconDialog<T>({
    required BuildContext context,
    required String title,
    required Widget icon,
    String? message,
    TextAlign? messageTextAlign = TextAlign.center,
    TextAlign? titleTextAlign = TextAlign.start,
    bool? closeButton = false,
    bool? isDismissible,
    String? primaryButtonText,
    VoidCallback? onPrimaryButtonTap,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonTap,
    CrossAxisAlignment? crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.start,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible ?? true,
      isScrollControlled: isScrollControlled,
      builder: (context) {
        return _FBottomSheetIconDialogWidget<T>(
          title: title,
          icon: icon,
          message: message,
          closeButton: closeButton,
          primaryButtonText: primaryButtonText,
          onPrimaryButtonTap: onPrimaryButtonTap,
          secondaryButtonText: secondaryButtonText,
          onSecondaryButtonTap: onSecondaryButtonTap,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          messageTextAlign: messageTextAlign,
          titleTextAlign: titleTextAlign,
        );
      },
    );
  }

  static Future<T?> showCustom<T>({
    required BuildContext context,
    required String title,
    Widget? body,
    TextAlign? messageTextAlign = TextAlign.center,
    TextAlign? titleTextAlign = TextAlign.start,
    bool? closeButton = true,
    bool? resizeToAvoidBottomInset = true,
    bool? isDismissible,
    String? primaryButtonText,
    VoidCallback? onPrimaryButtonTap,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonTap,
    CrossAxisAlignment? crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.center,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible ?? true,
      isScrollControlled: isScrollControlled,
      builder: (context) {
        return _FBottomSheetWidget<T>(
          title: title,
          body: body,
          closeButton: closeButton,
          primaryButtonText: primaryButtonText,
          onPrimaryButtonTap: onPrimaryButtonTap,
          secondaryButtonText: secondaryButtonText,
          onSecondaryButtonTap: onSecondaryButtonTap,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          messageTextAlign: messageTextAlign,
          titleTextAlign: messageTextAlign,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        );
      },
    );
  }
}

class _FBottomSheetWidget<T> extends StatelessWidget {
  const _FBottomSheetWidget({
    Key? key,
    required this.title,
    this.message,
    this.body,
    this.closeButton = false,
    this.primaryButtonText,
    this.onPrimaryButtonTap,
    this.secondaryButtonText,
    this.onSecondaryButtonTap,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.messageTextAlign,
    this.titleTextAlign,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  final String title;
  final String? message;
  final Widget? body;
  final bool? closeButton;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryButtonTap;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonTap;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final TextAlign? messageTextAlign;
  final TextAlign? titleTextAlign;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterstrapTheme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: resizeToAvoidBottomInset == true
            ? MediaQuery.of(context).viewInsets.bottom
            : 0,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(Spacing.x4),
          topLeft: Radius.circular(Spacing.x4),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Spacing.x4),
              topLeft: Radius.circular(Spacing.x4),
            ),
          ),
          padding: theme.bottomSheetPadding,
          child: Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      textAlign: titleTextAlign,
                      style: theme.bottomSheetTitleStyle,
                    ),
                  ),
                  if (closeButton == true)
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close_outlined,
                        size: 22,
                        color: theme.defaultIconColor,
                      ),
                    )
                ],
              ),
              const SizedBox(height: Spacing.x4),
              if (message != null)
                Text(
                  message!,
                  textAlign: messageTextAlign,
                  style: theme.bottomSheetMessageStyle,
                ),
              if (body != null) body!,
              const SizedBox(height: Spacing.x4),
              if (primaryButtonText != null)
                FButton(
                  primaryButtonText!,
                  expanded: true,
                  type: theme.bottomSheetPrimaryButtonType,
                  color: theme.bottomSheetPrimaryButtonColor,
                  onPressed: onPrimaryButtonTap,
                ),
              if (secondaryButtonText != null)
                const SizedBox(height: Spacing.x2),
              if (secondaryButtonText != null)
                FButton(
                  secondaryButtonText!,
                  expanded: true,
                  type: theme.bottomSheetSecondaryButtonType,
                  color: theme.bottomSheetSecondaryButtonColor,
                  onPressed: onSecondaryButtonTap,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FBottomSheetIconDialogWidget<T> extends StatelessWidget {
  const _FBottomSheetIconDialogWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.message,
    this.closeButton = false,
    this.primaryButtonText,
    this.onPrimaryButtonTap,
    this.secondaryButtonText,
    this.onSecondaryButtonTap,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.messageTextAlign,
    this.titleTextAlign,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final String? message;
  final bool? closeButton;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryButtonTap;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonTap;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final TextAlign? messageTextAlign;
  final TextAlign? titleTextAlign;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterstrapTheme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(Spacing.x4),
        topLeft: Radius.circular(Spacing.x4),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Spacing.x4),
            topLeft: Radius.circular(Spacing.x4),
          ),
        ),
        padding: theme.bottomSheetPadding,
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: Spacing.x8),
            Flexible(
              child: Text(
                title,
                textAlign: titleTextAlign,
                style: theme.bottomSheetTitleStyle,
              ),
            ),
            const SizedBox(height: Spacing.x4),
            if (message != null)
              Text(
                message!,
                textAlign: messageTextAlign,
                style: theme.bottomSheetMessageStyle,
              ),
            const SizedBox(height: Spacing.x4),
            if (primaryButtonText != null)
              FButton(
                primaryButtonText!,
                expanded: true,
                type: theme.bottomSheetPrimaryButtonType,
                color: theme.bottomSheetPrimaryButtonColor,
                onPressed: onPrimaryButtonTap,
              ),
            if (secondaryButtonText != null) const SizedBox(height: Spacing.x2),
            if (secondaryButtonText != null)
              FButton(
                secondaryButtonText!,
                expanded: true,
                type: theme.bottomSheetSecondaryButtonType,
                color: theme.bottomSheetSecondaryButtonColor,
                onPressed: onSecondaryButtonTap,
              ),
          ],
        ),
      ),
    );
  }
}
