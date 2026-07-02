import 'package:flutter/material.dart';

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
      });

  final String text;
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
