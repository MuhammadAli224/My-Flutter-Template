import '../../../../../global_imports.dart';

abstract class {{name.pascalCase()}}RemoteDataSource {
Future<ApiResponse<{{name.pascalCase()}}DTO>> get{{name.pascalCase()}}();
}

class {{name.pascalCase()}}RemoteDataSourceImpl implements {{name.pascalCase()}}RemoteDataSource {
final ApiServices _api;

{{name.pascalCase()}}RemoteDataSourceImpl(this._api);
@override
Future<ApiResponse<{{name.pascalCase()}}DTO>> get{{name.pascalCase()}}() async {

final response = await _api.getData(
{{name.pascalCase()}}Endpoint.get{{name.pascalCase()}},
);

final apiResponse= ApiResponse<{{name.pascalCase()}}DTO>.fromJson(response,(json) => {{name.pascalCase()}}DTO.fromJson(json));
return apiResponse;

}

}