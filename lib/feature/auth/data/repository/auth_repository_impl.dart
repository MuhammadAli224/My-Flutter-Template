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
  Future<Either<Failure, AuthEntity>> getUser({
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
          return right(user.toEntity());
        }
      }
      final apiResponse = await remote.getUser(
        token: token,
        cancelToken: cancelToken,
      );

      if (apiResponse.success) {
        await local.saveUser(apiResponse.data!.toModel());
        return right(apiResponse.data!);
      } else {
        return left(ServerFailure(message: apiResponse.message));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        final localModel = await local.getUser();
        if (localModel != null) {
          return right(localModel.toEntity());
        }
        return left(ServerFailure(
            message: "Request timed out, and no local data is available."));
      }
      return handleRepoDataError(e);
    } catch (e) {
      return handleRepoDataError(e);
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
        await local.saveToken(apiResponse.token!);
        return right(apiResponse);
      } else {
        return left(ServerFailure(message: apiResponse.message));
      }
    } catch (e) {
      return handleRepoDataError(e);
    }
  }

  @override
  Future<Either<Failure, ApiResponse<AuthEntity>>> logout(
      CancelToken cancelToken) async {
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
        return right(apiResponse);
      } else {
        return left(ServerFailure(
            message: apiResponse.message, title: apiResponse.error));
      }
    } catch (e) {
      return handleRepoDataError(e);
    }
  }

  @override
  Future<Either<Failure, ApiResponse<AuthEntity>>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String taxNumber,
    required String comericalNumber,
    required CancelToken cancelToken,
  }) async {
    try {
      final apiResponse = await remote.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        taxNumber: taxNumber,
        comericalNumber: comericalNumber,
        cancelToken: cancelToken,
      );

      if (apiResponse.success && apiResponse.data != null) {
        await local.saveToken(apiResponse.token!);
        return right(apiResponse);
      } else {
        return left(ServerFailure(
            message: apiResponse.message, title: apiResponse.error));
      }
    } catch (e) {
      return handleRepoDataError(e);
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> updateProfile(CancelToken cancelToken) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
