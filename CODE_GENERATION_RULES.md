# Antigravity Flutter – Code Generation Rules

This document defines how code must be generated in the Antigravity Flutter project.

AI agents must follow these rules when generating new code.

The project relies on the following technologies:

* Freezed (immutable models and states)
* AutoMappr (DTO ↔ Entity mapping)
* Cubit (state management)
* GetIt (dependency injection)
* Hive (local caching)
* Either + Failure (error handling)
* Mason (feature scaffolding)

---

# Model Generation Rules

## DTO Models

DTO models represent API responses.

DTOs must:

* use Freezed
* use JsonSerializable
* support Hive caching
* optionally include caching metadata

Example DTO structure:

```dart id="dto-example"
import '../../../../global_imports.dart';
import 'example_dto.auto_mappr.dart';

part 'example_dto.freezed.dart';
part 'example_dto.g.dart';

@freezed
abstract class ExampleDTO with _$ExampleDTO {
  @HiveType(typeId: 1, adapterName: "ExampleDTOAdapter")
  const factory ExampleDTO({
    @HiveField(1) @JsonKey(name: "id") String? id,
    @HiveField(2) @JsonKey(name: "name") String? name,

    // cache metadata
    @HiveField(3) DateTime? cachedAt,
    @HiveField(4) String? languageCode,
  }) = _ExampleDTO;

  factory ExampleDTO.fromJson(Map<String, dynamic> json) =>
      _$ExampleDTOFromJson(json);
}
```

DTOs must **never be used in the UI layer**.

---

# Entity Generation Rules

Entities represent domain models.

Entities must:

* use Freezed
* contain only business data
* not include JSON annotations
* not include Hive annotations

Example entity:

```dart id="entity-example"
import '../../../../global_imports.dart';

part 'example_entity.freezed.dart';

@freezed
abstract class ExampleEntity with _$ExampleEntity {
  const factory ExampleEntity({
    required String? id,
    required String? name,
  }) = _ExampleEntity;
}
```

Entities must remain **pure domain models**.

---

# Mapper Generation Rules

DTO ↔ Entity conversion must use **AutoMappr**.

Mapper definitions must be placed in the DTO file.

Example:

```dart id="mapper-example"
@AutoMappr([
  MapType<ExampleDTO, ExampleEntity>(),
  MapType<ExampleEntity, ExampleDTO>(),
])
class ExampleMapper extends $ExampleMapper {}
```

Usage example:

```dart id="mapper-usage"
ExampleMapper().convert<ExampleDTO, ExampleEntity>(dto);
```

Mapping must occur **inside repository implementations**.

---

# Datasource Generation Rules

Each feature may contain two datasource types.

### Remote Datasource

Handles API calls.

Example structure:

```dart id="remote-datasource-example"
abstract class ExampleRemoteDataSource {
  Future<ApiResponse<ExampleDTO>> fetchExample();
}

class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
  final ApiServices api;

  ExampleRemoteDataSourceImpl(this.api);

  @override
  Future<ApiResponse<ExampleDTO>> fetchExample() async {
    final response = await api.getData(ExampleEndpoint.fetch);

    return ApiResponse<ExampleDTO>.fromJson(
      response,
      (json) => ExampleDTO.fromJson(json),
    );
  }
}
```

---

### Local Datasource

Handles caching using Hive.

Example:

```dart id="local-datasource-example"
abstract class LocalExampleDataSource {
  Future<ExampleDTO?> getModel();
  Future<ExampleDTO> saveModel(ExampleDTO model);
  Future<void> clearModels();
}
```

Responsibilities:

* read cached data
* save cached data
* clear cache

---

# Repository Implementation Rules

Repository implementations must:

* combine remote and local datasource
* check network connectivity
* handle caching
* map DTO → Entity

Repositories return:

```id="repository-return-type"
Either<Failure, ApiResponse<Entity>>
```

Example structure:

