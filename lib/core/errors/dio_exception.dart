import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_ce/hive.dart';

import '../../generated/app_strings.g.dart';
import 'failure.dart';

enum AppExceptionType {
  network,
  timeout,
  server,
  unauthorized,
  forbidden,
  notFound,
  validation,
  parsing,
  cancelled,
  unknown,
}

class AppException implements Exception {
  AppException({
    required String message,
    required this.type,
    this.statusCode,
    this.originalException,
    this.stackTrace,
  }) : message = _safeMessage(message);

  final String message;
  final int? statusCode;
  final AppExceptionType type;
  final Object? originalException;
  final StackTrace? stackTrace;

  factory AppException.fromDioException(DioException error) {
    if (CancelToken.isCancel(error)) {
      return AppException(
        message: _message(LocaleKeys.cancelRequest, 'Request was cancelled.'),
        type: AppExceptionType.cancelled,
        originalException: error,
      );
    }

    final socketError = _isSocketException(error.error);

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppException(
          message: _message(
            LocaleKeys.connectionTimeOut,
            'Connection timed out. Please try again.',
          ),
          type: AppExceptionType.timeout,
          originalException: error,
        );
      case DioExceptionType.sendTimeout:
        return AppException(
          message: _message(
            LocaleKeys.sendTimeOut,
            'Request timed out while sending data. Please try again.',
          ),
          type: AppExceptionType.timeout,
          originalException: error,
        );
      case DioExceptionType.receiveTimeout:
        return AppException(
          message: _message(
            LocaleKeys.receiveTimeOut,
            'Request timed out while receiving data. Please try again.',
          ),
          type: AppExceptionType.timeout,
          originalException: error,
        );
      case DioExceptionType.badCertificate:
        return AppException(
          message: _message(
            LocaleKeys.badCertificate,
            'Unable to verify the server certificate.',
          ),
          type: AppExceptionType.network,
          originalException: error,
        );
      case DioExceptionType.badResponse:
        return AppException.fromResponse(
          error.response,
          originalException: error,
        );
      case DioExceptionType.cancel:
        return AppException(
          message: _message(LocaleKeys.cancelRequest, 'Request was cancelled.'),
          type: AppExceptionType.cancelled,
          originalException: error,
        );
      case DioExceptionType.connectionError:
        return AppException(
          message: _noInternetMessage,
          type: AppExceptionType.network,
          originalException: error,
        );
      case DioExceptionType.unknown:
        return AppException(
          message: socketError ? _noInternetMessage : _genericMessage,
          type: socketError
              ? AppExceptionType.network
              : AppExceptionType.unknown,
          originalException: error,
        );
      case DioExceptionType.transformTimeout:
        return AppException(
          message: _message(
            LocaleKeys.receiveTimeOut,
            'Request timed out while receiving data. Please try again.',
          ),
          type: AppExceptionType.timeout,
          originalException: error,
        );
    }
  }

  factory AppException.fromResponse(
    Response? response, {
    Object? originalException,
  }) {
    final statusCode = response?.statusCode;
    final responseMessage = extractMessage(response?.data);
    final fallbackMessage = _messageForStatusCode(statusCode);

    return AppException(
      message: responseMessage ?? fallbackMessage,
      statusCode: statusCode,
      type: _typeForStatusCode(statusCode),
      originalException: originalException,
    );
  }

  factory AppException.fromException(Object error, [StackTrace? stackTrace]) {
    if (error is AppException) {
      return error;
    }

    if (error is DioException) {
      return AppException.fromDioException(error);
    }

    if (error is HiveError) {
      return AppException(
        message: _message(
          LocaleKeys.databaseError,
          'Database error. Please try again.',
        ),
        type: AppExceptionType.unknown,
        originalException: error,
        stackTrace: stackTrace,
      );
    }

    if (_isSocketException(error)) {
      return AppException(
        message: _noInternetMessage,
        type: AppExceptionType.network,
        originalException: error,
        stackTrace: stackTrace,
      );
    }

    if (error is FormatException || error is TypeError) {
      return AppException(
        message: _genericMessage,
        type: AppExceptionType.parsing,
        originalException: error,
        stackTrace: stackTrace,
      );
    }

    return AppException(
      message: _genericMessage,
      type: AppExceptionType.unknown,
      originalException: error,
      stackTrace: stackTrace,
    );
  }

  static String? extractMessage(dynamic data) {
    try {
      final message = _extractMessage(data);
      return message == null || message.trim().isEmpty ? null : message.trim();
    } catch (_) {
      return null;
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data == null) return null;

    if (data is String) {
      return data.trim().isEmpty ? null : data;
    }

    if (data is Map) {
      for (final key in const ['message', 'error', 'title', 'detail']) {
        final message = _extractMessage(data[key]);
        if (message != null) return message;
      }

      final errors = _extractMessage(data['errors']);
      if (errors != null) return errors;

      for (final value in data.values) {
        final message = _extractMessage(value);
        if (message != null) return message;
      }
      return null;
    }

    if (data is Iterable) {
      final messages = <String>[];
      for (final item in data) {
        final message = _extractMessage(item);
        if (message != null && message.trim().isNotEmpty) {
          messages.add(message.trim());
        }
      }
      return messages.isEmpty ? null : messages.join('\n');
    }

    return null;
  }

  @override
  String toString() => message;
}

