import '../../../../global_imports.dart';

class AuthGetUserCase {
  final AuthRepository repository;

  AuthGetUserCase(this.repository);

  Future<Either<Failure, ApiResponse<AuthEntity>>> call({
    DataSource dataSource = DataSource.remote,
    required CancelToken cancelToken,
  }) {
    return repository.getUser(dataSource: dataSource, cancelToken: cancelToken);
  }
}
