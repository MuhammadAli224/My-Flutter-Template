# DTO Template

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part '{name}_dto.freezed.dart';
part '{name}_dto.g.dart';

@freezed
@HiveType(typeId: uniqueTypeId)
class {Name}DTO with _${Name}DTO {
  const factory {Name}DTO({
    @HiveField(0) int? id,
    @HiveField(1) String? title,
    @HiveField(2) DateTime? cachedAt,
    @HiveField(3) String? languageCode,
  }) = _{Name}DTO;

  factory {Name}DTO.fromJson(Map<String, dynamic> json) =>
      _${Name}DTOFromJson(json);
}
```

Rules:

- Replace `uniqueTypeId` with a real unused Hive type id.
- Add every field with a unique `@HiveField(index)`.
- Do not expose this DTO to UI.
