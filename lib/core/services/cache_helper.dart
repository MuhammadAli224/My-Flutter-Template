import '../../global_imports.dart';

typedef Mapper<DTO, Entity> = Entity Function(DTO dto);
typedef RemoteFetcher<DTO> = Future<ApiResponse<DTO>> Function();
typedef LocalGetter<DTO> = Future<DTO?> Function();
typedef LocalSaver<DTO> = Future<void> Function(DTO dto);
typedef ListMapper<DTO, Entity> = List<Entity> Function(List<DTO> dtos);
typedef LocalListGetter<DTO> = Future<List<DTO>?> Function();
typedef LocalListSaver<DTO> = Future<void> Function(List<DTO> dto);

class CacheHelper {
  static bool isCacheValid(
    DateTime? cachedAt,
    String? languageCode, {
    int maxAgeHours = 24,
  }) {
    if (cachedAt == null) return false;
    if (languageCode != null) {
      if (languageCode != GlobalContext.context.locale.languageCode) {
        return false;
      }
    } else {
      return false;
    }
    final now = DateTime.now();
    final difference = now.difference(cachedAt);
    return difference.inHours < maxAgeHours;
  }

  static Future<Either<Failure, ApiResponse<Entity>>>
  fetchWithCache<DTO, Entity>({
    required DataSource datasource,
    required LocalGetter<DTO> getLocal,
    required LocalSaver<DTO> saveLocal,
    required RemoteFetcher<DTO> fetchRemote,
    required Mapper<DTO, Entity> mapper,
    required NetworkInfo networkInfo,
    Duration cacheDuration = const Duration(hours: 24),
  }) async {
    try {
      if (datasource == DataSource.local) {
        final cached = await getLocal();
        if (cached != null) {
          return right(
            ApiResponse(description: '', code: 200, data: mapper(cached)),
          );
        }
      }

      if (!await networkInfo.isConnected) {
        final cached = await getLocal();
        if (cached != null) {
          return right(
            ApiResponse(
              description: '${mapper(cached)} (offline cached)',
              code: 200,
              data: mapper(cached),
            ),
          );
        }
        return left(ServerFailure(message: AppStrings.socketException));
      }

      final apiResponse = await fetchRemote();

      if (!apiResponse.hasError && apiResponse.data != null) {
        await saveLocal(apiResponse.data as DTO);

        return right(apiResponse.map(mapper));
      } else {
        return left(ServerFailure(message: apiResponse.description));
      }
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }

  static Future<Either<Failure, ApiResponse<Entity>>>
  fetchListWithCache<DTO, Entity>({
    required DataSource datasource,
    required LocalListGetter<DTO> getLocal,
    required LocalListSaver<DTO> saveLocal,
    required RemoteFetcher<DTO> fetchRemote,
    required ListMapper<DTO, Entity> mapper,
    required NetworkInfo networkInfo,
    Duration cacheDuration = const Duration(hours: 24),
  }) async {
    try {
      if (datasource == DataSource.local) {
        final cached = await getLocal();
        if (cached != null && cached.isNotEmpty) {
          return right(
            ApiResponse(description: '', code: 200, list: mapper(cached)),
          );
        }
      }

      if (!await networkInfo.isConnected) {
        final cached = await getLocal();
        if (cached != null && cached.isNotEmpty) {
          return right(
            ApiResponse(
              description: '${mapper(cached)} (offline cached)',
              code: 200,
              list: mapper(cached),
            ),
          );
        }
        return left(ServerFailure(message: AppStrings.socketException));
      }

      final apiResponse = await fetchRemote();

      if (!apiResponse.hasError && apiResponse.list != null) {
        await saveLocal(apiResponse.list!.cast<DTO>());

        return right(
          ApiResponse(
            description: apiResponse.description,
            code: apiResponse.code,
            list: mapper(apiResponse.list!.cast<DTO>()),
          ),
        );
      } else {
        return left(ServerFailure(message: apiResponse.description));
      }
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }
}
