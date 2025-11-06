import '../../../../global_imports.dart';


part '{{name.snakeCase()}}_dto.freezed.dart';

part '{{name.snakeCase()}}_dto.g.dart';

@freezed
abstract class {{name.pascalCase()}}DTO with _${{name.pascalCase()}}DTO {
const factory {{name.pascalCase()}}DTO({
@JsonKey(name: "name") required String name,
@JsonKey(name: "image") required String image,
@JsonKey(name: "descreption") String? description,
}) = _{{name.pascalCase()}}DTO;

factory {{name.pascalCase()}}DTO.fromJson(Map<String, dynamic> json) =>
_${{name.pascalCase()}}DTOFromJson(json);
}
@AutoMappr([
MapType<{{name.pascalCase()}}DTO, {{name.pascalCase()}}Entity>(),
MapType<{{name.pascalCase()}}Entity, {{name.pascalCase()}}DTO>(),
])
class {{name.pascalCase()}}Mapper extends ${{name.pascalCase()}}Mapper {}
