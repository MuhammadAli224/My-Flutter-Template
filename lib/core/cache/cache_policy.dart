enum CachePolicy {
  /// Never read or write local cache.
  networkOnly,

  /// Return fresh cache immediately, otherwise request the network.
  cacheFirst,

  /// Request the network first; fall back to fresh cache on transport failure.
  networkFirst,
}
