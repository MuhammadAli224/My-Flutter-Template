import '../../global_imports.dart';

Either<Failure, T> handleRepoDataError<T>(Object e, StackTrace t) {
  AppLogger.e(
    "Error is : $e, "
    "StackTrace is : $t",
    stackTrace: StackTrace.current,
    error: e,
  );
  return left(AppFailure.fromException(e, t));
}

Future<Either<Failure, TResult>> handleRepoRequest<TResponse, TResult>({
  required Future<ApiResponse<TResponse>> Function() request,
  required TResult Function(ApiResponse<TResponse> response) onSuccess,
  required NetworkInfo networkInfo,
  bool Function(ApiResponse<TResponse> response)? isSuccess,
}) async {
  try {
    if (!await networkInfo.isConnected) {
      return left(
        AppFailure(
          message: LocaleKeys.common_noInternetConnection.tr(),
          type: AppExceptionType.network,
        ),
      );
    }

    final apiResponse = await request();
    final success = isSuccess?.call(apiResponse) ?? !apiResponse.hasError;

    if (success) {
      return right(onSuccess(apiResponse));
    }

    return left(
      AppFailure.fromResponse(apiResponse.code, {
        'message': apiResponse.description,
        'error': apiResponse.error,
      }),
    );
  } catch (e, t) {
    return handleRepoDataError(e, t);
  }
}
