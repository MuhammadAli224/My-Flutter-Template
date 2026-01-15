import '../../global_imports.dart';

class HeadersProvider {
  final Box<dynamic> hive;
  final TokenCubit tokenCubit;

  HeadersProvider({required this.tokenCubit, required this.hive});

  static const String _acceptLanguage = "Accept-Language";

  Future<Map<String, String>> getHeaders() async {
    final language = await hive.get(BoxKey.languageCode, defaultValue: 'ar');
    final token = tokenCubit.currentToken;

    final headers = <String, String>{
      _acceptLanguage: language,
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return headers;
  }
}

class HeaderInterceptor extends Interceptor {
  final HeadersProvider headersProvider;

  HeaderInterceptor(this.headersProvider);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final headers = await headersProvider.getHeaders();
    headers.forEach((key, value) {
      options.headers.putIfAbsent(key, () => value);
    });

    if (options.data is FormData) {
      options.headers.remove('Content-Type');
    }
    return handler.next(options);
  }
}
