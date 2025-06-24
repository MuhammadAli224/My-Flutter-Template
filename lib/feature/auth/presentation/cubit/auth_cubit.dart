import '../../../../global_imports.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with CubitLifecycleMixin<AuthState> {
  final AuthRegisterCase _register;
  final AuthLogoutCase _logout;
  final AuthLoginCase _login;
  final AuthGetUserCase _getUser;

  // final AuthUpdateProfileCase _updateProfile;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthCubit({
    required AuthRegisterCase registerCase,
    required AuthLogoutCase logoutCase,
    required AuthLoginCase loginCase,
    required AuthGetUserCase getUserCase,
    // required AuthUpdateProfileCase updateProfileCase,
  }) : _register = registerCase,
       _logout = logoutCase,
       _login = loginCase,
       _getUser = getUserCase,
       // _updateProfile = updateProfileCase,
       super(const AuthState.initial());

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    safeEmit(const AuthState.loading());
    final result = await _login(
      identify: emailController.text.trim(),
      password: passwordController.text.trim(),
      cancelToken: cancelToken,
    );
    if (isClosed) return;
    result.fold(
      (failure) => safeEmit(AuthState.error(message: failure.message)),
      (response) {
        _reset();
        safeEmit(AuthState.loaded(response.data!, response.message));
      },
    );
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;
    safeEmit(const AuthState.loading());
    final result = await _register(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: userNameController.text.trim(),
      phone: phoneController.text.trim(),
      cancelToken: cancelToken,
    );
    if (isClosed) return;
    result.fold(
      (failure) => safeEmit(
        AuthState.error(message: failure.message, title: failure.title),
      ),
      (response) {
        _reset();
        safeEmit(AuthState.loaded(response.data!, response.message));
      },
    );
  }

  Future<void> logout() async {
    safeEmit(const AuthState.loading());
    final result = await _logout(cancelToken);
    if (isClosed) return;
    result.fold(
      (failure) => safeEmit(
        AuthState.error(message: failure.message, title: failure.title),
      ),
      (response) {
        // emit(AuthState.loaded(response.data!, response.message));
      },
    );
  }

  void _reset() {
    safeEmit(const AuthState.initial());
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    userNameController.clear();
  }

  Future<void> getUser() async {
    safeEmit(const AuthState.loading());
    final result = await _getUser(cancelToken: cancelToken);
    if (isClosed) return;
    result.fold(
      (failure) => safeEmit(AuthState.error(message: failure.message)),
      (user) {
        safeEmit(AuthState.loaded(user.data!, ''));
      },
    );
  }

  @override
  close() async {
    super.close();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    userNameController.dispose();
  }
}
