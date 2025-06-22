import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../context/global.dart';
import '../utils/text_style.dart';

enum BarType { snackbar, materialBanner }

void showBar(
    {required String title,
    required String message,
    required BarContentType contentType,
    BarType barType = BarType.snackbar,
    List<Widget>? actions}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.style22B),
        AutoSizeText(message, style: AppTextStyle.style14),
      ],
    );

    ScaffoldMessenger.of(GlobalContext.context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(
        SnackBar(
          backgroundColor: contentType.color,
          content: content,
        ),
      );
  });
}

class BarContentType {
  final String message;

  final Color? color;

  const BarContentType(this.message, [this.color]);

  static const BarContentType help =
      BarContentType('help', DefaultColors.helpBlue);
  static const BarContentType failure =
      BarContentType('failure', DefaultColors.failureRed);
  static const BarContentType success =
      BarContentType('success', DefaultColors.successGreen);
  static const BarContentType warning =
      BarContentType('warning', DefaultColors.warningYellow);
}

class DefaultColors {
  /// help
  static const Color helpBlue = Color(0xff3282B8);

  /// failure
  static const Color failureRed = Color(0xffc72c41);

  /// success
  static const Color successGreen = Color(0xff2D6A4F);

  /// warning
  static const Color warningYellow = Color(0xffFCA652);
}
