import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leading;
  final Color? leadingColor;
  final IconData? trailing;
  final void Function()? onTap;
  final TextStyle? titleTextStyle;
  final Widget? trailingWidget;

  const SettingTile(
      {super.key,
      required this.title,
      this.subtitle,
      this.leading,
      this.trailing,
      this.onTap,
      this.titleTextStyle,
      this.trailingWidget,
      this.leadingColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          trailing: trailingWidget ??
              Icon(trailing ?? Icons.arrow_forward_ios_outlined, size: 15.h),
          title: AutoSizeText(title, style: titleTextStyle),
          subtitle: subtitle != null ? AutoSizeText(subtitle!) : null,
          leading: leading != null
              ? HugeIcon(
                  size: 23.h,
                  icon: leading!,
                  color: leadingColor ?? Colors.black)
              : null,
        ),
        const Divider(height: 0),
      ],
    );
  }
}
