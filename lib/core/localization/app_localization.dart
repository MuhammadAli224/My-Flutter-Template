import 'package:flutter/material.dart';

class AppLocalization {
  AppLocalization._();

  static const translationsPath = 'assets/translations';
  static const supportedLocales = [Locale('en'), Locale('ar')];
  static const startLocale = Locale('ar');
  static const fallbackLocale = Locale('ar');
  static const saveLocale = true;
}
