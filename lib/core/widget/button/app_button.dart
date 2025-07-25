import 'package:flutter/material.dart';

import '../../../../core/extension/space_extension.dart';
import '../../../../core/utils/border_radius.dart';
import '../../../../core/utils/color.dart';
import 'button_constant.dart';

class AppButton extends StatelessWidget {
  final double height;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget Function(BuildContext context, bool isFocused, bool isHovered)
  builder;
  final void Function()? onPressed;

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
  });

  factory AppButton.text({
    required String text,
    double height = AppButtonHeights.md,
    required void Function()? onPressed,
    Color? color,
    Color? fontColor,
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
      builder:
          (_, __, ___) => Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor ?? AppColor.white,
              fontSize: AppButtonTextFontSize.fromButtonHeights(height),
              fontWeight: FontWeight.w500,
            ),
          ),
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
      builder:
          (_, __, ___) => Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leadingIconAssetName != null
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        leadingIconAssetName,
                        color: AppColor.white,
                        size: AppButtonIconSize.fromButtonHeights(height),
                      ),
                      8.gap,
                    ],
                  )
                  : Container(),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: AppButtonTextFontSize.fromButtonHeights(height),
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailingIconAssetName != null
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      8.gap,
                      Icon(
                        trailingIconAssetName,
                        color: AppColor.white,
                        size: AppButtonIconSize.fromButtonHeights(height),
                      ),
                    ],
                  )
                  : Container(),
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
      builder:
          (_, __, ___) => Icon(
            iconAssetName,
            color: AppColor.white,
            size: AppButtonIconSize.fromButtonHeights(height),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late Color primaryColor;
    late Color disabledColor;
    late Color hoverColor;
    late Color focusColor;
    if (!isDestructive) {
      primaryColor = color ?? AppColor.primaryColor;
      disabledColor = AppColor.primaryColor200;
      hoverColor = AppColor.primaryColor600;
      focusColor = AppColor.primaryColor;
    } else {
      primaryColor = color ?? AppColor.primaryColor;
      disabledColor = AppColor.red200;
      hoverColor = AppColor.red600;
      focusColor = AppColor.primaryColor;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppBorderRadius.sm8),
      ),
      child: Material(
        color: onPressed != null ? primaryColor : disabledColor,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppBorderRadius.sm8),
        child: InkWell(
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppBorderRadius.sm8),
          hoverColor: hoverColor,
          focusColor: focusColor,
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  borderRadius ?? BorderRadius.circular(AppBorderRadius.sm8),
            ),
            child: Padding(
              padding:
                  contentPadding ?? AppButtonPadding.fromButtonHeights(height),
              child: builder(context, true, true),
            ),
          ),
        ),
      ),
    );
  }
}
