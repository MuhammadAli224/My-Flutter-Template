import '../../../../core/cache/cache_entry.dart';
import '../../../../core/constant/box_key.dart';
import '../../../../core/dependencies/dependencies_injection.dart';
import '../../../../core/session/session_reader.dart';
import '../data/datasources/{{name.snakeCase()}}/remote_{{name.snakeCase()}}_data_source.dart';
{{#with_cache}}
import '../data/datasources/{{name.snakeCase()}}/local_{{name.snakeCase()}}_data_source.dart';
{{/with_cache}}
import '../data/repository/{{name.snakeCase()}}_repository_impl.dart';
import '../domain/repository/{{name.snakeCase()}}_repository.dart';
import '../domain/usecases/get_{{name.snakeCase()}}_use_case.dart';
import '../presentation/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_cubit.dart';
import 'package:hive_ce/hive.dart';

void init{{name.pascalCase()}}DI() {
  getIt.registerLazySingleton<{{name.pascalCase()}}RemoteDataSource>(
    () => {{name.pascalCase()}}RemoteDataSourceImpl(getIt()),
  );
{{#with_cache}}
  getIt.registerLazySingleton<{{name.pascalCase()}}LocalDataSource>(
    () => {{name.pascalCase()}}LocalDataSourceImpl(
      getIt<Box>(instanceName: BoxKey.cacheBox),
    ),
  );
{{/with_cache}}
  getIt.registerLazySingleton<{{name.pascalCase()}}Repository>(
    () => {{name.pascalCase()}}RepositoryImpl(
      remote: getIt(),
      networkInfo: getIt(),
{{#with_cache}}
      local: getIt(),
{{/with_cache}}
      cacheContext: () => CacheContext(
        scope: getIt<SessionReader>().cacheScope,
        languageCode: getIt<Box>(instanceName: BoxKey.appBox)
            .get(BoxKey.languageCode, defaultValue: 'ar') as String,
      ),
    ),
  );
  getIt.registerLazySingleton<Get{{name.pascalCase()}}UseCase>(
    () => Get{{name.pascalCase()}}UseCase(getIt()),
  );
  getIt.registerFactory<{{name.pascalCase()}}Cubit>(
    () => {{name.pascalCase()}}Cubit(getIt()),
  );
}
