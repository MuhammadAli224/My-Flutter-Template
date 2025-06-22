import '../../../../global_imports.dart';
import '../cubit/password_visibility_cubit.dart';
import '../widget/auth_login_widget.dart';

class AuthLoginPage extends StatelessWidget {
  const AuthLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(AppStrings.login.tr()),
        backgroundColor: AppColor.backgroundColor,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AuthCubit>()),
          BlocProvider(create: (_) => PasswordVisibilityCubit()),
        ],
        child: AuthLoginWidget(),
      ),
    );
  }
}
