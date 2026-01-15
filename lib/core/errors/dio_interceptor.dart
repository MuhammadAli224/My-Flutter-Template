import 'package:dio/dio.dart';

import '../../main.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final query = options.queryParameters.isEmpty
        ? ''
        : '?${options.queryParameters.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}').join('&')}';

    final dataLog = _formatData(options.data);

    logger.i('''
==================== START REQUEST ====================
HTTP Method => ${options.method}
URL => ${options.baseUrl}${options.path}$query
Headers => ${options.headers}
Data => $dataLog
=====================================================
''');

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final dataLog = _formatData(options.data);

    logger.e('''
==================== ERROR ====================
Error => ${err.error}
Message => ${err.message}
HTTP Method => ${options.method}
URL => ${options.baseUrl}${options.path}
Headers => ${options.headers}
Data => $dataLog
==============================================
''');

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.w('''
==================== RESPONSE ====================
Status Code => ${response.statusCode}
Body => ${response.data}
===============================================
''');

    super.onResponse(response, handler);
  }

  String _formatData(dynamic data) {
    if (data == null) return 'null';

    if (data is FormData) {
      return '''
FormData:
Fields => ${data.fields}
Files => ${data.files.map((f) => f.key).toList()}
''';
    }

    if (data is Map<String, dynamic>) {
      return data.toString();
    }

    return data.toString();
  }
}
