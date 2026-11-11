import 'session.dart';

/// Shared contract for networking and features; independent of Cubit and storage.
abstract interface class SessionReader {
  Session? get current;
  Stream<Session?> get changes;

  /// Changes on restoration, sign-in, account switching, and sign-out.
  String get cacheScope;
}
