import 'package:dartz/dartz.dart';

import '../../../../core/domain/request_cancellation.dart';
import '../../../../core/errors/failure.dart';
import '../entities/{{name.snakeCase()}}_entity.dart';
import '../repository/{{name.snakeCase()}}_repository.dart';

class Get{{name.pascalCase()}}UseCase {
  Get{{name.pascalCase()}}UseCase(this._repository);

  final {{name.pascalCase()}}Repository _repository;

  Future<Either<Failure, List<{{name.pascalCase()}}Entity>>> call({
    RequestCancellation? cancellation,
  }) => _repository.fetchAll(cancellation: cancellation);
}
