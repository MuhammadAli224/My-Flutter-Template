import 'package:flutter/material.dart';

abstract class AppColor {
  AppColor._();

  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static Color red200 = Colors.red.shade200;
  static Color red600 = Colors.red.shade600;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // static Color tealCard = const Color(0xcb5df3e5);

  // static const Color primaryColor = Color(0xff39559F);
  static const Color primaryColor = Color(0xFF002754);
  static const Color secondaryColor = Color(0xFF00A665);
  static const Color backgroundColor = Color(0xFFFCFCFB);

  static const Color primaryColor200 = Color(0xff6a80b9);
  static const Color primaryColor600 = Color(0xff8495be);
}
