import '../../global_imports.dart';

Either<Failure, T> handleRepoDataError<T>(Object e) {
  if (e is DioException) {
    if (CancelToken.isCancel(e)) {
      return left(ServerFailure(message: "Request was cancelled"));
    }
    return left(ServerFailure.fromDioError(e));
  }
  logger.e(
    "Error is : $e",
    stackTrace: StackTrace.current,
    error: e,
  );
  if (e is HiveError) {
    return left(ServerFailure.fromHiveError(e));
  }

  return left(ServerFailure(message: e.toString()));
}
