import 'package:dartz/dartz.dart';

import '../../../../core/cache/cache_entry.dart';
import '../../../../core/cache/cache_policy.dart';
import '../../../../core/domain/request_cancellation.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/network/request_cancellation_adapter.dart';
import '../../../../core/services/cache_helper.dart';
import '../../domain/entities/{{name.snakeCase()}}_entity.dart';
import '../../domain/repository/{{name.snakeCase()}}_repository.dart';
import '../datasources/{{name.snakeCase()}}/remote_{{name.snakeCase()}}_data_source.dart';
{{#with_cache}}
import '../datasources/{{name.snakeCase()}}/local_{{name.snakeCase()}}_data_source.dart';
{{/with_cache}}
import '../model/{{name.snakeCase()}}_dto.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  {{name.pascalCase()}}RepositoryImpl({
    required {{name.pascalCase()}}RemoteDataSource remote,
    required NetworkInfo networkInfo,
    required CacheContext Function() cacheContext,
{{#with_cache}}
    required {{name.pascalCase()}}LocalDataSource local,
{{/with_cache}}
  }) : _remote = remote,
       _networkInfo = networkInfo,
       _cacheContext = cacheContext{{#with_cache}},
       _local = local{{/with_cache}};

  final {{name.pascalCase()}}RemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final CacheContext Function() _cacheContext;
{{#with_cache}}
  final {{name.pascalCase()}}LocalDataSource _local;
{{/with_cache}}

  @override
  Future<Either<Failure, List<{{name.pascalCase()}}Entity>>> fetchAll({
    RequestCancellation? cancellation,
  }) {
    final context = _cacheContext();
    return CacheHelper.fetchListWithCache<{{name.pascalCase()}}DTO, {{name.pascalCase()}}Entity>(
      policy: CachePolicy.{{#with_cache}}cacheFirst{{/with_cache}}{{^with_cache}}networkOnly{{/with_cache}},
      context: context,
      cancellation: cancellation,
      currentContext: _cacheContext,
      networkInfo: _networkInfo,
{{#with_cache}}
      getLocal: () => _local.read(context.key('{{name.snakeCase()}}')),
      saveLocal: (entry) => _local.write(context.key('{{name.snakeCase()}}'), entry),
{{/with_cache}}
{{^with_cache}}
      getLocal: () async => null,
      saveLocal: (_) async {},
{{/with_cache}}
      fetchRemote: () => withRequestCancellation(
        cancellation,
        (token) => _remote.fetchAll(cancelToken: token),
      ),
      mapper: (dtos) => dtos
          .map((dto) => {{name.pascalCase()}}Mapper()
              .convert<{{name.pascalCase()}}DTO, {{name.pascalCase()}}Entity>(dto))
          .toList(),
    );
  }
}
