import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChange;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async => await _hasInternet();

  @override
  Stream<bool> get onConnectionChange async* {
    yield await isConnected;
    yield* connectivity.onConnectivityChanged.asyncMap(
          (_) async => await _hasInternet(),
    );
  }

  Future<bool> _hasInternet() async {
    final results = await connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.none)) return false;
    if (results.contains(ConnectivityResult.bluetooth)) return false;

    try {
      final lookup = await InternetAddress.lookup('google.com');
      return lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
