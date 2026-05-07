# Model & Cache Rules

## Models

- All DTOs must use Freezed.
- All Entities must use Freezed.
- Do not use raw `Map<String, dynamic>` in UI/state.
- DTOs represent API/cache data only.
- Entities represent domain/UI-safe data only.

## DTO rules

DTOs must support:

- `freezed`
- `json_serializable`
- Hive caching when local cache is needed

When a DTO is cached, it must use:

```dart
@HiveType(typeId: uniqueTypeId)
@HiveField(index)
```

## Hive rules

- Use Hive type annotations in DTOs that need local cache.
- Register/open Hive boxes only through `core/services/hive.service.dart`.
- Do not open Hive boxes randomly in features.
- Do not duplicate Hive initialization logic.
- Local datasource must use the centralized Hive service.

## Cache rules

- Use local datasource only for features that need offline/cache behavior.
- Use `CacheHelper` when cache validation is needed.
- Cache validation should consider `cachedAt` and `languageCode` when applicable.
- Live/search/realtime features should skip cache unless explicitly requested.
