import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_strings.dart';
import '../../../../core/widget/app_widget/text_input_field.dart';
import '../cubit/password_visibility_cubit.dart';

class AuthPasswordField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const AuthPasswordField({super.key, this.validator, this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordVisibilityCubit, bool>(
      builder: (context, isVisible) {
        return AppTextFormField(
          controller: controller,
          label: AppStrings.password.tr(),
          hintText: AppStrings.enterPasswordHint.tr(),
          obscureText: !isVisible,
          suffixIconAssetName:
              isVisible ? Icons.visibility : Icons.visibility_off,
          onTapSuffix: () {
            context.read<PasswordVisibilityCubit>().toggleVisibility();
          },
          validator: validator,
        );
      },
    );
  }
}
