import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../session/session.dart';
import '../../session/session_manager.dart';

part 'token_cubit.freezed.dart';
part 'token_state.dart';

/// UI adapter. SessionManager owns credentials and outlives this Cubit.
class TokenCubit extends Cubit<TokenState> {
  TokenCubit(this._session, this._storage)
    : super(_stateFor(_session.current)) {
    _subscription = _session.changes.listen((session) {
      if (!isClosed) emit(_stateFor(session));
    });
  }

  final SessionManager _session;
  final FlutterSecureStorage _storage;
  late final StreamSubscription<Session?> _subscription;
  static const _fcmTokenKey = 'fcm_token';

  static TokenState _stateFor(Session? session) => session == null
      ? const TokenState.initial()
      : TokenState.loaded(session.accessToken);

  Future<void> saveToken(
    String token, {
    bool rememberMe = true,
    String? accountId,
  }) => _session.saveToken(token, rememberMe: rememberMe, accountId: accountId);

  String? get currentToken => _session.current?.accessToken;

  Future<void> saveFcmToken(String token) =>
      _storage.write(key: _fcmTokenKey, value: token);

  Future<String?> getFcmToken() => _storage.read(key: _fcmTokenKey);

  Future<void> logout() async {
    try {
      await _session.logout();
    } finally {
      await _storage.delete(key: _fcmTokenKey);
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
