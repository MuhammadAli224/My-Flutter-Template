/// Active credentials. Keep this object out of persisted UI state.
class Session {
  const Session({required this.accessToken, this.accountId, this.cacheId});

  final String accessToken;
  final String? accountId;

  /// Opaque cache namespace persisted with remembered credentials.
  final String? cacheId;
}
