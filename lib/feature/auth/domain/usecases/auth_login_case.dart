import '../../../../global_imports.dart';

class AuthLoginCase {
  final AuthRepository repository;

  AuthLoginCase(this.repository);

  Future<Either<Failure, ApiResponse<AuthEntity>>> call(
      {required String identify,
      required String password,
      required CancelToken cancelToken}) {
    return repository.login(
      identify: identify,
      password: password,
      cancelToken: cancelToken,
    );
  }
}
