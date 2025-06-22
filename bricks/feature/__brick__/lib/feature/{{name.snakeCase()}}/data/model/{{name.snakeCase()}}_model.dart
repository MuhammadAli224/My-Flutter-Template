import '../../../../global_imports.dart';


part '{{name.snakeCase()}}_model.freezed.dart';

part '{{name.snakeCase()}}_model.g.dart';

@freezed
class {{name.pascalCase()}}Model with _${{name.pascalCase()}}Model {
const factory {{name.pascalCase()}}Model({
@JsonKey(name: "name") required String name,
@JsonKey(name: "image") required String image,
@JsonKey(name: "descreption") String? description,
}) = _{{name.pascalCase()}}Model;

factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) =>
_${{name.pascalCase()}}ModelFromJson(json);
}
