import 'package:flutterstrap/flutterstrap.dart';
import 'package:flutter/material.dart';

enum FTextSize { xsmall, small, standard, large }

enum FTextColor { standard, light }

enum FTextVariant {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  subtitle1,
  subtitle2,
  body1,
  body2,
  caption,
  overline,
}

// ignore: must_be_immutable
class FText extends StatelessWidget {
  FText(
    this.text, {
    Key? key,
    this.bold = false,
    this.italic = false,
    this.variant = FTextVariant.body1,
    this.fontFamily,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  final String text;
  final bool bold;
  final bool italic;
  final FTextVariant variant;
  final Color? color;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  late FlutterstrapTheme _theme;

  @override
  Widget build(BuildContext context) {
    _theme = FlutterstrapTheme.of(context);
    return Text(
      key: key,
      text,
      textAlign: textAlign,
      style: style,
      maxLines: maxLines,
    );
  }

  /// Support some HTML tags for styling text:
  /// <b></b> - bold
  /// <i></i> - italic
  /// <u></u> - underline
  /// <font color="#ff0000"></font> - color
  ///
  /// You can combine these tags too!
  /// Enjoy FText.styled!
  factory FText.styled(
    String text, {
    Key? key,
    FTextVariant variant = FTextVariant.body1,
    String? fontFamily,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return _FTextStyled(
      text,
      key: key,
      variant: variant,
      fontFamily: fontFamily,
      color: color,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  TextStyle get style {
    return TextStyle(
      fontFamily: fontFamily ?? _fontFamily,
      fontWeight: bold ? _theme.textBoldWeight : _fontWeight,
      fontSize: _size,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? _theme.textStandardColor,
      overflow: overflow,
    );
  }

  double get _size {
    Map<FTextVariant, double> textVariantSize = {
      FTextVariant.h1: _theme.textH1Size,
      FTextVariant.h2: _theme.textH2Size,
      FTextVariant.h3: _theme.textH3Size,
      FTextVariant.h4: _theme.textH4Size,
      FTextVariant.h5: _theme.textH5Size,
      FTextVariant.h6: _theme.textH6Size,
      FTextVariant.subtitle1: _theme.textSubtitle1Size,
      FTextVariant.subtitle2: _theme.textSubtitle2Size,
      FTextVariant.body1: _theme.textBody1Size,
      FTextVariant.body2: _theme.textBody2Size,
      FTextVariant.caption: _theme.textCaptionSize,
      FTextVariant.overline: _theme.textOverlineSize,
    };

    return textVariantSize[variant]!;
  }

  FontWeight get _fontWeight {
    Map<FTextVariant, FontWeight> textVariantFontWeight = {
      FTextVariant.h1: _theme.textH1FontWeight,
      FTextVariant.h2: _theme.textH2FontWeight,
      FTextVariant.h3: _theme.textH3FontWeight,
      FTextVariant.h4: _theme.textH4FontWeight,
      FTextVariant.h5: _theme.textH5FontWeight,
      FTextVariant.h6: _theme.textH6FontWeight,
      FTextVariant.subtitle1: _theme.textSubtitle1FontWeight,
      FTextVariant.subtitle2: _theme.textSubtitle2FontWeight,
      FTextVariant.body1: _theme.textBody1FontWeight,
      FTextVariant.body2: _theme.textBody2FontWeight,
      FTextVariant.caption: _theme.textCaptionFontWeight,
      FTextVariant.overline: _theme.textOverlineFontWeight,
    };

    return textVariantFontWeight[variant]!;
  }

  String? get _fontFamily {
    Map<FTextVariant, String?> textFontFamilySize = {
      FTextVariant.h1: _theme.textH1FontFamily,
      FTextVariant.h2: _theme.textH2FontFamily,
      FTextVariant.h3: _theme.textH3FontFamily,
      FTextVariant.h4: _theme.textH4FontFamily,
      FTextVariant.h5: _theme.textH5FontFamily,
      FTextVariant.h6: _theme.textH6FontFamily,
      FTextVariant.subtitle1: _theme.textSubtitle1FontFamily,
      FTextVariant.subtitle2: _theme.textSubtitle2FontFamily,
      FTextVariant.body1: _theme.textBody1FontFamily,
      FTextVariant.body2: _theme.textBody2FontFamily,
      FTextVariant.caption: _theme.textCaptionFontFamily,
      FTextVariant.overline: _theme.textOverlineFontFamily,
    };

    return textFontFamilySize[variant] ?? _theme.textFontFamily;
  }
}

// ignore: must_be_immutable
class _FTextStyled extends FText with _FStyledTextMixin {
  _FTextStyled(
    super.text, {
    Key? key,
    super.variant = FTextVariant.body1,
    super.fontFamily,
    super.color,
    super.textAlign,
    super.overflow,
    super.maxLines,
  });
}

// ignore: must_be_immutable
mixin _FStyledTextMixin on FText {
  bool _checkTag(String match, String tag) =>
      match.contains('<$tag') && match.contains('</$tag>');

  String _firstMatch(Match match) => match[0] ?? '';

  String _styledText(Match match) =>
      _firstMatch(match).replaceAll(RegExp(r'<[^>]*>'), '');

  Color? _colorFromText(String text) {
    final pattern =
        RegExp(r'<font\s+color="#([0-9A-Fa-f]{6})">([^<]+)<\/font>');

    final match = pattern.firstMatch(text);
    if (match == null) {
      return null;
    }
    final colorInt = int.parse(match.group(1)!, radix: 16) + 0xFF000000;
    return Color(colorInt);
  }

  List<InlineSpan> textSpans(BuildContext context) {
    final List<InlineSpan> children = [];
    final pattern =
        RegExp(r'\B<([^\s>]+)[^>]*>.*?<\/\1>', caseSensitive: false);
    text.splitMapJoin(
      pattern,
      onMatch: (match) {
        final isBold = _checkTag(_firstMatch(match), 'b');
        final isUnderline = _checkTag(_firstMatch(match), 'u');
        final isItalic = _checkTag(_firstMatch(match), 'i');
        final withColor = _checkTag(_firstMatch(match), 'font') &&
            _firstMatch(match).contains("<font color");

        children.add(
          TextSpan(
            text: _styledText(match),
            style: TextStyle(
              fontFamily: fontFamily ?? _theme.textFontFamily,
              fontWeight: isBold ? _theme.textBoldWeight : _fontWeight,
              fontSize: _size,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              color: (withColor ? _colorFromText(_firstMatch(match)) : null) ??
                  color ??
                  _theme.textStandardColor,
              decoration: isUnderline ? TextDecoration.underline : null,
            ),
          ),
        );
        return _firstMatch(match);
      },
      onNonMatch: (text) {
        children.add(
          TextSpan(
            text: text,
            style: style,
          ),
        );
        return text;
      },
    );

    return children;
  }

  @override
  Widget build(BuildContext context) {
    _theme = FlutterstrapTheme.of(context);
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(
        children: textSpans(context),
      ),
      maxLines: maxLines,
    );
  }
}
