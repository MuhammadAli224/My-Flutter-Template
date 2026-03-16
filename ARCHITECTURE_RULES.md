
# Antigravity Flutter Architecture Rules

This document defines the architecture rules for the Antigravity Flutter application.

All developers and AI agents must follow these rules when writing or modifying code.

The project uses:

* Feature-first architecture
* Clean Architecture
* Cubit for state management
* Freezed models
* AutoMappr for DTO ↔ Entity conversion
* Hive for local caching
* GetIt for dependency injection

---

# Architecture Layers

The application follows a strict layered architecture.

```
Presentation → Domain → Data
```

Dependencies must always point **inward**.

### Allowed dependencies

| Layer        | Can depend on |
| ------------ | ------------- |
| Presentation | Domain, Core  |
| Domain       | Core          |
| Data         | Domain, Core  |

### Forbidden dependencies

| Layer        | Cannot depend on |
| ------------ | ---------------- |
| Domain       | Flutter, UI      |
| Presentation | Datasources      |
| UI           | DTO models       |

---

# Feature-Based Structure

Every feature lives inside:

```
lib/feature/
```

Example feature:

```
feature/lost_found/
```

Feature structure:

```
lost_found/
├── data/
│   ├── datasource/
│   ├── endpoint/
│   ├── model/
│   └── repository/
├── domain/
│   ├── entities/
│   ├── repository/
│   └── usecases/
├── di/
└── presentation/
    ├── cubit/
    ├── pages/
    ├── widget/
    └── shared/
```

Each feature must be **independent**.

Shared logic belongs in:

```
lib/core/
```

---

# DTO Rules

DTOs represent API responses.

DTO files are located in:

```
data/model/
```

DTOs must:

* use Freezed
* support JSON serialization
* support Hive caching
* include AutoMappr mappings

DTOs may contain:

* JsonKey annotations
* HiveType annotations
* cache metadata

Example cache fields:

```
cachedAt
languageCode
```

DTOs must **never reach the UI layer**.

---

# Entity Rules

Entities represent **domain models**.

Entities are located in:

```
domain/entities/
```

Entities must:

* use Freezed
* contain only business data
* not contain JSON annotations
* not contain Hive annotations

Entities must remain **pure domain models**.

---

# Mapper Rules

DTO ↔ Entity mapping must use **AutoMappr**.

Mapping definitions must be inside the DTO file.

Example:

```
@AutoMappr([
  MapType<DTO, Entity>(),
  MapType<Entity, DTO>(),
])
```

Mapping usage must occur inside **repository implementations**.

---

# Datasource Rules

Two datasource types may exist.

### Remote Datasource

Responsibilities:

* perform HTTP requests
* parse API responses
* return DTO objects

Remote datasource must not:

* contain UI logic
* contain entity mapping logic

---

### Local Datasource

Responsibilities:

* read cached data
* write cached data
* clear cache

Local datasources use **Hive**.

---

# Repository Rules

Repository implementations combine:

* remote datasource
* local datasource
* network connectivity

Repositories must:

* map DTO → Entity
* handle caching
* return Either results

Return type:

```
Either<Failure, ApiResponse<Entity>>
```

Repositories must not contain UI logic.

---

# UseCase Rules

UseCases represent application actions.

Location:

```
domain/usecases/
```

UseCases must:

* call repository methods
* contain no UI logic
* contain no API logic

Example naming:

```
GetLostFoundUseCase
FetchProductsUseCase
```

---

# Cubit Rules

Cubits manage UI state.

Location:

```
presentation/cubit/
```

Cubits must:

* call UseCases
* emit states
* handle failures

Typical states:

```
initial
loading
loaded
error
```

Cubit must never call:

```
datasource
repository implementation
```

---

# Caching Rules

Caching is handled through:

```
CacheHelper.fetchWithCache()
```

Cache validation depends on:

```
cachedAt
languageCode
```

Cache flow:

```
check cache
↓
if valid → return cached data
↓
if invalid → fetch remote
↓
save to cache
↓
return mapped entity
```

---

# Dependency Injection

All dependencies are registered using **GetIt**.

Feature DI is located in:

```
feature/{feature}/di/
```

Example function:

```
initLostFoundDI()
```

Dependencies registered:

* datasource
* repository
* usecase
* cubit

---

# Error Handling

All repository calls must return:

```
Either<Failure, ApiResponse<T>>
```

Failures represent:

* network errors
* server errors
* cache errors

Cubits convert failures to UI states.

---

# Global Imports

The project uses a shared import file:

```
global_imports.dart
```

This file exports common dependencies used across the application.

---

# Feature Generation

New features are generated using **Mason**.

Example command:

```
mason make feature
```

The Mason brick generates:

