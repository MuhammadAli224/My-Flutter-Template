import '../../../../global_imports.dart';

abstract class {{name.pascalCase()}}Repository {
Future<Either<Failure, ApiResponse<{{name.pascalCase()}}Entity>>> fetchAll({CancelToken? cancelToken});

}
