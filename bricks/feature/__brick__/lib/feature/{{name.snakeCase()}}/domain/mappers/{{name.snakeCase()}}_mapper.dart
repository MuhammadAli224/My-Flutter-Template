import '../../../../global_imports.dart';


extension {{name.pascalCase()}}Mapper on {{name.pascalCase()}}DTO {
{{name.pascalCase()}}Entity toEntity() => {{name.pascalCase()}}Entity(
name: name,
image: image,
description: description,
);
}
extension {{name.pascalCase()}}EntityMapper on {{name.pascalCase()}}Entity {
{{name.pascalCase()}}DTO toModel() => {{name.pascalCase()}}DTO(
name: name,
image: image,
description: description,
);
}

extension {{name.pascalCase()}}ModelMapperList on
List
<{{name.pascalCase()}}DTO> {
List<{{name.pascalCase()}}Entity> toEntity() {
return map((e) => e.toEntity()).toList();
}
}

extension {{name.pascalCase()}}EntityMapperList on
List
<{{name.pascalCase()}}Entity> {
List<{{name.pascalCase()}}DTO> toModel() {
return map((e) => e.toModel()).toList();
}
}