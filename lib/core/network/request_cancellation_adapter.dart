import 'package:dio/dio.dart';

import '../domain/request_cancellation.dart';

Future<T> withRequestCancellation<T>(
  RequestCancellation? cancellation,
  Future<T> Function(CancelToken token) action,
) async {
  final token = CancelToken();
  void cancel() => token.cancel('Request cancelled');
  cancellation?.addListener(cancel);
  try {
    if (token.isCancelled) throw token.cancelError!;
    return await action(token);
  } finally {
    cancellation?.removeListener(cancel);
  }
}
