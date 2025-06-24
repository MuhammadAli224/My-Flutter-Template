import '../../../../global_imports.dart';

abstract class AuthRepository {
  Future<Either<Failure, ApiResponse<AuthEntity>>> login({
    required String identify,
    required String password,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, ApiResponse<AuthEntity>>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, ApiResponse<AuthEntity>>> logout(
    CancelToken cancelToken,
  );

  Future<Either<Failure, ApiResponse<AuthEntity>>> getUser({
    required DataSource dataSource,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, AuthEntity>> updateProfile(CancelToken cancelToken);
}
