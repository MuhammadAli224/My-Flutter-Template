import 'dart:async';

import '../../global_imports.dart';

mixin CubitLifecycleMixin<S> on Cubit<S> {
  late final CancelToken cancelToken = CancelToken();
  final Map<String, Timer> _debounceTimers = {};
  final Map<String, CancelToken> _paginationTokens = {};

  void safeEmit(S state) {
    if (!isClosed) emit(state);
  }

  Future<T?> withRetry<T>({
    required Future<T> Function() action,
    int maxRetries = 2,
    Duration delayBetween = const Duration(seconds: 2),
  }) async {
    int attempts = 0;
    while (attempts <= maxRetries) {
      try {
        return await action();
      } catch (e) {
        if (attempts >= maxRetries) rethrow;
        await Future.delayed(delayBetween);
        attempts++;
      }
    }
    return null;
  }

  void debounce({
    required String id,
    required Duration duration,
    required VoidCallback action,
  }) {
    _debounceTimers[id]?.cancel();
    _debounceTimers[id] = Timer(duration, action);
  }

  CancelToken getPaginationToken(String key) {
    _paginationTokens[key]?.cancel("Previous pagination cancelled");
    final token = CancelToken();
    _paginationTokens[key] = token;
    return token;
  }

  @override
  Future<void> close() {
    cancelToken.cancel("Cubit was closed");
    for (var timer in _debounceTimers.values) {
      timer.cancel();
    }
    for (var token in _paginationTokens.values) {
      token.cancel();
    }
    return super.close();
  }
}
