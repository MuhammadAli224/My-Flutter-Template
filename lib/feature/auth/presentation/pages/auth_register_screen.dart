import '../../../../global_imports.dart';
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
