# Repository Template

```dart
class {Name}RepositoryImpl implements {Name}Repository {
  {Name}RepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final {Name}RemoteDataSource _remoteDataSource;
  final {Name}LocalDataSource _localDataSource;

  @override
  Future<Either<Failure, ApiResponse<{Name}Entity>>> fetch() async {
    // 1. read cache if needed
    // 2. fetch remote if needed
    // 3. save DTO to cache
    // 4. map DTO to Entity
    // 5. return ApiResponse<Entity>
  }
}
```

Rules:

- Mapping happens here.
- Datasources return DTOs.
- Repository returns Entities.
- Handle cache only here or local datasource/helper layer.
