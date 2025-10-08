import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';

import '../constant/app_strings.dart';
import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.title});

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return ServerFailure(message: AppStrings.cancelRequest);

      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: AppStrings.connectionTimeOut);

      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: AppStrings.receiveTimeOut);

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(message: AppStrings.sendTimeOut);

      case DioExceptionType.connectionError:
        return ServerFailure(message: AppStrings.socketException);

      default:
        return ServerFailure(message: AppStrings.unknownError);
    }
  }

  factory ServerFailure.fromHiveError(HiveError error) {
    return ServerFailure(message: "Database Error ${error.message}");
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return ServerFailure(message: AppStrings.badRequest);
      case 401:
        return ServerFailure(message: AppStrings.unauthorized);
      case 403:
        return ServerFailure(message: AppStrings.forbidden);
      case 404:
        return ServerFailure(message: AppStrings.notFoundServer);
      case 422:
        return ServerFailure(message: AppStrings.duplicateEmail);
      case 500:
        return ServerFailure(message: AppStrings.internalServerError);
      case 502:
        return ServerFailure(message: AppStrings.badGateway);
      default:
        return ServerFailure(message: AppStrings.unknownError);
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
