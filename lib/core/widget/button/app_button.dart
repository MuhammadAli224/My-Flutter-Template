import 'package:flutter/material.dart';

import '../../../../core/utils/border_radius.dart';
import '../../core.dart';
import '../../utils/gradient.dart';
import '../app_widget/app_text.dart';
import 'button_constant.dart';

class AppButton extends StatelessWidget {
  final double height;

  /// Optional fixed width.
  ///
  /// If null, the button will try to take the available parent width.
  final double? width;

  final Color? color;
  final BorderRadius? borderRadius;

  final Widget Function(BuildContext context, bool isFocused, bool isHovered)
  builder;

  final void Function()? onPressed;
  final Border? border;
  final EdgeInsetsGeometry? contentPadding;

  final bool isDestructive;

  /// When true, the button animates into a circle loader.
  final bool isLoading;

  /// If true, button width becomes equal to [height] while loading.
  final bool shrinkOnLoading;

  final Color? loadingColor;
  final double? loadingSize;

  final Duration animationDuration;
  final Curve animationCurve;

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
    this.width,
    this.isLoading = false,
    this.shrinkOnLoading = true,
    this.loadingColor,
    this.loadingSize,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOutCubic,
  });

  factory AppButton.text({
    required String text,
    double height = AppButtonHeights.md,
    double? width,
    required void Function()? onPressed,
    Color? color,
    Color? fontColor,
    EdgeInsetsGeometry? contentPadding,
    double? fontSize,
    bool isDestructive = false,
    bool isLoading = false,
    bool shrinkOnLoading = true,
    Color? loadingColor,
    double? loadingSize,
    BorderRadius? borderRadius,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOutCubic,
    Key? key,
  }) {
    return AppButton(
      key: key,
      borderRadius: borderRadius,
      color: color,
      height: height,
      width: width,
      onPressed: onPressed,
      isDestructive: isDestructive,
      isLoading: isLoading,
      shrinkOnLoading: shrinkOnLoading,
      loadingColor: loadingColor,
      loadingSize: loadingSize,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      contentPadding: contentPadding,
      builder: (_, _, _) => AppText(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor ?? AppColor.white,
          fontSize: fontSize ?? AppButtonTextFontSize.fromButtonHeights(height),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  factory AppButton.transparent({
    required String text,
    double height = AppButtonHeights.sm,
    double? width,
    required void Function()? onPressed,
    Color? fontColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    double? fontSize,
    bool isLoading = false,
    bool shrinkOnLoading = true,
    Color? loadingColor,
    double? loadingSize,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOutCubic,
    Key? key,
  }) {
    return AppButton(
      key: key,
      contentPadding: contentPadding,
      color: Colors.transparent,
      height: height,
      width: width,
      onPressed: onPressed,
      isLoading: isLoading,
      shrinkOnLoading: shrinkOnLoading,
      loadingColor: loadingColor,
      loadingSize: loadingSize,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      border: Border.all(color: borderColor ?? AppColor.white),
      borderRadius: borderRadius,
      builder: (_, _, _) => AppText(
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
    double? width,
    double? fontSize,
    required void Function()? onPressed,
    Color? fontColor,
    Color? borderColor,
    EdgeInsetsGeometry? contentPadding,
    BorderRadius? borderRadius,
    required Widget child,
    bool isLoading = false,
    bool shrinkOnLoading = true,
    Color? loadingColor,
    double? loadingSize,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOutCubic,
    Key? key,
  }) {
    return AppButton(
      key: key,
      color: Colors.transparent,
      height: height,
      width: width,
      onPressed: onPressed,
      contentPadding: contentPadding,
      isLoading: isLoading,
      shrinkOnLoading: shrinkOnLoading,
      loadingColor: loadingColor,
      loadingSize: loadingSize,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      border: Border.all(color: borderColor ?? AppColor.white),
      borderRadius: borderRadius,
      builder: (_, _, _) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          child,
          AppText(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor ?? AppColor.white,
              fontSize:
              fontSize ?? AppButtonTextFontSize.fromButtonHeights(height),
              fontWeight: FontWeight.w500,
            ),
          ),
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
    double? width,
    required void Function()? onPressed,
    Color? color,
    bool isDestructive = false,
    bool isLoading = false,
    bool shrinkOnLoading = true,
    Color? loadingColor,
    double? loadingSize,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOutCubic,
    Key? key,
  }) {
    return AppButton(
      key: key,
      color: color,
      height: height,
      width: width,
      onPressed: onPressed,
      isDestructive: isDestructive,
      isLoading: isLoading,
      shrinkOnLoading: shrinkOnLoading,
      loadingColor: loadingColor,
      loadingSize: loadingSize,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      builder: (_, _, _) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIconAssetName != null) ...[
            Icon(
              leadingIconAssetName,
              color: AppColor.white,
              size: AppButtonIconSize.fromButtonHeights(height),
            ),
            8.gap,
          ],
          AppText(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontSize: AppButtonTextFontSize.fromButtonHeights(height),
              fontWeight: FontWeight.w400,
            ),
          ),
          if (trailingIconAssetName != null) ...[
            8.gap,
            Icon(
              trailingIconAssetName,
              color: AppColor.white,
              size: AppButtonIconSize.fromButtonHeights(height),
            ),
          ],
        ],
      ),
    );
  }

  factory AppButton.iconOnly({
    required IconData iconAssetName,
    double height = AppButtonHeights.md,
    double? width,
    void Function()? onPressed,
    bool isDestructive = false,
    Color? color,
    bool isLoading = false,
    bool shrinkOnLoading = true,
    Color? loadingColor,
    double? loadingSize,
    BorderRadius? borderRadius,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOutCubic,
    Key? key,
  }) {
    return AppButton(
      key: key,
      height: height,
      width: width,
      onPressed: onPressed,
      color: color,
      isDestructive: isDestructive,
      isLoading: isLoading,
      shrinkOnLoading: shrinkOnLoading,
      loadingColor: loadingColor,
      loadingSize: loadingSize,
      borderRadius: borderRadius,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
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
    final normalBorderRadius =
        borderRadius ?? BorderRadius.circular(AppBorderRadius.xl50);

    final loadingBorderRadius = BorderRadius.circular(height / 2);

    final isDisabled = onPressed == null || isLoading;

    final effectiveBorderRadius =
    isLoading && shrinkOnLoading ? loadingBorderRadius : normalBorderRadius;

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentMaxWidth = constraints.maxWidth;

        final hasBoundedWidth = parentMaxWidth.isFinite;

        final normalWidth = width ?? (hasBoundedWidth ? parentMaxWidth : null);

        final loadingWidth = shrinkOnLoading ? height : normalWidth;

        final effectiveWidth = isLoading ? loadingWidth : normalWidth;

        return Align(
          alignment: Alignment.center,
          widthFactor: normalWidth == null ? 1 : null,
          child: AnimatedContainer(
            duration: animationDuration,
            curve: animationCurve,
            width: effectiveWidth,
            height: height,
            decoration: BoxDecoration(
              gradient: color == null ? AppGradient.green : null,
              color: color,
              border: border,
              borderRadius: effectiveBorderRadius,
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              color: Colors.transparent,
              borderRadius: effectiveBorderRadius,
              child: InkWell(
                borderRadius: effectiveBorderRadius,

                /// No need to pass:
                /// onPressed: isLoading ? null : () {}
                ///
                /// The button handles this internally.
                onTap: isDisabled ? null : onPressed,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: isLoading
                        ? SizedBox(
                      key: const ValueKey('app-button-loader'),
                      width: loadingSize ?? _loaderSize,
                      height: loadingSize ?? _loaderSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          loadingColor ?? AppColor.white,
                        ),
                      ),
                    )
                        : Padding(
                      key: const ValueKey('app-button-content'),
                      padding: contentPadding ??
                          AppButtonPadding.fromButtonHeights(height),
                      child: builder(context, true, true),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double get _loaderSize {
    if (height <= AppButtonHeights.sm) return 16;
    if (height <= AppButtonHeights.md) return 18;
    return 22;
  }
}