class CacheContext {
  const CacheContext({required this.scope, this.languageCode});

  final String scope;
  final String? languageCode;

  String key(String resource) =>
      Uri(pathSegments: [scope, languageCode ?? '', resource]).toString();

  bool matches(CacheContext other) =>
      scope == other.scope && languageCode == other.languageCode;
}

class CacheEntry<T> {
  const CacheEntry({
    required this.value,
    required this.cachedAt,
    required this.context,
  });

  final T value;
  final DateTime cachedAt;
  final CacheContext context;

  bool isValid(CacheContext expected, DateTime now, Duration maxAge) {
    final age = now.difference(cachedAt);
    return context.matches(expected) && !age.isNegative && age < maxAge;
  }
}
