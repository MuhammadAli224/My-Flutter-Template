import 'package:flutter/material.dart';

import '../app_widget/app_text.dart';

import '../../utils/text_style.dart';

class AppSwitchTile extends StatelessWidget {
  final String title;

  // final String subTitle;
  final bool isActive;
  final void Function()? onTap;
  final void Function(bool)? onChanged;

  const AppSwitchTile({
    super.key,
    required this.title,
    // required this.subTitle,
    required this.isActive,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppText(
            autoSize: true,
            title,
            minFontSize: 8,
            maxFontSize: 16,
            style: AppTextStyle.style16,
          ),
        ),
        onChanged == null
            ? const SizedBox.shrink()
            : Switch(value: isActive, onChanged: onChanged),
      ],
    );
  }
}
