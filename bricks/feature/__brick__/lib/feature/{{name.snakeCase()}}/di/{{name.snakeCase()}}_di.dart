
import '../../../../global_imports.dart';


void init{{name.pascalCase()}}DI() {
  getIt.registerLazySingleton < {{name.pascalCase()}}RemoteDataSource > (() =>
  {{name.pascalCase()}}RemoteDataSourceImpl(
      getIt(),getIt()));

  getIt.registerLazySingleton < {{name.pascalCase()}}LocalDataSource > (() =>
  {{name.pascalCase()}}LocalDataSourceImpl(
  getIt()));

  getIt.registerLazySingleton<{{name.pascalCase()}}Repository>(
  () => {{name.pascalCase()}}RepositoryImpl(remote: getIt(),local: getIt(),networkInfo:getIt()));

  getIt.registerLazySingleton<Get{{name.pascalCase()}}UseCase>(
  () => Get{{name.pascalCase()}}UseCase(getIt()),
  );


  getIt.registerFactory(() => {{name.pascalCase()}}Cubit
  (
  getIt
  (
  )
  )
  );
}