import '../../global_imports.dart';

mixin CubitLifecycleMixin<S> on Cubit<S> {
  late final CancelToken cancelToken = CancelToken();

  void safeEmit(S state) {
    if (!isClosed) emit(state);
  }

  @override
  Future<void> close() {
    cancelToken.cancel("Cubit was closed");
    return super.close();
  }
}
