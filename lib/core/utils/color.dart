import 'package:flutter/material.dart';

abstract class AppColor {
  AppColor._();

  static const Color primaryColor = Color(0xFF002754);
  static const Color secondaryColor = Color(0xFF00A665);
  static const Color backgroundColor = Color(0xFFFCFCFB);

  static const Color primaryColor100 = Color(0xFFE6ECF3);
  static const Color primaryColor200 = Color(0xFF6A80B9);
  static const Color primaryColor600 = Color(0xFF001B3B);
  static const Color secondaryColor100 = Color(0xFFE3F6EF);
  static const Color secondaryColor600 = Color(0xFF018355);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF242424);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF0E8F55);
  static const Color warning = Color(0xFFF2B705);
  static const Color border = Color(0xFFD7DEE8);
  static const Color disabled = Color(0xFFB8C0CC);
  static const Color textMuted = Color(0xFF687385);

  static const Color red = error;
  static const Color green = success;
  static const Color red200 = Color(0xFFFFDAD6);
  static const Color red600 = Color(0xFF93000A);
}
