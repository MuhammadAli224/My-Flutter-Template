import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../extension/space_extension.dart';
import '../../utils/text_style.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final String? buttonName;
  final void Function()? onTap;

  const ErrorScreen(
      {super.key, required this.errorMessage, this.buttonName, this.onTap});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback(
    //     (_) => showSnackBar(errorMessage.tr(), context, color: Colors.red));
    return Center(
      child: SizedBox(
        height: 0.5.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(HugeIcons.strokeRoundedAlert02,
                color: Colors.red, size: 100.sp),
            10.gap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AutoSizeText(
                errorMessage.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyle.style24B,
                maxLines: 3,
                minFontSize: 14,
                maxFontSize: 24,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (buttonName != null && onTap != null) ...[
              20.gap,
              TextButton(
                onPressed: onTap,
                child: AutoSizeText(
                  buttonName!.tr(),
                  style: AppTextStyle.style16B,
                  maxLines: 1,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