```dart id="repository-example"
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDataSource remote;
  final LocalExampleDataSource local;
  final NetworkInfo networkInfo;

  ExampleRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ApiResponse<ExampleEntity>>> fetchExample({
    required DataSource datasource,
  }) {
    return CacheHelper.fetchWithCache<ExampleDTO, ExampleEntity>(
      datasource: datasource,
      getLocal: local.getModel,
      saveLocal: local.saveModel,
      fetchRemote: () => remote.fetchExample(),
      mapper: (dto) =>
          ExampleMapper().convert<ExampleDTO, ExampleEntity>(dto),
      networkInfo: networkInfo,
    );
  }
}
```

---

# UseCase Generation Rules

Each repository function must have a corresponding use case.

Example:

```dart id="usecase-example"
class GetExampleUseCase {
  final ExampleRepository repository;

  GetExampleUseCase(this.repository);

  Future<Either<Failure, ApiResponse<ExampleEntity>>> call({
    required DataSource datasource,
  }) {
    return repository.fetchExample(datasource: datasource);
  }
}
```

UseCases must contain **no UI logic**.

---

# Cubit Generation Rules

Cubits manage UI state.

Example structure:

```dart id="cubit-example"
class ExampleCubit extends Cubit<ExampleState>
    with CubitLifecycleMixin<ExampleState> {

  final GetExampleUseCase controller;

  ExampleCubit(this.controller)
      : super(const ExampleState.initial());

  Future<void> fetchItems({DataSource dataSource = DataSource.local}) async {

    emit(const ExampleState.loading());

    final result = await controller(
      cancelToken: cancelToken,
      datasource: dataSource,
    );

    if (isClosed) return;

    result.fold(
      (failure) => safeEmit(ExampleState.error(failure.message)),
      (data) => safeEmit(ExampleState.loaded(data.data!)),
    );
  }
}
```

---

# Cubit State Rules

Cubit states must use Freezed union types.

Example:

```dart id="state-example"
@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = _Initial;
  const factory ExampleState.loading() = _Loading;
  const factory ExampleState.loaded(ExampleEntity data) = _Loaded;
  const factory ExampleState.error(String message) = _Error;
}
```

States must include:

* initial
* loading
* loaded
* error

---

# Dependency Injection Rules

Each feature must register dependencies inside:

```id="di-folder"
feature/{feature}/di/
```

Example:

```dart id="di-example"
void initExampleDI() {
  getIt.registerLazySingleton<ExampleRemoteDataSource>(
    () => ExampleRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<LocalExampleDataSource>(
    () => LocalExampleDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<ExampleRepository>(
    () => ExampleRepositoryImpl(
      remote: getIt(),
      local: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<GetExampleUseCase>(
    () => GetExampleUseCase(getIt()),
  );

  getIt.registerFactory(() => ExampleCubit(getIt()));
}
```

---

# Caching Rules

Some features support caching.

These must use:

```id="cache-helper"
CacheHelper.fetchWithCache()
```

Cache validation uses:

* cachedAt
* languageCode

If cache is valid, local data should be returned.

If cache is invalid, remote data must be fetched.

---

# Non-Cached Features

Some features should **not use caching**.

Examples:

* search
* real-time data
* frequently changing lists

These features should call **remote datasource directly**.

---

# Global Imports

Many files use a shared import file:

```id="global-imports"
global_imports.dart
```

This file exports commonly used dependencies.

---

# Naming Conventions

Entities:

```id="entity-names"
ProductEntity
UserEntity
OrderEntity
```

DTOs:

```id="dto-names"
ProductDTO
UserDTO
```

UseCases:

```id="usecase-names"
GetProductsUseCase
FetchUserProfileUseCase
```

Cubits:

```id="cubit-names"
ProductsCubit
AuthCubit
```

Repositories:

```id="repo-names"
ProductsRepository
ProductsRepositoryImpl
```

---

# Forbidden Patterns

AI agents must not generate code that:

* calls API directly from UI
* exposes DTO models to UI
* imports Flutter in domain layer
* skips UseCase layer
* mixes UI logic inside repositories
