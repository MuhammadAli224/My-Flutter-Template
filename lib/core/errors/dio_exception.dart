import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';

import '../../generated/app_strings.g.dart';
import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.title});

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return ServerFailure(message: LocaleKeys.cancelRequest);

      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: LocaleKeys.connectionTimeOut);

      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: LocaleKeys.receiveTimeOut);

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(message: LocaleKeys.sendTimeOut);

      case DioExceptionType.connectionError:
        return ServerFailure(message: LocaleKeys.socketException);

      default:
        return ServerFailure(message: LocaleKeys.unknownError);
    }
  }

  factory ServerFailure.fromHiveError(HiveError error) {
    return ServerFailure(message: "Database Error ${error.message}");
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return ServerFailure(message: LocaleKeys.badRequest);
      case 401:
        return ServerFailure(message: LocaleKeys.unauthorized);
      case 403:
        return ServerFailure(message: LocaleKeys.forbidden);
      case 404:
        return ServerFailure(message: LocaleKeys.notFoundServer);
      case 422:
        return ServerFailure(message: LocaleKeys.duplicateEmail);
      case 500:
        return ServerFailure(message: LocaleKeys.internalServerError);
      case 502:
        return ServerFailure(message: LocaleKeys.badGateway);
      default:
        return ServerFailure(message: LocaleKeys.unknownError);
    }
  }

  @override
  String toString() => message;
}

class ServerSuccess extends Success {
  ServerSuccess({required super.message});

  @override
  String toString() => message;
}