* DTO
* Entity
* Mapper
* Datasources
* Repository
* UseCase
* Cubit
* State
* Page
* DI
# Antigravity Flutter Architecture Rules

This document defines the architecture rules for the Antigravity Flutter application.

All developers and AI agents must follow these rules when writing or modifying code.

The project uses:

* Feature-first architecture
* Clean Architecture
* Cubit for state management
* Freezed models
* AutoMappr for DTO ↔ Entity conversion
* Hive for local caching
* GetIt for dependency injection

---

# Architecture Layers

The application follows a strict layered architecture.

```
Presentation → Domain → Data
```

Dependencies must always point **inward**.

### Allowed dependencies

| Layer        | Can depend on |
| ------------ | ------------- |
| Presentation | Domain, Core  |
| Domain       | Core          |
| Data         | Domain, Core  |

### Forbidden dependencies

| Layer        | Cannot depend on |
| ------------ | ---------------- |
| Domain       | Flutter, UI      |
| Presentation | Datasources      |
| UI           | DTO models       |

---

# Feature-Based Structure

Every feature lives inside:

```
lib/feature/
```

Example feature:

```
feature/lost_found/
```

Feature structure:

```
lost_found/
├── data/
│   ├── datasource/
│   ├── endpoint/
│   ├── model/
│   └── repository/
├── domain/
│   ├── entities/
│   ├── repository/
│   └── usecases/
├── di/
└── presentation/
    ├── cubit/
    ├── pages/
    ├── widget/
    └── shared/
```

Each feature must be **independent**.

Shared logic belongs in:

```
lib/core/
```

---

# DTO Rules

DTOs represent API responses.

DTO files are located in:

```
data/model/
```

DTOs must:

* use Freezed
* support JSON serialization
* support Hive caching
* include AutoMappr mappings

DTOs may contain:

* JsonKey annotations
* HiveType annotations
* cache metadata

Example cache fields:

```
cachedAt
languageCode
```

DTOs must **never reach the UI layer**.

---

# Entity Rules

Entities represent **domain models**.

Entities are located in:

```
domain/entities/
```

Entities must:

* use Freezed
* contain only business data
* not contain JSON annotations
* not contain Hive annotations

Entities must remain **pure domain models**.

---

# Mapper Rules

DTO ↔ Entity mapping must use **AutoMappr**.

Mapping definitions must be inside the DTO file.

Example:

```
@AutoMappr([
  MapType<DTO, Entity>(),
  MapType<Entity, DTO>(),
])
```

Mapping usage must occur inside **repository implementations**.

---

# Datasource Rules

Two datasource types may exist.

### Remote Datasource

Responsibilities:

* perform HTTP requests
* parse API responses
* return DTO objects

Remote datasource must not:

* contain UI logic
* contain entity mapping logic

---

### Local Datasource

Responsibilities:

* read cached data
* write cached data
* clear cache

Local datasources use **Hive**.

---

# Repository Rules

Repository implementations combine:

* remote datasource
* local datasource
* network connectivity

Repositories must:

* map DTO → Entity
* handle caching
* return Either results

Return type:

```
Either<Failure, ApiResponse<Entity>>
```

Repositories must not contain UI logic.

---

# UseCase Rules

UseCases represent application actions.

Location:

```
domain/usecases/
```

UseCases must:

* call repository methods
* contain no UI logic
* contain no API logic

Example naming:

```
GetLostFoundUseCase
FetchProductsUseCase
```

---

# Cubit Rules

Cubits manage UI state.

Location:

```
presentation/cubit/
```

Cubits must:

* call UseCases
* emit states
* handle failures

Typical states:

```
initial
loading
loaded
error
```

Cubit must never call:

```
datasource
repository implementation
```

---

# Caching Rules

Caching is handled through:

```
CacheHelper.fetchWithCache()
```

Cache validation depends on:

```
cachedAt
languageCode
```

Cache flow:

```
check cache
↓
if valid → return cached data
↓
if invalid → fetch remote
↓
save to cache
↓
return mapped entity
```

---

# Dependency Injection

All dependencies are registered using **GetIt**.

Feature DI is located in:

```
feature/{feature}/di/
```

Example function:

```
initLostFoundDI()
```

Dependencies registered:

* datasource
* repository
* usecase
* cubit

---

# Error Handling

All repository calls must return:

```
Either<Failure, ApiResponse<T>>
```

Failures represent:

* network errors
* server errors
* cache errors

Cubits convert failures to UI states.

---

# Global Imports

The project uses a shared import file:

```
global_imports.dart
```

This file exports common dependencies used across the application.

---

# Feature Generation

New features are generated using **Mason**.

Example command:

```
mason make feature
```

The Mason brick generates:

* DTO
* Entity
* Mapper
* Datasources
* Repository
* UseCase
* Cubit
* State
* Page
* DI
