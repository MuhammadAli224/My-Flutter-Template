import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_strings.dart';
import '../../../../core/extension/space_extension.dart';
import '../../../../core/mixin/validate.mixin.dart';
import '../../../../core/widget/app_widget/text_input_field.dart';
import '../../../../generated/assets.dart';
import '../cubit/auth_cubit.dart';
import 'auth_action_button.dart';
import 'auth_password_field.dart';

class AuthLoginWidget extends StatelessWidget with FormValidationMixin {
  AuthLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(Assets.imagesAppNewIcon,
                height: 0.3.sh, width: double.infinity),
            AppTextFormField(
              label:
                  "${AppStrings.email.tr()} ${AppStrings.or.tr()} ${AppStrings.phoneNumber.tr()}",
              controller: cubit.emailController,
              hintText:
                  "${AppStrings.enterEmailHint.tr()} ${AppStrings.or.tr()} ${AppStrings.phoneNumber.tr()}",
              validator: validateEmailOrPhone,
            ),
            10.h.gap,
            AuthPasswordField(
              controller: cubit.passwordController,
              validator: (val) {
                return validateLength(value: val, minLength: 5, maxLength: 20);
              },
            ),
            20.gap,
            AuthActionButton(
              onTap: cubit.login,
              text: AppStrings.login.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
