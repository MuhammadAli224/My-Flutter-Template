# Models and caching

- DTOs and entities use Freezed. DTOs support JSON; entities contain business data.
- Use AutoMappr for DTO-to-entity conversion in repositories.
- ApiResponse parsing and server errors stay in remote datasources.
- No DTOs or raw maps in UI/state.
- The default cache representation is a Hive map envelope containing DTO JSON,
  cachedAt, session scope, and languageCode. Metadata does not belong in API DTOs.
- Hive annotations/adapters are needed only when intentionally persisting typed DTOs.
  Keep typeIds unique and register adapters centrally before opening typed boxes.
- Open all boxes through core/services/hive.service.dart. The generated local
  datasource receives the named feature cache box through DI.
- Generate local storage only when with_cache is true.
- Use CachePolicy.networkOnly, cacheFirst, or networkFirst explicitly.
- CacheHelper validates exact Duration expiry, rejects future timestamps, and checks
  scope/locale before returning data. Empty lists are valid cached results.
- networkFirst may fall back to fresh cache on connectivity/transport failure only;
  cancellation, authorization, parsing, and server failures are not hidden by cache.
- Capture CacheContext before a request and supply a currentContext callback. A result
  from an old session/locale must not be emitted as a successful current result.
- Include resource arguments (filters, page, identifiers) in cache keys.
- Session changes rotate the cache scope and clear the shared feature cache box.
  Remembered sessions retain their opaque cache namespace after restart so offline
  data remains usable; temporary sessions do not survive restart.
- A cache read/write failure must not discard an otherwise valid network result.
