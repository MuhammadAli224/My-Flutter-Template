import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/color.dart';
import '../../../../dependencies/dependencies_injection.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/password_visibility_cubit.dart';
import '../widget/auth_register_widget.dart';

class AuthRegisterPage extends StatelessWidget {
  const AuthRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(AppStrings.register.tr()),
        backgroundColor: AppColor.backgroundColor,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AuthCubit>()),
          BlocProvider(create: (_) => PasswordVisibilityCubit()),
        ],
        child: AuthRegisterWidget(),
      ),
    );
  }
}
