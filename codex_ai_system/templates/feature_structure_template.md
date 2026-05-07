# Feature Structure Template

```txt
lib/feature/{feature_name}/
├── data/
│   ├── datasource/
│   │   ├── {feature_name}_remote_data_source.dart
│   │   └── {feature_name}_local_data_source.dart
│   ├── endpoint/
│   │   └── {feature_name}_endpoint.dart
│   ├── model/
│   │   └── {feature_name}_dto.dart
│   └── repository/
│       └── {feature_name}_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── {feature_name}_entity.dart
│   ├── repository/
│   │   └── {feature_name}_repository.dart
│   └── usecases/
│       └── {feature_name}_use_case.dart
├── di/
│   └── {feature_name}_di.dart
└── presentation/
    ├── cubit/
    │   ├── {feature_name}_cubit.dart
    │   └── {feature_name}_state.dart
    ├── pages/
    │   └── {feature_name}_page.dart
    └── widget/
```
