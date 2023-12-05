import 'package:flutter/services.dart';
import 'package:flutterstrap/flutterstrap.dart';
import 'package:flutter/material.dart';

enum FTextFieldStyle { outlined, underlined, none }

enum FTextFieldSize { small, standard, large }

enum FTextFieldLabelType { floating, fixedAtTop }

// ignore: must_be_immutable
class FTextField extends StatefulWidget {
  FTextField({
    Key? key,
    this.initialValue,
    this.controller,
    this.hintText,
    this.labelText,
    this.textFieldStyle = FTextFieldStyle.outlined,
    this.filled = false,
    this.fillColor,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.showVisiblePasswordIcon = false,
    this.prefixIcon,
    this.prefixIconTap,
    this.suffixIcon,
    this.suffixIconTap,
    this.validator,
    this.textFieldValidator,
    this.autovalidateMode,
    this.labelType = FTextFieldLabelType.floating,
    this.bottomLabel,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.enabled,
    this.enableInteractiveSelection,
    this.textInputAction,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  final String? initialValue;
  final TextEditingController? controller;
  final FTextFieldStyle textFieldStyle;
  String? hintText;
  String? labelText;
  FTextFieldLabelType labelType;
  bool? filled;
  Color? fillColor;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  bool obscureText;
  bool showVisiblePasswordIcon;
  IconData? prefixIcon;
  VoidCallback? prefixIconTap;
  IconData? suffixIcon;
  VoidCallback? suffixIconTap;
  String? Function(String?)? validator;
  String? bottomLabel;
  AutovalidateMode? autovalidateMode;
  int? minLines;
  int maxLines;
  Function()? onTap;
  bool? enabled;
  bool? enableInteractiveSelection;
  TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters;
  void Function(String)? onChanged;

  /// Use a [TextFieldValidator] to validate this field.
  /// -
  /// Note: if `validator` property is not null
  /// the `textFieldValidator` will be ignored
  TextFieldValidator? textFieldValidator;

  @override
  State<FTextField> createState() => _FTextFieldState();
}

class _FTextFieldState extends State<FTextField> {
  late FlutterstrapTheme _theme;
  bool _visiblePassword = false;
  bool _showBottomLabel = true;

  @override
  Widget build(BuildContext context) {
    _theme = FlutterstrapTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_hasFixedLabelAtTop) _fixedLabelText,
        if (_hasFixedLabelAtTop) const SizedBox(height: Spacing.x1),
        TextFormField(
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          initialValue: widget.initialValue,
          controller: widget.controller,
          decoration: _decoration,
          obscureText: _obscureText,
          style: _textStyle,
          validator: _validator,
          autovalidateMode: widget.autovalidateMode,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          onTap: widget.onTap,
          enabled: widget.enabled,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
        ),
        if (_showBottomLabel && widget.bottomLabel != null)
          const SizedBox(height: 4),
        if (_showBottomLabel && widget.bottomLabel != null)
          FText(widget.bottomLabel!, variant: FTextVariant.caption),
      ],
    );
  }

  String? _validator(String? value) {
    String? message;
    if (widget.validator != null) {
      message = widget.validator!.call(value);
    } else if (widget.textFieldValidator != null) {
      message = widget.textFieldValidator!.validate(value);
    }
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _showBottomLabel = message == null && widget.bottomLabel != null;
      }),
    );

    return message;
  }

  bool get _hasFixedLabelAtTop =>
      widget.labelText != null &&
      widget.labelType == FTextFieldLabelType.fixedAtTop;

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

  InputDecoration? get _decoration {
    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: _hintTextStyle,
      labelText: !_hasFixedLabelAtTop ? widget.labelText : null,
      labelStyle: _labelTextStyle,
      filled: _theme.textInputFillColor != null ? true : widget.filled,
      fillColor: widget.fillColor ?? _theme.textInputFillColor,
      border: _border,
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
      prefixIcon: _prefixIcon,
      prefixIconColor: _getColor,
      suffixIcon: _suffixIcon,
      suffixIconColor: _getColor,
      contentPadding: _theme.textInputContentPadding,
      errorStyle: _errorTextStyle,
      errorBorder: _errorBorder,
      floatingLabelStyle: TextStyle(
        fontSize: _theme.labelTextSize,
        fontWeight: _theme.labelTextFontWeight,
        fontFamily: _theme.labelTextFontFamily,
        color: _theme.textInputFocusedBorderColor,
      ),
      errorMaxLines: 5,
    );
  }

  Color get _getColor =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        Color color = _theme.textInputBorderColor;
        if (states.contains(MaterialState.error)) {
          color = _theme.textInputErrorColor;
        } else if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) {
          color = _theme.textInputFocusedBorderColor;
        }
        return color;
      });

  bool get _isPasswordField =>
      widget.obscureText == true && widget.showVisiblePasswordIcon;

  bool get _obscureText {
    if (_isPasswordField) {
      return !_visiblePassword;
    }
    return widget.obscureText;
  }

  Widget? get _prefixIcon => (widget.prefixIcon == null
      ? null
      : Padding(
          padding: const EdgeInsets.only(right: Spacing.x1),
          child: ClipOval(
            child: Material(
              shape: const CircleBorder(),
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  widget.prefixIcon,
                  size: 24,
                ),
                onPressed: widget.prefixIconTap,
              ),
            ),
          ),
        ));

  Widget? get _suffixIcon {
    IconData? icon = widget.suffixIcon;

    if (_isPasswordField) {
      icon = _visiblePassword ? Icons.visibility_off : Icons.visibility;
    }
    return Padding(
      padding: const EdgeInsets.only(right: Spacing.x1),
      child: ClipOval(
        child: Material(
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(
              icon,
              size: 24,
            ),
            onPressed: !_isPasswordField
                ? widget.suffixIconTap
                : () {
                    setState(() {
                      _visiblePassword = !_visiblePassword;
                    });
                  },
          ),
        ),
      ),
    );
  }

  InputBorder? get _border {
    Map<FTextFieldStyle, InputBorder> border = {
      FTextFieldStyle.outlined: OutlineInputBorder(
        borderSide: BorderSide(
          color: _theme.textInputBorderColor,
          width: _theme.textInputBorderWidth,
        ),
        borderRadius: _theme.textInputBorderRadius,
      ),
      FTextFieldStyle.underlined: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _theme.textInputBorderColor,
          width: _theme.textInputBorderWidth,
        ),
      ),
      FTextFieldStyle.none: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: _theme.textInputBorderRadius,
      ),
    };
    return border[widget.textFieldStyle]!;
  }

  InputBorder? get _enabledBorder {
    Map<FTextFieldStyle, InputBorder> border = {
      FTextFieldStyle.outlined: OutlineInputBorder(
        borderSide: BorderSide(
          color: _theme.textInputEnabledBorderColor,
          width: _theme.textInputBorderWidth,
        ),
        borderRadius: _theme.textInputBorderRadius,
      ),
      FTextFieldStyle.underlined: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _theme.textInputEnabledBorderColor,
          width: _theme.textInputBorderWidth,
        ),
      ),
      FTextFieldStyle.none: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: _theme.textInputBorderRadius,
      ),
    };
    return border[widget.textFieldStyle]!;
  }

  InputBorder? get _focusedBorder {
    Map<FTextFieldStyle, InputBorder> border = {
      FTextFieldStyle.outlined: OutlineInputBorder(
        borderSide: BorderSide(
          color: _theme.textInputFocusedBorderColor,
          width: _theme.textInputBorderWidth,
        ),
        borderRadius: _theme.textInputBorderRadius,
      ),
      FTextFieldStyle.underlined: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _theme.textInputFocusedBorderColor,
          width: _theme.textInputBorderWidth,
        ),
      ),
      FTextFieldStyle.none: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: _theme.textInputBorderRadius,
      ),
    };
    return border[widget.textFieldStyle]!;
  }

  InputBorder? get _errorBorder {
    Map<FTextFieldStyle, InputBorder> border = {
      FTextFieldStyle.outlined: OutlineInputBorder(
        borderSide: BorderSide(
          color: _theme.textInputErrorColor,
          width: _theme.textInputBorderWidth,
        ),
        borderRadius: _theme.textInputBorderRadius,
      ),
      FTextFieldStyle.underlined: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _theme.textInputErrorColor,
          width: _theme.textInputBorderWidth,
        ),
      ),
      FTextFieldStyle.none: InputBorder.none,
    };
    return border[widget.textFieldStyle]!;
  }

  TextStyle? get _textStyle {
    return TextStyle(
      fontSize: _theme.textInputFontSize,
      fontWeight: _theme.textInputFontWeight,
      fontFamily: _theme.textInputFontFamily,
      color: _theme.textInputColor,
    );
  }

  TextStyle? get _hintTextStyle {
    return TextStyle(
      fontSize: _theme.hintTextSize,
      fontWeight: _theme.hintTextFontWeight,
      fontFamily: _theme.hintTextFontFamily,
      color: _theme.hintTextColor,
    );
  }

  TextStyle? get _labelTextStyle {
    return TextStyle(
      fontSize: _theme.labelTextSize,
      fontWeight: _theme.labelTextFontWeight,
      fontFamily: _theme.labelTextFontFamily,
      color: _theme.labelTextColor,
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
}

extension FPasswordTextField on FTextField {
  FTextField password() {
    return FTextField(
      key: key,
      initialValue: initialValue,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      textFieldStyle: textFieldStyle,
      filled: filled,
      fillColor: fillColor,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: true,
      showVisiblePasswordIcon: true,
      suffixIcon: suffixIcon,
      validator: validator,
      textFieldValidator: textFieldValidator,
      autovalidateMode: autovalidateMode,
      labelType: labelType,
      bottomLabel: bottomLabel,
      onTap: onTap,
      enabled: enabled,
      enableInteractiveSelection: enableInteractiveSelection,
      textInputAction: textInputAction,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
    );
  }
}
