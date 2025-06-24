import '../../../../global_imports.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<AuthUserModel>> login({
    required String identify,
    required String password,
    required CancelToken cancelToken,
  });

  Future<ApiResponse<AuthUserModel>> logout({
    required String token,
    required CancelToken cancelToken,
  });

  Future<ApiResponse<AuthUserModel>> getUser({
    required String token,
    required CancelToken cancelToken,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices apiServices;

  AuthRemoteDataSourceImpl(this.apiServices);

  @override
  Future<ApiResponse<AuthUserModel>> login({
    required String identify,
    required String password,
    required CancelToken cancelToken,
  }) async {
    // final fcmToken = OneSignal.User.pushSubscription.id;
    final response = await apiServices.postData(
      AuthEndpoint.login,
      {"login": identify, "password": password},
      cancelToken: cancelToken,
      language: GlobalContext.context.locale.languageCode,
    );
    final apiResponse = ApiResponse<AuthUserModel>.fromJson(
      response,
      (data) => AuthUserModel.fromJson(data),
    );
    return apiResponse;
  }

  @override
  Future<ApiResponse<AuthUserModel>> logout({
    required String token,
    required CancelToken cancelToken,
  }) async {
    final response = await apiServices.postData(
      AuthEndpoint.logout,
      {},
      cancelToken: cancelToken,
      language: GlobalContext.context.locale.languageCode,
      token: token,
    );

    final apiResponse = ApiResponse.fromJson(
      response,
      (data) => AuthUserModel.fromJson(data),
    );
    return apiResponse;
  }

  @override
  Future<ApiResponse<AuthUserModel>> getUser({
    required String token,
    required CancelToken cancelToken,
  }) async {
    final response = await apiServices.getData(
      AuthEndpoint.getUser,
      language: GlobalContext.context.locale.languageCode,
      cancelToken: cancelToken,
      token: token,
    );

    final apiResponse = ApiResponse.fromJson(
      response,
      (data) => AuthUserModel.fromJson(data),
    );
    return apiResponse;
  }
}
