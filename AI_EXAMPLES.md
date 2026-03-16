# Antigravity AI Examples

This file contains real architecture examples used in the Antigravity Flutter project.

AI agents should study these examples before generating code.

---

# Example Feature: LostFound

This feature demonstrates:

* DTO with Freezed + Hive
* AutoMappr mapping
* Remote datasource
* Local datasource
* Repository with caching
* UseCase
* Cubit
* DI registration

---

# DTO Example

Location:

```
data/model/lost_found_dto.dart
```

Responsibilities:

* API response parsing
* Hive caching
* DTO → Entity mapping

Important fields:

```
cachedAt
languageCode
```

Example structure:

```
LostFoundDTO
 ├ id
 ├ contentType
 ├ properties
 ├ cachedAt
 └ languageCode
```

DTO uses:

```
Freezed
JsonSerializable
Hive
AutoMappr
```

---

# Entity Example

Location:

```
domain/entities/lost_found_entity.dart
```

Entity contains only business data:

```
LostFoundEntity
 ├ id
 ├ contentType
 └ properties
```

Entities do not include:

```
json annotations
Hive annotations
API logic
```

---

# Remote Datasource Example

```
LostFoundRemoteDataSource
```

Responsibilities:

```
call API
parse response
return DTO
```

Example flow:

```
ApiServices.getData()
↓
ApiResponse.fromJson()
↓
LostFoundDTO
```

---

# Local Datasource Example

```
LocalLostFoundDataSource
```

Responsibilities:

```
get cached data
save cached data
clear cache
```

Cache validation uses:

```
CacheHelper.isCacheValid()
```

---

# Repository Example

```
LostFoundRepositoryImpl
```

Repository combines:

```
remote datasource
local datasource
network info
```

Repository uses:

```
CacheHelper.fetchWithCache()
```

Mapping example:

```
LostFoundMapper().convert(dto)
```

Return type:

```
Either<Failure, ApiResponse<LostFoundEntity>>
```

---

# UseCase Example

```
GetLostFoundUseCase
```

UseCase calls repository:

```
repository.fetchAll()
```

UseCases contain **no UI logic**.

---

# Cubit Example

```
LostFoundCubit
```

Cubit responsibilities:

```
call usecase
emit states
handle failures
```

Cubit flow:

```
fetchItems()
↓
emit loading
↓
call usecase
↓
emit loaded or error
```

States:

```
initial
loading
loaded
error
```

Cubit also supports:

```
CancelToken
CubitLifecycleMixin
safeEmit
```

---

# Dependency Injection Example

Feature dependencies are registered in:

```
initLostFoundDI()
```

Registered components:

```
remote datasource
local datasource
repository
usecase
cubit
```

All dependencies use **GetIt**.

---

# Key Patterns AI Must Follow

```
DTO → Entity mapping using AutoMappr
Cubit → UseCase → Repository flow
Hive caching through CacheHelper
Feature-based folder structure
Freezed models and states
```

Generated code must match this architecture.
