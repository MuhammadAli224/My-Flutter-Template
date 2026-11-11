import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/request_cancellation.dart';

mixin CubitLifecycleMixin<S> on Cubit<S> {
  final Map<String, Timer> _debounceTimers = {};
  final Map<String, RequestCancellation> _requests = {};

  void safeEmit(S state) {
    if (!isClosed) emit(state);
  }

  /// Latest request wins for each operation key.
  RequestCancellation beginRequest(String key) {
    _requests.remove(key)?.cancel();
    final request = RequestCancellation();
    if (isClosed) {
      request.cancel();
    } else {
      _requests[key] = request;
    }
    return request;
  }

  bool isCurrentRequest(String key, RequestCancellation request) =>
      !isClosed && !request.isCancelled && identical(_requests[key], request);

  void finishRequest(String key, RequestCancellation request) {
    if (identical(_requests[key], request)) _requests.remove(key);
  }

  void debounce({
    required String id,
    required Duration duration,
    required void Function() action,
  }) {
    if (isClosed) return;
    _debounceTimers[id]?.cancel();
    _debounceTimers[id] = Timer(duration, () {
      _debounceTimers.remove(id);
      if (!isClosed) action();
    });
  }

  @override
  Future<void> close() {
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    for (final request in _requests.values) {
      request.cancel();
    }
    _requests.clear();
    _debounceTimers.clear();
    return super.close();
  }
}
