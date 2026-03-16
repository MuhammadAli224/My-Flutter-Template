# Antigravity Feature Creation Rules (Generic)

This document defines how AI agents must create new features in the project.

The project follows **Feature-First Clean Architecture**.

When a new feature is requested, AI must:

1. Generate the feature structure
2. Integrate it with routing
3. Export it in global imports
4. Register dependency injection

---

# Feature Folder Structure

Every feature must be created inside:

```
lib/features/{feature_name}/
```

Structure:

```
feature_name/
├── data/
│   ├── datasource/
│   │   ├── local_{feature}_data_source.dart
│   │   └── {feature}_remote_data_source.dart
│   ├── endpoint/
│   │   └── {feature}_endpoint.dart
│   ├── model/
│   │   └── {feature}_dto.dart
│   └── repository/
│       └── {feature}_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   └── {feature}_entity.dart
│   ├── repository/
│   │   └── {feature}_repository.dart
│   └── usecases/
│       └── get_{feature}_use_case.dart
│
├── presentation/
│   ├── cubit/
│   │   ├── {feature}_cubit.dart
│   │   └── {feature}_state.dart
│   ├── pages/
│   │   └── {feature}_page.dart
│   ├── widget/
│   └── shared/
│
├── di/
│   └── {feature}_di.dart
│
└── {feature}_barrel.dart
```

---

# Barrel File

Each feature must contain a barrel file:

```
{feature}_barrel.dart
```

Example content:

```
export 'presentation/pages/{feature}_page.dart';
export 'presentation/cubit/{feature}_cubit.dart';
export 'domain/entities/{feature}_entity.dart';
```

---

# Update Global Imports

After creating the feature, AI must update:

```
global_imports.dart
```

Add:

```
export 'features/{feature}/{feature}_barrel.dart';
```

---

# Register Route Constant

AI must update:

```
core/constants/routes.dart
```

Add route:

```
static const {feature} = "/{feature}";
```

Example:

```
static const products = "/products";
```

---

# Register GoRouter Page

AI must update:

```
core/router/routes.dart
```

Add a new `GoRoute` inside the router list:

```
GoRoute(
  path: AppRoutes.{feature},
  builder: (context, state) => const {Feature}Page(),
),
```

---

# Register Dependency Injection

AI must update:

```
core/dependencies/dependencies_injection.dart
```

Add:

```
init{Feature}DI();
```

Example:

```
initProductsDI();
```

---

# Dependency Injection File

Feature DI must register:

* remote datasource
* local datasource (optional)
* repository
* use case
* cubit

Example pattern:

```
void init{Feature}DI() {

  getIt.registerLazySingleton<{Feature}RemoteDataSource>(
    () => {Feature}RemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<{Feature}Repository>(
    () => {Feature}RepositoryImpl(
      remote: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<Get{Feature}UseCase>(
    () => Get{Feature}UseCase(getIt()),
  );

  getIt.registerFactory(() => {Feature}Cubit(getIt()));
}
```

---

# DTO Rules

DTO must:

* use Freezed
* support JSON serialization
* support Hive caching if needed
* include AutoMappr mappings

---

# Entity Rules

Entities must:

* use Freezed
* contain only domain data
* not include JSON or Hive annotations

---

# Repository Rules

Repositories must:

* extend `BaseRepository`
* return `Either<Failure, ApiResponse<Entity>>`
* use `CacheHelper.fetchWithCache()` when caching is required

---

# Cubit Rules

Cubits must:

* use `CubitLifecycleMixin`
* support cancellation tokens
* emit `initial`, `loading`, `loaded`, `error` states

---

# Feature Integration Checklist

Whenever a feature is generated AI must verify:

✓ Feature folder created
✓ Barrel file created
✓ global_imports updated
✓ route constant added
✓ router page added
✓ DI registered
✓ Cubit implemented
✓ UseCase implemented

If any step is missing, the feature is considered incomplete.
