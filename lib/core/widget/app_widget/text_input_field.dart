import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/extension/space_extension.dart';
import '../../../core/utils/border.dart';
import '../../../core/utils/color.dart';
import '../../../core/utils/font_size.dart';

class AppTextFormField extends StatelessWidget {
  final String? label;
  final String? labelFloating;
  final String? initialValue;
  final TextStyle? labelTextStyle;
  final TextStyle? labelFloatingTextStyle;
  final String? errorText;
  final String? hintText;
  final String? helperText;
  final List<String>? autoFillHint;
  final IconData? prefixIconAssetName;
  final String? prefixText;
  final String? prefixAddOnText;
  final bool prefixUseMastercard;
  final IconData? suffixIconAssetName;
  final Widget? suffixIconWidget;
  final Color? suffixIconColor;
  final IconData? suffixErrorIconAssetName;
  final VoidCallback? onTapSuffix;
  final bool enabled;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final TextStyle? hintStyle;
  final TextStyle? styleText;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final double? contentVerticalPadding;
  final double? contentHorizontalPadding;
  final int? maxLength;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool clearOnFocus;

  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputBorder? customBorder;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;
  final AutovalidateMode? autoValidateMode;

  const AppTextFormField({
    super.key,
    this.label,
    this.autoFillHint,
    this.errorText,
    this.hintText,
    this.initialValue,
    this.enabled = true,
    this.helperText,
    this.prefixIconAssetName,
    this.prefixText,
    this.prefixAddOnText,
    this.prefixUseMastercard = false,
    this.suffixIconAssetName,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.showCursor,
    this.maxLengthEnforcement,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.maxLines = 1,
    this.obscuringCharacter = '•',
    this.expands = false,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.suffixErrorIconAssetName = CupertinoIcons.info_circle,
    this.onTapSuffix,
    this.autoValidateMode,
    this.suffixIconColor,
    this.labelTextStyle,
    this.contentVerticalPadding,
    this.contentHorizontalPadding,
    this.labelFloating,
    this.labelFloatingTextStyle,
    this.textAlign,
    this.hintStyle,
    this.customBorder,
    this.styleText,
    this.focusNode,
    this.nextFocusNode,
    this.clearOnFocus = false,
    this.suffixIconWidget,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry contentPadding;
    EdgeInsetsGeometry prefixAddOnTextContentPadding;

    contentPadding = EdgeInsets.symmetric(
      vertical: contentVerticalPadding ?? 12.0,
      horizontal: contentHorizontalPadding ?? 14.0,
    );
    prefixAddOnTextContentPadding = const EdgeInsets.symmetric(
      vertical: 14.0,
      horizontal: 14.0,
    );

    Widget? prefixWidget;
    if (prefixText != null) {
      prefixWidget = FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 8.0,
          ),
          child: Center(
            child: Text(
              prefixText!,
            ),
          ),
        ),
      );
    } else if (prefixIconAssetName != null) {
      prefixWidget = FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 8.0,
          ),
          child: Icon(
            prefixIconAssetName!,
            color: AppColor.primaryColor200,
            size: 25.0,
          ),
        ),
      );
    } else if (prefixAddOnText != null) {
      prefixWidget = FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          margin: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: errorText == null
                    ? AppColor.primaryColor200
                    : AppColor.primaryColor200,
              ),
            ),
            // color: Colors.yellow,
          ),
          child: Padding(
            padding: prefixAddOnTextContentPadding,
            child: Center(
              child: Text(
                prefixAddOnText!,
                // style: LibraryTextStyles.interMdRegularNeutral300,
              ),
            ),
          ),
        ),
      );
    }
    if (clearOnFocus) {
      focusNode?.addListener(() {
        if (focusNode!.hasFocus) {
          controller?.clear(); // Clear text on focus if enabled
        }
      });
    }
    focusNode?.addListener(() {
      if (!focusNode!.hasFocus) {
        if (onSaved != null) {
          onSaved!(controller?.text);
        }
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: AutoSizeText(label!,
                    style:
                        labelTextStyle ?? TextStyle(fontSize: AppFontSizes.sm)),
              )
            : Container(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            initialValue: initialValue,
            autofillHints: autoFillHint,
            textAlign: textAlign ?? TextAlign.start,
            enabled: enabled,
            cursorColor: AppColor.primaryColor,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: labelFloating,
              // label: Icon(Icons.abc),
              labelStyle: labelFloatingTextStyle ??
                  TextStyle(fontSize: AppFontSizes.lg),
              isDense: true,
              // counterText: '',
              contentPadding: contentPadding,
              hintText: hintText,
              hintStyle: hintStyle,
              border: customBorder ??
                  (errorText == null
                      ? AppWidgetBorder.border
                      : AppWidgetBorder.errorBorder),
              enabledBorder: customBorder ??
                  (errorText == null
                      ? AppWidgetBorder.enabledBorder
                      : AppWidgetBorder.errorBorder),
              disabledBorder: customBorder ?? AppWidgetBorder.disabledBorder,
              focusedBorder: customBorder ??
                  (errorText == null
                      ? AppWidgetBorder.focusedBorder
                      : AppWidgetBorder.errorBorder),
              prefixIcon: prefixWidget,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0.0,
                minHeight: 0.0,
              ),
              suffixIcon: (suffixIconAssetName != null ||
                      suffixIconWidget != null
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: IconButton(
                        onPressed: onTapSuffix,
                        icon: suffixIconWidget ??
                            Icon(
                              suffixIconAssetName,
                              color: suffixIconColor ?? AppColor.primaryColor,
                              size: 25.0,
                            ),
                      ),
                    )
                  : null),
            ),
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            showCursor: showCursor,
            maxLengthEnforcement: maxLengthEnforcement,
            minLines: minLines,
            maxLength: maxLength,
            onChanged: onChanged,
            onTap: onTap,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: (value) {
              if (onFieldSubmitted != null) {
                onFieldSubmitted!(value);
              }
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              } else {
                FocusScope.of(context).unfocus();
              }
            },
            onSaved: onSaved,
            validator: validator,
            enableInteractiveSelection: enableInteractiveSelection,
            selectionControls: selectionControls,
            buildCounter: buildCounter,
            maxLines: maxLines,
            obscuringCharacter: obscuringCharacter,
            expands: expands,
            obscureText: obscureText,
            autofocus: autofocus,
            readOnly: readOnly,
            style: styleText,
          ),
        ),
        helperText != null && (errorText == null || enabled)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  6.gap,
                  Text(
                    helperText!,
                  ),
                ],
              )
            : Container(),
        errorText != null && enabled
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.gap,
                  Text(
                    errorText!,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
