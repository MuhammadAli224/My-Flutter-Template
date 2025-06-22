import '../../../../global_imports.dart';


class {{name.pascalCase()}}UseCase {
final {{name.pascalCase()}}Repository repository;
{{name.pascalCase()}}UseCase(this.repository);

Future<Either<Failure, ApiResponse<{{name.pascalCase()}}Entity>>> call(CancelToken? cancelToken) {
return repository.fetchAll(cancelToken:cancelToken);
}
}
