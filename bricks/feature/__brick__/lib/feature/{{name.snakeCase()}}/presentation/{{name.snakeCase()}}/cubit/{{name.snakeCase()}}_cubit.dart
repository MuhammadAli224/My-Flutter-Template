import '../../../../../global_imports.dart';

part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_cubit.freezed.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> with CubitLifecycleMixin<{{name.pascalCase()}}State> {
final Get{{name.pascalCase()}}UseCase _get{{name.pascalCase()}}UseCase;

{{name.pascalCase()}}Cubit(this._get{{name.pascalCase()}}UseCase) : super(const {{name.pascalCase()}}State.initial());

Future<void> fetchItems() async {
  emit(const {{name.pascalCase()}}State.loading());


final  result =
await _get{{name.pascalCase()}}UseCase(cancelToken);
if (isClosed) return;
// result.fold(
// (failure) => safeEmit({{name.pascalCase()}}State.error(failure.message)),
// ({{name.camelCase()}}) => safeEmit({{name.pascalCase()}}State.loaded({{name.camelCase()}})),
// );
}
  }



