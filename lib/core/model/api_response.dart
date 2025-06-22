import '../../global_imports.dart';

class ApiResponse<T> {
  final T? data;
  final List<T>? list;
  final String message;
  final int code;
  final String? error;
  final String? token;
  final bool success;
  final ServerPagination? pagination;

  ApiResponse({
    this.data,
    this.error,
    this.token,
    this.list,
    required this.message,
    required this.code,
    this.success = true,
    this.pagination,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    final dynamic rawData = json['data'];
    final paginationJson = json['pagination'];
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? AppStrings.unknownError.tr(),
      code: json['code'] ?? 200,
      error: json['error'] is String ? json['error'] : null,
      token: json['token'] is String ? json['token'] : null,
      pagination: paginationJson is Map<String, dynamic>
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
      message: message,
      code: code,
      error: error,
      token: token,
      success: success,
      pagination: pagination,
    );
  }

  ApiResponse<T> copyWith({
    T? data,
    List<T>? list,
    String? message,
    int? code,
    String? error,
    String? token,
    bool? success,
    ServerPagination? pagination,
  }) {
    return ApiResponse<T>(
      data: data ?? this.data,
      list: list ?? this.list,
      message: message ?? this.message,
      code: code ?? this.code,
      error: error ?? this.error,
      token: token ?? this.token,
      success: success ?? this.success,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  String toString() {
    return '''
        data: $data, 
        list: $list,
        token: $token, 
        message: $message, 
        code: $code, 
        error: $error, 
        success: $success
        pagination: $pagination
''';
  }
}
