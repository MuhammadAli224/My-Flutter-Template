import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_strings.dart';
import '../../../../core/extension/space_extension.dart';
import '../../../../core/mixin/validate.mixin.dart';
import '../../../../core/widget/app_widget/text_input_field.dart';
import '../cubit/auth_cubit.dart';
import 'auth_action_button.dart';
import 'auth_password_field.dart';

class AuthRegisterWidget extends StatelessWidget with FormValidationMixin {
  AuthRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            AppTextFormField(
              label: AppStrings.userName.tr(),
              controller: cubit.userNameController,
              validator: (val) {
                return validateLength(value: val, minLength: 3, maxLength: 50);
              },
            ),
            10.h.gap,
            AppTextFormField(
              label: AppStrings.email.tr(),
              controller: cubit.emailController,
              hintText: AppStrings.enterEmailHint.tr(),
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
            10.h.gap,
            AppTextFormField(
              label: AppStrings.phoneNumber.tr(),
              controller: cubit.phoneController,
              maxLength: 10,
              hintText: AppStrings.phoneNumber.tr(),
              keyboardType: TextInputType.phone,
              validator: validateMobile,
            ),
            10.h.gap,
            AuthPasswordField(
              controller: cubit.passwordController,
              validator: (val) {
                return validateLength(value: val, minLength: 5, maxLength: 20);
              },
            ),
            10.gap,

            10.h.gap,
            AuthActionButton(
              onTap: cubit.register,
              text: AppStrings.register.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
