import 'package:flutter/material.dart';

import '../../../../core/utils/border_radius.dart';
import '../../core.dart';
import '../../utils/gradient.dart';
import 'button_constant.dart';

class AppButton extends StatelessWidget {
  final double height;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget Function(BuildContext context, bool isFocused, bool isHovered)
  builder;
  final void Function()? onPressed;
  final Border? border;
  final EdgeInsetsGeometry? contentPadding;

  final bool isDestructive;

  const AppButton({
    super.key,
    required this.height,
    required this.builder,
    this.onPressed,
    this.contentPadding,
    required this.isDestructive,
    this.color,
    this.borderRadius,
    this.border,
  });

  factory AppButton.text({
    required String text,
    double height = AppButtonHeights.md,
    required void Function()? onPressed,
    Color? color,
    Color? fontColor,
    EdgeInsetsGeometry? contentPadding,
    double? fontSize,

    bool isDestructive = false,
    BorderRadius? borderRadius,
    Key? key,
  }) {
    return AppButton(
      key: key,
      borderRadius: borderRadius,
      color: color,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      contentPadding: contentPadding,
      builder: (_, _, _) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor ?? AppColor.white,
          fontSize: fontSize??AppButtonTextFontSize.fromButtonHeights(height),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  factory AppButton.transparent({
    required String text,
    double height = AppButtonHeights.sm,
    required void Function()? onPressed,
    Color? fontColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    double? fontSize,
    Key? key,
  }) {
    return AppButton(
      key: key,
      contentPadding: contentPadding,
      color: Colors.transparent,
      height: height,
      onPressed: onPressed,
      border: Border.all(color: borderColor ?? AppColor.white),
      borderRadius: borderRadius,
      builder: (_, _, _) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor ?? AppColor.white,
          fontSize: fontSize ?? AppButtonTextFontSize.fromButtonHeights(height),
          fontWeight: FontWeight.w500,
        ),
      ),
      isDestructive: false,
    );
  }

  factory AppButton.transparentWithWidget({
    required String text,
    double height = AppButtonHeights.sm,
    double? fontSize,
    required void Function()? onPressed,
    Color? fontColor,
    Color? borderColor,
    EdgeInsetsGeometry? contentPadding,
    BorderRadius? borderRadius,
    required Widget child,
    Key? key,
  }) {
    return AppButton(
      key: key,
      color: Colors.transparent,
      height: height,
      onPressed: onPressed,
      contentPadding: contentPadding,
      border: Border.all(color: borderColor ?? AppColor.white),
      borderRadius: borderRadius,
      builder: (_, _, _) => Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        spacing: 5,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor ?? AppColor.white,
              fontSize:
              fontSize ?? AppButtonTextFontSize.fromButtonHeights(height),
              fontWeight: FontWeight.w500,
            ),
          ),
          child,
        ],
      ),
      isDestructive: false,
    );
  }

  factory AppButton.icon({
    required String text,
    IconData? leadingIconAssetName,
    IconData? trailingIconAssetName,
    double height = AppButtonHeights.lg,
    required void Function()? onPressed,
    Color? color,
    bool isDestructive = false,
    Key? key,
  }) {
    return AppButton(
      key: key,
      color: color,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      builder: (_, _, _) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIconAssetName != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  leadingIconAssetName,
                  color: AppColor.white,
                  size: AppButtonIconSize.fromButtonHeights(height),
                ),
                8.gap,
              ],
            ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontSize: AppButtonTextFontSize.fromButtonHeights(height),
              fontWeight: FontWeight.w400,
            ),
          ),
          if (trailingIconAssetName != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.gap,
                Icon(
                  trailingIconAssetName,
                  color: AppColor.white,
                  size: AppButtonIconSize.fromButtonHeights(height),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// Creates [AppButton] with only an icon as content.
  factory AppButton.iconOnly({
    required IconData iconAssetName,
    double height = AppButtonHeights.md,
    void Function()? onPressed,
    bool isDestructive = false,
    Color? color,
    Key? key,
  }) {
    return AppButton(
      key: key,
      height: height,
      onPressed: onPressed,
      color: color,
      isDestructive: isDestructive,
      contentPadding: AppButtonIconOnlyPadding.fromButtonHeights(height),
      builder: (_, _, _) => Icon(
        iconAssetName,
        color: AppColor.white,
        size: AppButtonIconSize.fromButtonHeights(height),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: color == null ? AppGradient.green : null,
        border: border,
        borderRadius:
        borderRadius ?? BorderRadius.circular(AppBorderRadius.xl50),
      ),
      child: InkWell(
        borderRadius:
        borderRadius ?? BorderRadius.circular(AppBorderRadius.xl50),

        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
            borderRadius ?? BorderRadius.circular(AppBorderRadius.xl50),
          ),
          child: Padding(
            padding:
            contentPadding ?? AppButtonPadding.fromButtonHeights(height),
            child: builder(context, true, true),
          ),
        ),
      ),
    );
  }
}
