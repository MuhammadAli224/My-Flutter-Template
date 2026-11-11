# Entity template

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required String name,
    required String image,
    String? description,
  }) = _ProductEntity;
}
```

Pure business data only. No JSON, Hive, Flutter, or API/cache logic.
