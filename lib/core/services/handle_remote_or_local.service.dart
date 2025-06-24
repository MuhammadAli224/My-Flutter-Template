import 'package:dartz/dartz.dart';

import '../constant/app_strings.dart';
import '../errors/dio_exception.dart';
import '../errors/failure.dart';
import '../function/handle_repo_error.dart';
import '../model/api_response.dart';

typedef RemoteFetcher<T> = Future<ApiResponse<T>> Function();
typedef LocalFetcher<T> = Future<T?> Function();
typedef LocalSaver<T> = Future<void> Function(T data);

class RepositoryUtils {
  static Future<Either<Failure, ApiResponse<T>>> handleRemoteOrLocal<T>({
    required Future<bool> isConnected,
    RemoteFetcher<T>? remoteFetcher,
    LocalFetcher<T>? localFetcher,
    LocalSaver<T>? localSaver,
    bool remoteOnly = false,
    bool localOnly = false,
    String noConnectionMessage = AppStrings.socketException,
  }) async {
    try {
      final hasConnection = await isConnected;

      if (localOnly) {
        final localData = await localFetcher?.call();
        if (localData != null) {
          return Right(
            ApiResponse(success: true, data: localData, message: '', code: 200),
          );
        } else {
          return Left(ServerFailure(message: 'No local data available'));
        }
      }

      if (remoteOnly || hasConnection) {
        final remoteData = await remoteFetcher?.call();
        if (remoteData == null) {
          return Left(ServerFailure(message: 'Remote fetcher not provided'));
        }

        if (remoteData.success && remoteData.data != null) {
          if (localSaver != null) {
            await localSaver(remoteData.data as T);
          }
          return Right(remoteData);
        } else {
          return Left(ServerFailure(message: remoteData.message));
        }
      }

      final localData = await localFetcher?.call();
      if (localData != null) {
        return Right(
          ApiResponse(success: true, data: localData, message: '', code: 200),
        );
      }

      return Left(ServerFailure(message: noConnectionMessage));
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }
}
