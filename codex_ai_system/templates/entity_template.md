# Entity Template

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{name}_entity.freezed.dart';

@freezed
class {Name}Entity with _${Name}Entity {
  const factory {Name}Entity({
    int? id,
    String? title,
  }) = _{Name}Entity;
}
```

Rules:

- Entity must stay pure.
- No JSON logic.
- No Hive annotations.
- No API/cache logic.
