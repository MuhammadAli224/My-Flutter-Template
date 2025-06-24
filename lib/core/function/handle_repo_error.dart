import '../../global_imports.dart';

Either<Failure, T> handleRepoDataError<T>(Object e, StackTrace t) {
  logger.e(
    "Error is : $e, "
    "StackTrace is : $t",
    stackTrace: StackTrace.current,
    error: e,
  );
  if (e is DioException) {
    if (CancelToken.isCancel(e)) {
      return left(ServerFailure(message: "Request was cancelled"));
    }
    return left(ServerFailure.fromDioError(e));
  }

  if (e is HiveError) {
    return left(ServerFailure.fromHiveError(e));
  }

  return left(ServerFailure(message: e.toString()));
}
