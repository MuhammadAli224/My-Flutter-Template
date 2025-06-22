import '../../../../global_imports.dart';

class AuthLogoutCase {
  final AuthRepository repository;

  AuthLogoutCase(this.repository);

  Future<Either<Failure, ApiResponse<AuthEntity>>> call(
      CancelToken cancelToken) {
    return repository.logout(cancelToken);
  }
}
