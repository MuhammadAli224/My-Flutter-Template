{{#with_cache}}
import 'package:hive_ce/hive.dart';

import '../../../../../core/cache/cache_entry.dart';
import '../../model/{{name.snakeCase()}}_dto.dart';

abstract interface class {{name.pascalCase()}}LocalDataSource {
  Future<CacheEntry<List<{{name.pascalCase()}}DTO>>?> read(String key);
  Future<void> write(String key, CacheEntry<List<{{name.pascalCase()}}DTO>> entry);
}

class {{name.pascalCase()}}LocalDataSourceImpl
    implements {{name.pascalCase()}}LocalDataSource {
  {{name.pascalCase()}}LocalDataSourceImpl(this._box);

  final Box<dynamic> _box;

  @override
  Future<CacheEntry<List<{{name.pascalCase()}}DTO>>?> read(String key) async {
    final value = _box.get(key);
    if (value == null) return null;
    final json = Map<String, dynamic>.from(value as Map);
    return CacheEntry(
      value: (json['payload'] as List)
          .map((item) => {{name.pascalCase()}}DTO.fromJson(
            Map<String, dynamic>.from(item as Map),
          ))
          .toList(),
      cachedAt: DateTime.parse(json['cachedAt'] as String),
      context: CacheContext(
        scope: json['scope'] as String,
        languageCode: json['languageCode'] as String?,
      ),
    );
  }

  @override
  Future<void> write(
    String key,
    CacheEntry<List<{{name.pascalCase()}}DTO>> entry,
  ) => _box.put(key, {
    'payload': entry.value.map((item) => item.toJson()).toList(),
    'cachedAt': entry.cachedAt.toIso8601String(),
    'scope': entry.context.scope,
    'languageCode': entry.context.languageCode,
  });
}
{{/with_cache}}
