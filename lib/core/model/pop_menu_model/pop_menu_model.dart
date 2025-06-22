import 'package:flutter/cupertino.dart';

class AppPopMenuItemModel {
  String title;
  void Function()? onTap;
  bool enabled;

  IconData? leading;
  Color? leadingColor;

  AppPopMenuItemModel({
    required this.title,
    this.leading,
    this.enabled = true,
    required this.onTap,
    this.leadingColor,
  });
}
