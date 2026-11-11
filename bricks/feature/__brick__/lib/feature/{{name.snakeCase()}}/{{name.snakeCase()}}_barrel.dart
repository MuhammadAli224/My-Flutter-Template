// Public feature API. Data implementation types stay private to the feature.
export 'di/{{name.snakeCase()}}_di.dart';
export 'domain/entities/{{name.snakeCase()}}_entity.dart';
export 'domain/repository/{{name.snakeCase()}}_repository.dart';
export 'domain/usecases/get_{{name.snakeCase()}}_use_case.dart';
export 'presentation/{{name.snakeCase()}}/pages/{{name.snakeCase()}}_page.dart';
