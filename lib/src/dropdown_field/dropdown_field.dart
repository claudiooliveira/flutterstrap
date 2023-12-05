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
class FDropdownField extends StatefulWidget {
  FDropdownField({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    this.hintText,
    this.labelText,
    this.validator,
    this.textFieldValidator,
  }) : super(key: key);

  final List<FDropdownFieldItem> items;
  final dynamic selectedValue;
  final void Function(dynamic)? onChanged;
  final String? hintText;
  final String? labelText;
  final String? Function(dynamic)? validator;
  final TextFieldValidator? textFieldValidator;

  @override
  State<FDropdownField> createState() => _FDropdownFieldState();
}

class _FDropdownFieldState extends State<FDropdownField> {
  late FlutterstrapTheme _theme;

  @override
  Widget build(BuildContext context) {
    _theme = FlutterstrapTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) _fixedLabelText,
        if (widget.labelText != null) const SizedBox(height: Spacing.x1),
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
              errorStyle: _errorTextStyle,
            ),
            validator: _validator,
            hint: widget.hintText == null
                ? null
                : FText(
                    widget.hintText!,
                    color: _theme.hintTextColor,
                  ),
            items: widget.items.map((FDropdownFieldItem item) {
              return DropdownMenuItem<dynamic>(
                value: item.value,
                child: FText(item.text),
              );
            }).toList(),
            onChanged: widget.onChanged,
            value: widget.selectedValue,
          ),
        ),
      ],
    );
  }

  Widget get _fixedLabelText {
    return Text(
      widget.labelText!,
      style: TextStyle(
        fontSize: _theme.fixedLabelTextSize,
        fontWeight: _theme.fixedLabelTextFontWeight,
        fontFamily: _theme.fixedLabelTextFontFamily,
        color: _theme.fixedLabelTextColor,
      ),
    );
  }

  TextStyle? get _errorTextStyle {
    return TextStyle(
      fontSize: _theme.textInputErrorFontSize,
      fontWeight: _theme.textInputErrorFontWeight,
      fontFamily: _theme.textInputErrorFontFamily,
      color: _theme.textInputErrorColor,
    );
  }

  String? _validator(dynamic value) {
    String? message;
    if (widget.validator != null) {
      message = widget.validator!.call(value);
    } else if (widget.textFieldValidator != null) {
      message = widget.textFieldValidator!.validate(value);
    }
    return message;
  }
}
