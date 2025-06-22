part of '{{name.snakeCase()}}_cubit.dart';

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const factory {{name.pascalCase()}}State.initial() = {{name.pascalCase()}}Initial;
  const factory {{name.pascalCase()}}State.loading() = {{name.pascalCase()}}Loading;
  const factory {{name.pascalCase()}}State.loaded(List<{{name.pascalCase()}}Entity> items) = {{name.pascalCase()}}Loaded;
  const factory {{name.pascalCase()}}State.error(String message) = {{name.pascalCase()}}Error;
}

