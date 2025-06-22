import '../../../../global_imports.dart';

class AuthRegisterCase {
  final AuthRepository repository;

  AuthRegisterCase(this.repository);

  Future<Either<Failure, ApiResponse<AuthEntity>>> call({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String taxNumber,
    required String comericalNumber,
    required CancelToken cancelToken,
  }) {
    return repository.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      taxNumber: taxNumber,
      comericalNumber: comericalNumber,
      cancelToken: cancelToken,
    );
  }
}
