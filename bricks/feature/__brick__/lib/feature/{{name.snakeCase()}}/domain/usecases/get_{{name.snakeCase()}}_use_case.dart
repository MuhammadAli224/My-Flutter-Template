import '../../../../global_imports.dart';


class Get{{name.pascalCase()}}UseCase {
final {{name.pascalCase()}}Repository _repository;
Get{{name.pascalCase()}}UseCase(this._repository);

Future<Either<Failure, ApiResponse<{{name.pascalCase()}}Entity>>> call(CancelToken? cancelToken) {
return _repository.fetchAll(cancelToken:cancelToken);
}
}
