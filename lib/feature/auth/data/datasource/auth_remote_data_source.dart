import '../../../../global_imports.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<AuthEntity>> login({
    required String identify,
    required String password,
    required CancelToken cancelToken,
  });

  Future<ApiResponse<AuthEntity>> logout({
    required String token,
    required CancelToken cancelToken,
  });

  Future<ApiResponse<AuthEntity>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String taxNumber,
    required String comericalNumber,
    required CancelToken cancelToken,
  });

  Future<ApiResponse<AuthEntity>> getUser({
    required String token,
    required CancelToken cancelToken,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices apiServices;

  AuthRemoteDataSourceImpl(this.apiServices);

  @override
  Future<ApiResponse<AuthEntity>> login({
    required String identify,
    required String password,
    required CancelToken cancelToken,
  }) async {
    final fcmToken = OneSignal.User.pushSubscription.id;
    final response = await apiServices.postData(
      AuthEndpoint.login,
      {
        "login": identify,
        "password": password,
        "fcm_token": fcmToken,

      },
      cancelToken: cancelToken,
      language: GlobalContext.context.locale.languageCode,
    );
    final apiResponse = ApiResponse<AuthEntity>.fromJson(
        response, (data) => AuthUserModel.fromJson(data).toEntity());
    return apiResponse;
  }

  @override
  Future<ApiResponse<AuthEntity>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String taxNumber,
    required String comericalNumber,
    required CancelToken cancelToken,
  }) async {
    final fcmToken = OneSignal.User.pushSubscription.id;

    logger.e("fcmToken : $fcmToken");

    final response = await apiServices.postData(
      AuthEndpoint.register,
      {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "tax_number": taxNumber,
        "comerical_number": comericalNumber,
        "fcm_token": fcmToken,
      },
      cancelToken: cancelToken,
      language: GlobalContext.context.locale.languageCode,
    );

    final apiResponse = ApiResponse.fromJson(
        response, (data) => AuthUserModel.fromJson(data).toEntity());
    return apiResponse;
  }

  @override
  Future<ApiResponse<AuthEntity>> logout({
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
        response, (data) => AuthUserModel.fromJson(data).toEntity());
    return apiResponse;
  }

  @override
  Future<ApiResponse<AuthEntity>> getUser({
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
        response, (data) => AuthUserModel.fromJson(data).toEntity());
    return apiResponse;
  }
}
