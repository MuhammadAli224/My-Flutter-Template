import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// Shared text renderer. Translate UI keys at the call site:
/// AppText(context.tr(LocaleKeys.someText)).
/// Pass user/API content directly so it is not treated as a translation key.
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.style,
    this.fontFamily,
    this.height,
    this.letterSpacing,
    this.textDecoration,
    this.softWrap,
    this.textScaler,
    this.autoSize = false,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
  }) : textSpan = null;

  const AppText.rich(
    InlineSpan span, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.style,
    this.fontFamily,
    this.height,
    this.letterSpacing,
    this.textDecoration,
    this.softWrap,
    this.textScaler,
  }) : text = '',
       textSpan = span,
       autoSize = false,
       minFontSize = 12,
       maxFontSize = double.infinity;

  final String text;
  final InlineSpan? textSpan;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;
  final String? fontFamily;
  final double? height;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final bool? softWrap;
  final TextScaler? textScaler;
  final bool autoSize;
  final double minFontSize;
  final double maxFontSize;

  @override
  Widget build(BuildContext context) {
    final themeStyle =
        Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    final inheritedStyle = DefaultTextStyle.of(context).style;
    final effectiveStyle = themeStyle
        .merge(inheritedStyle)
        .merge(style)
        .copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: fontFamily,
          height: height,
          letterSpacing: letterSpacing,
          decoration: textDecoration,
        );

    if (textSpan != null) {
      return Text.rich(
        textSpan!,
        style: effectiveStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        textScaler: textScaler,
      );
    }
    if (autoSize) {
      return AutoSizeText(
        text,
        style: effectiveStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        minFontSize: minFontSize,
        maxFontSize: maxFontSize,
        overflow: overflow,
        softWrap: softWrap,
        textScaleFactor: textScaler?.scale(1),
      );
    }
    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaler: textScaler,
    );
  }
}
