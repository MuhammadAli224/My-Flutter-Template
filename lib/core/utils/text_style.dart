import 'package:flutter/material.dart';

abstract class AppTextStyle extends TextStyle {
  static const String appFontFamily = 'Almarai';

  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: style28B.copyWith(color: color),
      displayMedium: style24B.copyWith(color: color),
      displaySmall: style22B.copyWith(color: color),
      headlineLarge: style24B.copyWith(color: color),
      headlineMedium: style22B.copyWith(color: color),
      headlineSmall: style20B.copyWith(color: color),
      titleLarge: style20B.copyWith(color: color),
      titleMedium: style18B.copyWith(color: color),
      titleSmall: style16B.copyWith(color: color),
      bodyLarge: style16.copyWith(color: color),
      bodyMedium: style14.copyWith(color: color),
      bodySmall: style12.copyWith(color: color),
      labelLarge: style14B.copyWith(color: color),
      labelMedium: style12B.copyWith(color: color),
      labelSmall: style11.copyWith(color: color),
    );
  }

  static const TextStyle style11 = TextStyle(fontSize: 11);
  static const TextStyle style12 = TextStyle(fontSize: 12);
  static const TextStyle style12B = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle style14 = TextStyle(fontSize: 14);
  static const TextStyle style14B = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle style16 = TextStyle(fontSize: 16);
  static const TextStyle style16B = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle style18 = TextStyle(fontSize: 18);
  static const TextStyle style18B = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle style20 = TextStyle(fontSize: 20);
  static const TextStyle style20B = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle style22B = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle style24 = TextStyle(fontSize: 24);
  static const TextStyle style24B = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle style28B = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle style30B = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle style32B = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle style30Black = TextStyle(
    fontSize: 28,
    color: Colors.black,
  );
  static const TextStyle style20Black = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );
}
