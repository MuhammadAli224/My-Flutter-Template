import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/mixin/cubit_lifecycle_mixin.dart';
import '../../../domain/entities/{{name.snakeCase()}}_entity.dart';
import '../../../domain/usecases/get_{{name.snakeCase()}}_use_case.dart';

part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_cubit.freezed.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State>
    with CubitLifecycleMixin<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Cubit(this._useCase)
      : super(const {{name.pascalCase()}}State.initial());

  final Get{{name.pascalCase()}}UseCase _useCase;

  Future<void> fetchItems() async {
    if (isClosed) return;
    final request = beginRequest('fetch');
    safeEmit(const {{name.pascalCase()}}State.loading());
    try {
      final result = await _useCase(cancellation: request);
      if (!isCurrentRequest('fetch', request)) return;
      result.fold(
        (failure) => safeEmit({{name.pascalCase()}}State.error(failure.message)),
        (items) => safeEmit({{name.pascalCase()}}State.loaded(items)),
      );
    } finally {
      finishRequest('fetch', request);
    }
  }
}
