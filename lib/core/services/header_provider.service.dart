import '../../global_imports.dart';

class HeadersProvider {
  final Box<dynamic> hive;

  HeadersProvider({required this.hive});

  static const String _acceptLanguage = "Accept-Language";

  Future<Map<String, String>> getHeaders({Map<String, String>? extra}) async {
    final language = await hive.get(BoxKey.languageCode, defaultValue: "en");
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      _acceptLanguage: language,
    };

    if (extra != null) headers.addAll(extra);
    return headers;
  }
}
