import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/{{name.snakeCase()}}_entity.dart';
import '{{name.snakeCase()}}_dto.auto_mappr.dart';

part '{{name.snakeCase()}}_dto.freezed.dart';
part '{{name.snakeCase()}}_dto.g.dart';

@freezed
abstract class {{name.pascalCase()}}DTO with _${{name.pascalCase()}}DTO {
  const factory {{name.pascalCase()}}DTO({
    required String name,
    required String image,
    String? description,
  }) = _{{name.pascalCase()}}DTO;

  factory {{name.pascalCase()}}DTO.fromJson(Map<String, dynamic> json) =>
      _${{name.pascalCase()}}DTOFromJson(json);
}

@AutoMappr([
  MapType<{{name.pascalCase()}}DTO, {{name.pascalCase()}}Entity>(),
])
class {{name.pascalCase()}}Mapper extends ${{name.pascalCase()}}Mapper {}
