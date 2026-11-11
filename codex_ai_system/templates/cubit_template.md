# Cubit request template

Use the concrete Freezed declarations/imports in the Mason brick. Every asynchronous
feature operation follows this shape:

```dart
Future<void> fetchItems() async {
  if (isClosed) return;
  final request = beginRequest('fetch');
  safeEmit(const ProductsState.loading());
  try {
    final result = await useCase(cancellation: request);
    if (!isCurrentRequest('fetch', request)) return;
    result.fold(
      (failure) => safeEmit(ProductsState.error(failure.message)),
      (items) => safeEmit(ProductsState.loaded(items)),
    );
  } finally {
    finishRequest('fetch', request);
  }
}
```

Apply CubitLifecycleMixin. Loaded states contain entities, not DTOs or ApiResponse.
Use cases return Either results. Verify disposal and overlapping requests.
