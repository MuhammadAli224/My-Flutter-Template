# Feature structure

The directory names match the executable Mason brick:

```text
lib/feature/{name}/
├── data/
│   ├── datasources/{name}/
│   │   ├── remote_{name}_data_source.dart
│   │   └── local_{name}_data_source.dart  (implementation only with caching)
│   ├── endpoint/{name}_endpoint.dart
│   ├── model/{name}_dto.dart
│   └── repository/{name}_repository_impl.dart
├── domain/
│   ├── entities/{name}_entity.dart
│   ├── repository/{name}_repository.dart
│   └── usecases/get_{name}_use_case.dart
├── di/{name}_di.dart
├── presentation/{name}/
│   ├── cubit/{name}_cubit.dart
│   ├── cubit/{name}_state.dart
│   ├── pages/{name}_page.dart
│   └── widget/{name}_widget.dart
└── {name}_barrel.dart
```

The barrel exposes domain, page, and DI contracts only. Local persistence is optional.
