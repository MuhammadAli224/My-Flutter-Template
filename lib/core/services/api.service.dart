import '../../global_imports.dart';

class ApiServices {
  final Dio _dio;
  static const String _authorization = "Authorization";

  static Future<Map<String, String>> get getHeaders async {
    final headersProvider = getIt<HeadersProvider>();
    return await headersProvider.getHeaders();
  }

  ApiServices(this._dio) {
    _configureDio();
  }

  Future<void> _configureDio() async {
    final headers = await getHeaders;
    _dio.options = BaseOptions(
      baseUrl: EnvConstant.server,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: headers,
    );
    _dio.interceptors.clear();
    _dio.interceptors.add(HeaderInterceptor());

    _dio.interceptors.add(DioInterceptor());
  }

  Future<Map<String, dynamic>> postData(
      String url,
      Map<String, dynamic> data, {
        String? token,
        CancelToken? cancelToken,
      }) async {
    final headers = await ApiServices.getHeaders;
    _dio.options.headers.addAll(headers);
    _handleTokenAuth(token);


    final response = await _dio.post(url, data: data, cancelToken: cancelToken);
    return response.data;
  }

  Future<Map<String, dynamic>> putData(
      String url,
      Map<String, dynamic> data, {
        String? token,
        CancelToken? cancelToken,
      }) async {
    final headers = await ApiServices.getHeaders;
    _dio.options.headers.addAll(headers);
    _handleTokenAuth(token);

    final response = await _dio.put(url, data: data, cancelToken: cancelToken);
    return response.data;
  }

  Future<Map<String, dynamic>> getData(
      String url, {
        String? token,
        CancelToken? cancelToken,
        Map<String, dynamic>? queryParameters,
      }) async {

    final headers = await ApiServices.getHeaders;
    _dio.options.headers.addAll(headers);
    _handleTokenAuth(token);

    final response = await _dio.get(
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
      }) async {

    final headers = await ApiServices.getHeaders;
    _dio.options.headers.addAll(headers);
    _handleTokenAuth(token);

    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      ...data,
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
    });

    final response = await _dio.post(
      url,
      data: formData,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  void _handleTokenAuth(String? token) {
    if (token != null) {
      _dio.options.headers[_authorization] = "Bearer $token";
    } else {
      _dio.options.headers.remove(_authorization);
    }
  }
}
