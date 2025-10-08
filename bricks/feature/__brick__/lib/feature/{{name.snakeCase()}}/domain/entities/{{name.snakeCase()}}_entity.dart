import '../../../../global_imports.dart';


part '{{name.snakeCase()}}_entity.freezed.dart';

@freezed
abstract class {{name.pascalCase()}}Entity with _${{name.pascalCase()}}Entity {
const factory {{name.pascalCase()}}Entity({

required String name,
required String image,
String? description,

}) = _{{name.pascalCase()}}Entity;
}
