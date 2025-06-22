import '../../global_imports.dart';

class ApiServices {
  final Dio _dio;

  ApiServices(this._dio) {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: EnvConstant.server,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );
    _dio.interceptors.clear();
    _dio.interceptors.add(DioInterceptor());
  }

  Future<Map<String, dynamic>> postData(
    String url,
    Map<String, dynamic> data, {
    String? token,
    required String? language,
    CancelToken? cancelToken,
  }) async {
    _dio.options.headers["X-Language"] = language ?? 'ar';
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    } else {
      _dio.options.headers.remove("Authorization");
    }
    var response = await _dio.post(
      url,
      data: data,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> putData(
    String url,
    Map<String, dynamic> data, {
    String? token,
    CancelToken? cancelToken,
    required String? language,
  }) async {
    _dio.options.headers["X-Language"] = language ?? 'ar';
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    } else {
      _dio.options.headers.remove("Authorization");
    }
    var response = await _dio.put(
      url,
      data: data,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getData(
    String url, {
    String? token,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
    required String? language,
  }) async {
    _dio.options.headers["X-Language"] = language ?? 'ar';

    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    } else {
      _dio.options.headers.remove("Authorization");
    }
    var response = await _dio.get(
      url,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> postWithImage(
    String url,
    Map<String, dynamic> data,
    File image, {
    String? token,
    CancelToken? cancelToken,
    required String? language,
  }) async {
    _dio.options.headers["X-Language"] = language ?? 'ar';

    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    } else {
      _dio.options.headers.remove("Authorization");
    }

    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      ...data,
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
    });

    var response = await _dio.post(
      url,
      data: formData,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}
