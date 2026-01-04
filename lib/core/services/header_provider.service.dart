import '../../global_imports.dart';
import 'token/token_cubit.dart';

class HeadersProvider {
  final Box<dynamic> hive;
  final TokenCubit tokenCubit;

  HeadersProvider({required this.tokenCubit, required this.hive});

  static const String _acceptLanguage = "Accept-Language";

  Future<Map<String, String>> getHeaders({Map<String, String>? extra}) async {
    final language = await hive.get(BoxKey.languageCode, defaultValue: 'ar');
    final token = tokenCubit.currentToken;

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      _acceptLanguage: language,
      if (token != null) 'Authorization': 'Bearer $token',

      if (extra != null) ...extra,
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
    options.headers.addAll(headers);
    return handler.next(options);
  }
}
