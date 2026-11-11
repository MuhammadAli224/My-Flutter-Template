import 'package:dartz/dartz.dart';

import '../../../../core/domain/request_cancellation.dart';
import '../../../../core/errors/failure.dart';
import '../entities/{{name.snakeCase()}}_entity.dart';

abstract interface class {{name.pascalCase()}}Repository {
  Future<Either<Failure, List<{{name.pascalCase()}}Entity>>> fetchAll({
    RequestCancellation? cancellation,
  });
}
