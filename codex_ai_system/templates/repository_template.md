# Repository contract

```dart
abstract interface class ProductsRepository {
  Future<Either<Failure, List<ProductsEntity>>> fetchAll({
    RequestCancellation? cancellation,
  });
}
```

Import dartz, Failure, RequestCancellation, and the entity explicitly.
Do not import global_imports.dart, Dio, Hive, or ApiResponse in domain code.

The implementation follows the executable Mason repository template:
capture CacheContext, select CachePolicy, call CacheHelper, map DTOs through
AutoMappr, and forward cancellation through withRequestCancellation.
Only cached variants inject a local datasource.
