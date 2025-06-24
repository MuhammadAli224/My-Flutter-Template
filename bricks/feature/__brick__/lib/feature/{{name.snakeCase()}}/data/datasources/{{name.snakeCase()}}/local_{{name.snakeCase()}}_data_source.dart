import '../../../../../global_imports.dart';

abstract class {{name.pascalCase()}}LocalDataSource {
Future<{{name.pascalCase()}}DTO?> get{{name.pascalCase()}}({bool Function({{name.pascalCase()}}DTO p1)? query});
}

class {{name.pascalCase()}}LocalDataSourceImpl extends {{name.pascalCase()}}LocalDataSource {
final Box<{{name.pascalCase()}}DTO> _box;

{{name.pascalCase()}}LocalDataSourceImpl(this._box);


@override
Future<{{name.pascalCase()}}DTO?> get{{name.pascalCase()}}({bool Function({{name.pascalCase()}}DTO p1)? query}) async {

final {{name.camelCase()}} = _box.values.cast<{{name.pascalCase()}}DTO?>().firstWhere(
(model) => (query == null ||
(model != null && query(model))),
orElse: () => null);

return {{name.camelCase()}};

}

}