# Architecture rules

Required feature flow:

```text
UI → Cubit → UseCase → Repository interface
                           ↑
                    RepositoryImpl → Datasources → API / Cache
```

- Features live in `lib/feature/`. Match the Mason structure and feature template.
- UI does not call repositories, datasources, storage, or APIs.
- Business Cubits call use cases; session/settings infrastructure adapters may wrap
  their dedicated services directly without artificial pass-through use cases.
- Domain imports must be explicit. No Flutter, Dio, Hive, GetIt, localization,
  global_imports.dart, data, or presentation dependencies in domain code.
- Repositories return `Either<Failure, Entity>` or `Either<Failure, List<Entity>>`.
  Add a pure domain pagination value when pagination is needed.
- ApiResponse stays in remote/data code. DTOs never reach presentation.
- Repository implementations coordinate data sources and mapping.
- Use RequestCancellation in domain signatures; adapt it to Dio in data/network code.
- Keep GetIt lookups in DI, bootstrap, or widget-provider composition only.
- Feature barrels export public domain/page/DI contracts, never data implementations.
- Shared contracts belong in focused core folders such as session, domain, or cache.
  Shared widgets belong in core/widget. Do not put feature-specific business logic
  into core just because two files need it.
- Existing global barrels are legacy convenience imports. New domain code must not
  use them, and new features must not be added to global_imports.dart.
