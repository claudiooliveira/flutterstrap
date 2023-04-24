import 'package:flutter/material.dart';

import '../../flutterstrap.dart';

class FDropdownFieldItem<T> {
  const FDropdownFieldItem({
    required this.text,
    required this.value,
  });
  final String text;
  final T value;
}

// ignore: must_be_immutable
class FDropdownField extends StatelessWidget {
  FDropdownField({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    this.hintText,
    this.labelText,
  }) : super(key: key);

  final List<FDropdownFieldItem> items;
  final dynamic selectedValue;
  final void Function(dynamic)? onChanged;
  final String? hintText;
  final String? labelText;

  late FlutterstrapTheme _theme;

  @override
  Widget build(BuildContext context) {
    _theme = FlutterstrapTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) _fixedLabelText,
        if (labelText != null) const SizedBox(height: Spacing.x1),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<dynamic>(
            decoration: InputDecoration(
              contentPadding: _theme.textInputContentPadding,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _theme.textInputBorderColor,
                  width: _theme.textInputBorderWidth,
                ),
                borderRadius: _theme.textInputBorderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _theme.textInputBorderColor,
                  width: _theme.textInputBorderWidth,
                ),
                borderRadius: _theme.textInputBorderRadius,
              ),
            ),
            hint: hintText == null
                ? null
                : FText(
                    hintText!,
                    color: _theme.hintTextColor,
                  ),
            items: items.map((FDropdownFieldItem item) {
              return DropdownMenuItem<dynamic>(
                value: item.value,
                child: FText(item.text),
              );
            }).toList(),
            onChanged: onChanged,
            value: selectedValue,
          ),
        ),
      ],
    );
  }

  Widget get _fixedLabelText {
    return Text(
      labelText!,
      style: TextStyle(
        fontSize: _theme.fixedLabelTextSize,
        fontWeight: _theme.fixedLabelTextFontWeight,
        fontFamily: _theme.fixedLabelTextFontFamily,
        color: _theme.fixedLabelTextColor,
      ),
    );
  }
}
