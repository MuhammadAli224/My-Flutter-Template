# DTO template

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

@freezed
abstract class ProductDTO with _$ProductDTO {
  const factory ProductDTO({
    required String name,
    required String image,
    String? description,
  }) = _ProductDTO;

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);
}
```

Add the AutoMappr DTO-to-entity definition as shown in the Mason DTO template.
For standard caching, store DTO JSON inside a CacheEntry envelope through the
injected Hive box. Do not add cache metadata to the API schema.
Typed Hive persistence is optional; if chosen, use hive_ce annotations with unique
field/type IDs and centralized adapter registration. DTOs never reach UI/state.
