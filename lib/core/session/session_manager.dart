import 'dart:async';

import 'session.dart';
import 'session_reader.dart';
import 'session_store.dart';

/// App-scoped owner of the active in-memory session.
class SessionManager implements SessionReader {
  SessionManager(this._store, {Future<void> Function()? clearCache})
    : _clearCache = clearCache;

  final SessionStore _store;
  final Future<void> Function()? _clearCache;
  final _changes = StreamController<Session?>.broadcast(sync: true);
  Future<void> _pending = Future<void>.value();
  Future<void>? _initialization;
  Session? _current;
  String _cacheScope = 'anonymous';
  int _revision = 0;
  final String _instance = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Session? get current => _current;

  @override
  Stream<Session?> get changes => _changes.stream;

  @override
  String get cacheScope => _cacheScope;

  Future<void> initialize() => _initialization ??= _enqueue(() async {
    var restored = await _store.read();
    if (restored != null && restored.cacheId == null) {
      restored = Session(
        accessToken: restored.accessToken,
        accountId: restored.accountId,
        cacheId: _newScope(),
      );
      await _store.write(restored);
    }
    // Remembered sessions retain their namespace for offline use after restart.
    _publish(restored);
  });

  Future<void> saveToken(
    String token, {
    bool rememberMe = true,
    String? accountId,
  }) async {
    if (token.trim().isEmpty) throw ArgumentError.value(token, 'token');
    await initialize();
    await _enqueue(() async {
      final session = Session(
        accessToken: token,
        accountId: accountId,
        cacheId: _newScope(),
      );
      if (rememberMe) {
        await _store.write(session);
      } else {
        // Remove credentials from a previous remembered account as well.
        await _store.clear();
      }
      await _invalidateCache();
      _publish(session);
    });
  }

  Future<void> logout() async {
    await initialize();
    await _enqueue(() async {
      // Revoke the in-memory session even if persistent deletion fails.
      _publish(null);
      try {
        await _store.clear();
      } finally {
        await _invalidateCache();
      }
    });
  }

  Future<void> _invalidateCache() async {
    try {
      await _clearCache?.call();
    } catch (_) {
      // Rotating the scope isolates old entries even when physical cleanup fails.
    }
  }

  String _newScope() => '$_instance:${++_revision}';

  void _publish(Session? session) {
    _current = session;
    _cacheScope = session?.cacheId ?? _newScope();
    _changes.add(session);
  }

  Future<void> _enqueue(Future<void> Function() action) {
    final operation = _pending.then((_) => action());
    // A failed operation must not prevent subsequent logout/sign-in attempts.
    _pending = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace __) {},
    );
    return operation;
  }

  Future<void> dispose() async {
    await _pending;
    await _changes.close();
  }
}
