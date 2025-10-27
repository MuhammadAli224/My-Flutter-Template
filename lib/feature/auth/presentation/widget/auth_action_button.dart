import '../../../../global_imports.dart';

class AuthActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const AuthActionButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (auth, message) {
            showBar(
              context,
              title: AppStrings.hello.tr(args: [auth.name]),
              message: message,
              contentType: BarContentType.success,
            );
            context.go(AppRoutes.home);
          },
          error: (msg, title) {
            showBar(
              context,
              title: AppStrings.error.tr(args: ['']),
              message: msg,
              contentType: BarContentType.failure,
            );
          },
        );
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          width: double.infinity,
          child: AppButton.text(
            text: text,
            color: AppColor.secondaryColor,
            onPressed: onTap,
          ),
        );
      },
    );
  }
}
