import '../../../../../global_imports.dart';

abstract class {{name.pascalCase()}}RemoteDataSource {
Future<ApiResponse<{{name.pascalCase()}}Model>> get{{name.pascalCase()}}();
}

class {{name.pascalCase()}}RemoteDataSourceImpl implements {{name.pascalCase()}}RemoteDataSource {
final ApiServices api;
final AuthLocalDataSource _authLocalDataSource;

{{name.pascalCase()}}RemoteDataSourceImpl(this.api, this._authLocalDataSource);
@override
Future<ApiResponse<{{name.pascalCase()}}Model>> get{{name.pascalCase()}}() async {
final token = await _authLocalDataSource.getToken();
if (token == null) {
return ApiResponse(success: false, message: 'Token is null', code: 421);
}
final response = await api.getData(
{{name.pascalCase()}}Endpoint.get{{name.pascalCase()}},
language: GlobalContext.context.locale.languageCode,
);

final apiResponse= ApiResponse<{{name.pascalCase()}}Model>.fromJson(response,(json) => {{name.pascalCase()}}Model.fromJson(json));
return apiResponse;

}

}