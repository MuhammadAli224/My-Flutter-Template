import '../../../../global_imports.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}RemoteDataSource _remote;
  final {{name.pascalCase()}}LocalDataSource _local;
  final NetworkInfo _networkInfo;

  {{name.pascalCase()}}RepositoryImpl({
    required NetworkInfo networkInfo,
    required {{name.pascalCase()}}RemoteDataSource remote,
    required {{name.pascalCase()}}LocalDataSource local,
  }) : _remote = remote,
       _local = local,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, ApiResponse<{{name.pascalCase()}}Entity>>> fetchAll({
    CancelToken? cancelToken,
  }) async {
    return handleRepoRequest<{{name.pascalCase()}}DTO, ApiResponse<{{name.pascalCase()}}Entity>>(
      networkInfo: _networkInfo,
      request: () => _remote.get{{name.pascalCase()}}(),
      onSuccess: (apiResponse) => apiResponse.map(
        (model) => {{name.pascalCase()}}Mapper().convert<{{name.pascalCase()}}DTO, {{name.pascalCase()}}Entity>(
          model,
        ),
      ),
    );
  }

// @override
// Future<Either<Failure, ApiResponse<{{name.pascalCase()}}Entity>>> fetchAll({
// CancelToken? cancelToken,
// required DataSource datasource,
// }) async {
// return CacheHelper.fetchWithCache<{{name.pascalCase()}}DTO, {{name.pascalCase()}}Entity>(
// datasource: datasource,
// getLocal: _local.getModel,
// saveLocal: _local.saveModel,
// fetchRemote: () => _remote.get{{name.pascalCase()}}(),
// mapper:
// (dto) =>
// {{name.pascalCase()}}Mapper().convert<{{name.pascalCase()}}DTO, {{name.pascalCase()}}Entity>(dto),
// networkInfo: _networkInfo,
// );
// }

}
