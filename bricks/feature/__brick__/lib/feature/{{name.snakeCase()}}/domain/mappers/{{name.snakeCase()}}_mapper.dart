import '../../../../global_imports.dart';


extension {{name.pascalCase()}}Mapper on {{name.pascalCase()}}Model {
{{name.pascalCase()}}Entity toEntity() => {{name.pascalCase()}}Entity(
name: name,
image: image,
description: description,
);
}
extension {{name.pascalCase()}}EntityMapper on {{name.pascalCase()}}Entity {
{{name.pascalCase()}}Model toModel() => {{name.pascalCase()}}Model(
name: name,
image: image,
description: description,
);
}

extension {{name.pascalCase()}}ModelMapperList on
List
<{{name.pascalCase()}}Model> {
List<{{name.pascalCase()}}Entity> toEntity() {
return map((e) => e.toEntity()).toList();
}
}

extension {{name.pascalCase()}}EntityMapperList on
List
<{{name.pascalCase()}}Entity> {
List<{{name.pascalCase()}}Model> toModel() {
return map((e) => e.toModel()).toList();
}
}