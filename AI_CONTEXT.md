# Antigravity Flutter Project – AI Context Guide

This document explains how code must be written in the Antigravity Flutter project.

AI agents and developers must follow these rules when generating or modifying code.

This project follows **Feature-First Clean Architecture** with **Cubit state management**, **Freezed models**, and **AutoMappr mapping**.

---

# Core Philosophy

The project enforces:

* strict separation between **presentation, domain, and data**
* DTO models **never reach the UI**
* Cubits interact only with **UseCases**
* UseCases interact only with **Repository interfaces**
* Repository implementations manage **remote + local data sources**
* DTO → Entity conversion uses **AutoMappr**

Architecture flow:

```
UI
 ↓
Cubit
 ↓
UseCase
 ↓
Repository (interface)
 ↓
RepositoryImpl
 ↓
Datasource
 ↓
API / Cache
```

---

# Feature Structure

All features are located inside:

```
lib/feature/
```

Each feature follows this structure:

```
feature_name/
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

Features are **independent modules**.

Shared logic belongs in:

```
lib/core/
```

---

# Feature Generation

New features are generated using **Mason**.

Command example:

```
mason make feature
```

The Mason template generates:

* DTO
* Entity
* Mapper
* Remote datasource
* Local datasource
* Repository implementation
* UseCase
* Cubit
* State
* Page
* Dependency injection

AI agents must follow the **same structure** when generating new features.

---

# DTO Models

DTO models represent **API responses**.

DTOs are built using:

* Freezed
* JsonSerializable
* Hive (for caching)

Example structure:

```
data/model/lost_found_dto.dart
```

DTOs may contain caching metadata:

```
cachedAt
languageCode
```

DTOs may also include Hive annotations:

```
@HiveType
@HiveField
```

DTOs must never be used in the UI layer.

---

# Entities

Entities represent **domain business models**.

Entities are created using **Freezed**.

Example:

```
LostFoundEntity
```

Entities must not contain:

* JSON serialization
* Hive annotations
* API logic

Entities must remain **pure domain objects**.

---

# DTO → Entity Mapping

Mapping is done using **AutoMappr**.

Example:

```
@AutoMappr([
  MapType<LostFoundDTO, LostFoundEntity>(),
  MapType<LostFoundEntity, LostFoundDTO>(),
])
```

Mapper class example:

```
class LostFoundMapper extends $LostFoundMapper {}
```

Usage:

```
LostFoundMapper().convert<LostFoundDTO, LostFoundEntity>(dto)
```

Mapping always happens inside **repository implementation**.

---

# Datasources

Two datasource types exist.

### Remote Datasource

Handles API requests.

Example:

```
LostFoundRemoteDataSource
```

Responsibilities:

* perform HTTP requests
* parse API responses
* return DTO models

Remote datasource must **not contain UI logic**.

---

### Local Datasource

Handles local caching using **Hive**.

Example:

```
LocalLostFoundDataSource
```

Responsibilities:

* read cached data
* write cached data
* clear cache

Cache validation is handled by:

```
CacheHelper.isCacheValid()
```

---

# Repository Implementation

Repository implementations combine:

* remote datasource
* local datasource
* network status

Example:

```
LostFoundRepositoryImpl
```

Repositories return:

```
Either<Failure, ApiResponse<Entity>>
```

Repositories are responsible for:

* calling datasources
* mapping DTO → Entity
* handling caching logic

Example mapping usage:

```
LostFoundMapper().convert(dto)
```

---

# Cache System

The project uses a centralized cache helper.

```
CacheHelper.fetchWithCache()
```

Flow:

```
1. check local cache
2. validate cache
3. if valid → return cached data
4. if expired → fetch remote
5. save remote result to cache
6. return entity
```

Cache validation depends on:

```
cachedAt
languageCode
```

---

# Features With Cache

Some features support **offline caching**.

Examples:

* CMS content
* settings
* static content
* informational pages

These features include:

```
LocalDatasource
Hive caching
CacheHelper
```

---

# Features Without Cache

Some features must always fetch fresh data.

Examples:

* search
* live lists
* real-time feeds

These features:

* skip local datasource
* call remote datasource directly

---

# Cubit State Management

State management uses **Cubit**.

Example:

```
LostFoundCubit
```

Cubit responsibilities:

* call usecases
* manage loading states
* handle failures
* emit states

Typical states:

```
initial
loading
loaded
error
```

States are implemented using **Freezed union types**.

---

# Cubit Lifecycle

Cubits use a lifecycle mixin:

```
CubitLifecycleMixin
```

This provides:

* cancellation tokens
* safeEmit
* protection against emitting after dispose

Example:

```
if (isClosed) return;
```

---

# Dependency Injection

Dependencies are registered inside:

```
feature/{feature}/di/
```

Example:

```
initLostFoundDI()
```

Dependencies registered:

* datasource
* repository
* usecase
* cubit

The project uses **GetIt**.

---

# Error Handling

All repository calls return:

```
Either<Failure, ApiResponse<T>>
```

Failure objects contain:

```
message
error type
```

Cubit converts failures to UI states.

---

# Global Imports

Many files use a shared import file:

```
global_imports.dart
```

This file exports common dependencies used across the project.

---

# Naming Conventions

Entities:

```
LostFoundEntity
ProductEntity
UserEntity
```

DTOs:

```
LostFoundDTO
ProductDTO
```

UseCases:

```
GetLostFoundUseCase
FetchProductsUseCase
```

Cubits:

```
LostFoundCubit
ProductsCubit
```

Repositories:

```
LostFoundRepository
LostFoundRepositoryImpl
```

---

# Forbidden Patterns

AI agents must not generate code that:

* calls API directly inside UI
* exposes DTO models to UI
* imports Flutter in domain layer
* skips UseCase layer
* accesses repository from widgets

---

# Summary

The Antigravity architecture enforces:

* Feature-first modular structure
* Strict layer separation
* DTO → Entity mapping
* Centralized caching system
* Cubit state management
* Mason feature generation
* Freezed immutable models

All generated code must follow these rules.
