import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utils/text_style.dart';

class AppSwitchTile extends StatelessWidget {
  final String title;

  // final String subTitle;
  final bool isActive;
  final void Function()? onTap;
  final void Function(bool)? onChanged;

  const AppSwitchTile(
      {super.key,
      required this.title,
      // required this.subTitle,
      required this.isActive,
      this.onTap,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: AutoSizeText(title,
                minFontSize: 8, maxFontSize: 16, style: AppTextStyle.style16)),
        onChanged == null
            ? const SizedBox.shrink()
            : Switch(
                value: isActive,
                onChanged: onChanged,
              ),
      ],
    );
  }
}