class AppFailure extends Failure {
  AppFailure({
    required super.message,
    super.title,
    this.statusCode,
    this.type = AppExceptionType.unknown,
    this.originalException,
  });

  final int? statusCode;
  final AppExceptionType type;
  final Object? originalException;

  factory AppFailure.fromAppException(AppException exception) {
    return AppFailure(
      message: exception.message,
      statusCode: exception.statusCode,
      type: exception.type,
      originalException: exception.originalException,
    );
  }

  factory AppFailure.fromDioError(DioException dioException) {
    return AppFailure.fromAppException(
      AppException.fromDioException(dioException),
    );
  }

  factory AppFailure.fromException(Object error, [StackTrace? stackTrace]) {
    return AppFailure.fromAppException(
      AppException.fromException(error, stackTrace),
    );
  }

  factory AppFailure.fromHiveError(HiveError error) {
    return AppFailure.fromException(error);
  }

  factory AppFailure.fromResponse(int? statusCode, dynamic error) {
    return AppFailure.fromAppException(
      AppException.fromResponse(
        Response<dynamic>(
          requestOptions: RequestOptions(),
          statusCode: statusCode,
          data: error,
        ),
      ),
    );
  }

  @override
  String toString() => message;
}

typedef ServerFailure = AppFailure;

class ServerSuccess extends Success {
  ServerSuccess({required super.message});

  @override
  String toString() => message;
}

String get _genericMessage => _message(
  LocaleKeys.unknownError,
  'Something went wrong. Please try again.',
);

String get _noInternetMessage => _message(
  LocaleKeys.noInternetConnection,
  'No internet connection. Please check your network.',
);

String _safeMessage(String? message) {
  final value = message?.trim();
  return value == null || value.isEmpty ? _genericMessage : value;
}

String _message(String localeKey, String fallback) {
  try {
    final translated = localeKey.tr();
    if (translated.trim().isNotEmpty && translated != localeKey) {
      return translated;
    }
  } catch (_) {
    // Localization may be unavailable in tests or early startup.
  }

  return fallback;
}

bool _isSocketException(Object? error) {
  if (error is SocketException) return true;
  return error.toString().contains('SocketException');
}

AppExceptionType _typeForStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
    case 422:
      return AppExceptionType.validation;
    case 401:
      return AppExceptionType.unauthorized;
    case 403:
      return AppExceptionType.forbidden;
    case 404:
      return AppExceptionType.notFound;
    case 408:
    case 504:
      return AppExceptionType.timeout;
    case 429:
    case 500:
    case 502:
    case 503:
      return AppExceptionType.server;
    default:
      return AppExceptionType.unknown;
  }
}

String _messageForStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      return _message(LocaleKeys.badRequest, 'Invalid request.');
    case 401:
      return _message(LocaleKeys.unauthorized, 'Unauthorized request.');
    case 403:
      return _message(LocaleKeys.forbidden, 'You do not have permission.');
    case 404:
      return _message(LocaleKeys.notFoundServer, 'Resource not found.');
    case 408:
      return _message(
        LocaleKeys.requestTimeout,
        'Request timeout. Please try again.',
      );
    case 422:
      return _message(LocaleKeys.formValidateError, 'Validation error.');
    case 429:
      return _message(
        LocaleKeys.tooManyRequests,
        'Too many requests. Please try again later.',
      );
    case 500:
      return _message(
        LocaleKeys.internalServerError,
        'Server error. Please try again later.',
      );
    case 502:
      return _message(LocaleKeys.badGateway, 'Bad gateway.');
    case 503:
      return _message(
        LocaleKeys.serviceUnavailable,
        'Service unavailable. Please try again later.',
      );
    case 504:
      return _message(
        LocaleKeys.gatewayTimeout,
        'Gateway timeout. Please try again.',
      );
    default:
      return _genericMessage;
  }
}
