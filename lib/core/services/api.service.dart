import '../../global_imports.dart';

class ApiServices {
  final Dio _dio;
  final HeadersProvider _headersProvider;

  ApiServices(this._dio, this._headersProvider) {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: EnvConstant.server,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      // },
    );

    _dio.interceptors.clear();
    _dio.interceptors.add(HeaderInterceptor(_headersProvider));
    _dio.interceptors.add(DioInterceptor());
  }

  /// POST
  Future<Map<String, dynamic>> postData(
      String url,
      Map<String, dynamic> data, {
        CancelToken? cancelToken,
        Map<String, String>? headers,
        bool isFormData = false,
      }) async {
    final response = await _dio.post(
      url,
      data: isFormData ? FormData.fromMap({...data}) : data,
      cancelToken: cancelToken,
    );

    return _parseResponse(response);
  }

  /// PUT
  Future<Map<String, dynamic>> putData(
      String url,
      Map<String, dynamic> data, {
        CancelToken? cancelToken,
      }) async {
    final response = await _dio.put(url, data: data, cancelToken: cancelToken);
    return _parseResponse(response);
  }

  /// GET
  Future<Map<String, dynamic>> getData(
      String url, {
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) async {
    final response = await _dio.get(
      url,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return _parseResponse(response);
  }

  /// POST with File upload
  Future<Map<String, dynamic>> postWithImage(
      String url,
      Map<String, dynamic> data,
      File image, {
        CancelToken? cancelToken,
      }) async {
    final fileName = image.path.split('/').last;

    final formData = FormData.fromMap({
      ...data,
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
    });

    final response = await _dio.post(
      url,
      data: formData,
      cancelToken: cancelToken,
    );
    return _parseResponse(response);
  }

  Map<String, dynamic> _parseResponse(Response response) {
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {"data": response.data};
  }
}
