import 'dart:async';

import '../../global_imports.dart';

part 'connection_cubit.freezed.dart';
part 'connection_state.dart';

class ConnectionCubit extends Cubit<ConnectionState> {
  final NetworkInfo networkInfo;
  StreamSubscription<bool>? _connectionSubscription;

  ConnectionCubit(this.networkInfo) : super(const ConnectionInitial()) {
    _monitor();
  }

  void _monitor() {
    bool isFirstCheck = true;

    _connectionSubscription = networkInfo.onConnectionChange.listen((
      connected,
    ) {
      if (isFirstCheck) {
        isFirstCheck = false;
        emit(connected ? const ConnectionOnline() : const ConnectionOffline());
        return;
      }

      if (connected) {
        if (state is! ConnectionOnline) {
          _showConnectedBar();
        }
        emit(const ConnectionOnline());
      } else {
        _showDisconnectedBar();
        emit(const ConnectionOffline());
      }
    });
  }

  void _showConnectedBar() {
    final context = GlobalContext.navigatorKey.currentContext;
    if (context == null) return;

    showBar(
      context,
      title: context.tr(LocaleKeys.common_connected),
      message: context.tr(LocaleKeys.common_internetConnectionRestored),
      contentType: BarContentType.success,
      position: BarPosition.top,
    );
  }

  void _showDisconnectedBar() {
    final context = GlobalContext.navigatorKey.currentContext;
    if (context == null) return;

    showBar(
      context,
      title: context.tr(LocaleKeys.common_noInternet),
      message: context.tr(LocaleKeys.common_youAreOffline),
      contentType: BarContentType.failure,
      position: BarPosition.top,
    );
  }

  @override
  Future<void> close() async {
    await _connectionSubscription?.cancel();
    return super.close();
  }
}
