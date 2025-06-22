import 'package:dio/dio.dart';

import '../../main.dart';
import '../extension/map_extension.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('''====================START====================
    HTTP method => ${options.method} 
    Header  => ${options.headers}
    data  => ${options.data as Map<String, dynamic>?}
    Request Url => ${options.baseUrl}${options.path}${options.queryParameters.format}''');

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    logger.e('''Error: ${err.error}
    Message: ${err.message}
    Option :${options.method}'''); // Error log
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.w('''Response => StatusCode: ${response.statusCode}
    Response => Body: ${response.data}''');
    return super.onResponse(response, handler);
  }
}
