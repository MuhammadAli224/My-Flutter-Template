import '../../../../global_imports.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.remote,
    required this.local,
  });

  @override
  Future<Either<Failure, ApiResponse<AuthEntity>>> getUser({
    required DataSource dataSource,
    required CancelToken cancelToken,
  }) async {
    try {
      final token = await local.getToken();
      if (token == null) {
        return left(ServerFailure(message: AppStrings.unauthorized.tr()));
      }
      final hasConnection = await networkInfo.isConnected;

      if (!hasConnection || dataSource == DataSource.local) {
        final user = await local.getUser();
        if (user != null) {
          return right(
            ApiResponse(message: '', code: 200, data: user.toEntity()),
          );
        }
      }
      final apiResponse = await remote.getUser(
        token: token,
        cancelToken: cancelToken,
      );

      if (apiResponse.success) {
        final entityResponse = apiResponse.map((model) => model.toEntity());

        await local.saveUser(apiResponse.data!);
        return right(entityResponse);
      } else {
        return left(ServerFailure(message: apiResponse.message));
      }
    } on DioException catch (e, t) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        final localModel = await local.getUser();
        if (localModel != null) {
          return right(
            ApiResponse(message: '', code: 200, data: localModel.toEntity()),
          );
        }
        return left(
          ServerFailure(
            message: "Request timed out, and no local data is available.",
          ),
        );
      }
      return handleRepoDataError(e, t);
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }

  @override
  Future<Either<Failure, ApiResponse<AuthEntity>>> login({
    required String identify,
    required String password,
    required CancelToken cancelToken,
  }) async {
    try {
      final apiResponse = await remote.login(
        identify: identify,
        password: password,
        cancelToken: cancelToken,
      );

      if (apiResponse.success && apiResponse.data != null) {
        final entityResponse = apiResponse.map((model) => model.toEntity());

        await local.saveToken(apiResponse.token!);

        return right(entityResponse);
      } else {
        return left(ServerFailure(message: apiResponse.message));
      }
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }

  @override
  Future<Either<Failure, ApiResponse<AuthEntity>>> logout(
    CancelToken cancelToken,
  ) async {
    try {
      final token = await local.getToken();
      if (token == null) {
        return left(ServerFailure(message: AppStrings.unauthorized.tr()));
      }
      final apiResponse = await remote.logout(
        token: token,
        cancelToken: cancelToken,
      );

      if (apiResponse.success) {
        await local.deleteToken();
        await local.deleteUser();
        final entityResponse = apiResponse.map((model) => model.toEntity());

        return right(entityResponse);
      } else {
        return left(
          ServerFailure(message: apiResponse.message, title: apiResponse.error),
        );
      }
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> updateProfile(CancelToken cancelToken) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ApiResponse<AuthEntity>>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required CancelToken cancelToken,
  }) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
