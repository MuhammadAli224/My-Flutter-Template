import '../../global_imports.dart';

class ApiResponse<T> {
  final T? data;
  final List<T>? list;
  final String description;
  final int code;
  final String? error;
  final String? token;
  final bool hasError;
  final ServerPagination? pagination;

  ApiResponse({
    this.data,
    this.error,
    this.token,
    this.list,
    required this.description,
    required this.code,
    this.hasError = true,
    this.pagination,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic) fromJsonT, {
        String? path,
      }) {
    dynamic rawData = json['data'];
    if (path != null) {
      rawData = rawData[path];
    }

    final paginationJson = json['pagination'];
    return ApiResponse<T>(
      hasError: json['hasError'] ?? false,
      description: json['description'] ?? AppStrings.unknownError.tr(),
      code: json['code'] ?? 200,
      error: json['error'] is String ? json['error'] : null,
      token: json['token'] is String ? json['token'] : null,
      pagination:
      paginationJson is Map<String, dynamic>
          ? ServerPagination.fromJson(paginationJson)
          : null,
      data: rawData is Map<String, dynamic> ? fromJsonT(rawData) : null,
      list: rawData is List ? rawData.map((e) => fromJsonT(e)).toList() : null,
    );
  }

  ApiResponse<R> map<R>(R Function(T e) mapper) {
    return ApiResponse<R>(
      data: data != null ? mapper(data as T) : null,
      list: list?.map(mapper).toList(),
      description: description,
      code: code,
      error: error,
      token: token,
      hasError: hasError,
      pagination: pagination,
    );
  }

  ApiResponse<T> copyWith({
    T? data,
    List<T>? list,
    String? description,
    int? code,
    String? error,
    String? token,
    bool? hasError,
    ServerPagination? pagination,
  }) {
    return ApiResponse<T>(
      data: data ?? this.data,
      list: list ?? this.list,
      description: description ?? this.description,
      code: code ?? this.code,
      error: error ?? this.error,
      token: token ?? this.token,
      hasError: hasError ?? this.hasError,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  String toString() {
    return '''
        data: $data, 
        list: $list,
        token: $token, 
        description: $description, 
        code: $code, 
        error: $error, 
        success: $hasError
        pagination: $pagination
''';
  }
}
