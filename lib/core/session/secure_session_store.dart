import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'session.dart';
import 'session_store.dart';

class SecureSessionStore implements SessionStore {
  SecureSessionStore(this._storage);

  final FlutterSecureStorage _storage;
  static const _sessionKey = 'session';
  static const _legacyTokenKey = 'access_token';

  @override
  Future<Session?> read() async {
    final value = await _storage.read(key: _sessionKey);
    if (value != null) {
      final json = jsonDecode(value) as Map<String, dynamic>;
      return Session(
        accessToken: json['accessToken'] as String,
        accountId: json['accountId'] as String?,
        cacheId: json['cacheId'] as String?,
      );
    }
    final token = await _storage.read(key: _legacyTokenKey);
    return token == null ? null : Session(accessToken: token);
  }

  @override
  Future<void> write(Session session) async {
    await _storage.write(
      key: _sessionKey,
      value: jsonEncode({
        'accessToken': session.accessToken,
        'accountId': session.accountId,
        'cacheId': session.cacheId,
      }),
    );
    await _storage.delete(key: _legacyTokenKey);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _sessionKey);
    await _storage.delete(key: _legacyTokenKey);
  }
}
