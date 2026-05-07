import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/text_style.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _buildTheme(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.backgroundColor,
    surfaceColor: AppColor.surfaceLight,
    onSurfaceColor: AppColor.black,
  );

  static ThemeData get dark => _buildTheme(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.darkBackground,
    surfaceColor: AppColor.darkSurface,
    onSurfaceColor: AppColor.white,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color scaffoldBackgroundColor,
    required Color surfaceColor,
    required Color onSurfaceColor,
  }) {
    final isDark = brightness == Brightness.dark;
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColor.primaryColor,
          brightness: brightness,
        ).copyWith(
          primary: AppColor.primaryColor,
          secondary: AppColor.secondaryColor,
          surface: surfaceColor,
          onPrimary: AppColor.white,
          onSecondary: AppColor.white,
          onSurface: onSurfaceColor,
          error: AppColor.error,
        );

    final textTheme = AppTextStyle.textTheme(colorScheme.onSurface);
    final primaryStateColor = WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.disabled)
          ? AppColor.disabled
          : AppColor.primaryColor,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppTextStyle.appFontFamily,
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: surfaceColor,
      cardColor: isDark ? AppColor.darkCard : AppColor.white,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.white,
          disabledBackgroundColor: AppColor.disabled,
          textStyle: AppTextStyle.style14B,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.primaryColor,
          textStyle: AppTextStyle.style14B,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.primaryColor,
          side: const BorderSide(color: AppColor.primaryColor),
          textStyle: AppTextStyle.style14B,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColor.primaryColor,
        circularTrackColor: AppColor.primaryColor100,
        linearTrackColor: AppColor.primaryColor100,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: primaryStateColor,
        trackColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.selected)
              ? AppColor.primaryColor200
              : AppColor.border,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: primaryStateColor,
        checkColor: const WidgetStatePropertyAll(AppColor.white),
      ),
      radioTheme: RadioThemeData(fillColor: primaryStateColor),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColor.darkCard : AppColor.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: _inputBorder(AppColor.border),
        enabledBorder: _inputBorder(AppColor.border),
        focusedBorder: _inputBorder(AppColor.primaryColor, width: 1.4),
        errorBorder: _inputBorder(AppColor.error),
        focusedErrorBorder: _inputBorder(AppColor.error, width: 1.4),
        labelStyle: AppTextStyle.style14,
        hintStyle: AppTextStyle.style14.copyWith(color: AppColor.textMuted),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.textMuted,
        type: BottomNavigationBarType.fixed,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: AppColor.primaryColor100,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColor.primaryColor
                : AppColor.textMuted,
          ),
        ),
        labelTextStyle: const WidgetStatePropertyAll(AppTextStyle.style12),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
