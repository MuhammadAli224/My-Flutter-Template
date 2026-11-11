import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../generated/app_strings.g.dart';
import '../cache/cache_entry.dart';
import '../cache/cache_policy.dart';
import '../domain/request_cancellation.dart';
import '../errors/dio_exception.dart';
import '../errors/failure.dart';
import '../network/network_info.dart';

/// Coordinates typed cache entries. API envelopes stay in the remote datasource.
class CacheHelper {
  static Future<Either<Failure, Entity>> fetchWithCache<DTO, Entity>({
    required CachePolicy policy,
    required Future<CacheEntry<DTO>?> Function() getLocal,
    required Future<void> Function(CacheEntry<DTO>) saveLocal,
    required Future<DTO> Function() fetchRemote,
    required Entity Function(DTO) mapper,
    required NetworkInfo networkInfo,
    required CacheContext context,
    required CacheContext Function() currentContext,
    Duration cacheDuration = const Duration(hours: 24),
    DateTime Function()? clock,
    RequestCancellation? cancellation,
  }) async {
    final now = clock ?? DateTime.now;
    bool isCurrent() =>
        cancellation?.isCancelled != true && context.matches(currentContext());
    Either<Failure, Entity> changed() =>
        left(AppFailure(message: LocaleKeys.cancelRequest));

    CacheEntry<DTO>? cached;
    if (policy != CachePolicy.networkOnly) {
      try {
        cached = await getLocal();
      } catch (_) {
        // A damaged/unavailable cache is a miss, not a network failure.
      }
    }
    bool hasValidCache() =>
        cached?.isValid(context, now(), cacheDuration) ?? false;
    Either<Failure, Entity> fromCache() {
      try {
        return right(mapper(cached!.value));
      } catch (error, trace) {
        return left(AppFailure.fromException(error, trace));
      }
    }

    try {
      if (!isCurrent()) return changed();
      if (policy == CachePolicy.cacheFirst && hasValidCache()) {
        return fromCache();
      }

      if (!await networkInfo.isConnected) {
        if (!isCurrent()) return changed();
        if (policy != CachePolicy.networkOnly && hasValidCache()) {
          return fromCache();
        }
        return left(AppFailure(message: LocaleKeys.noInternetConnection));
      }

      final dto = await fetchRemote();
      if (!isCurrent()) return changed();
      final entity = mapper(dto);
      if (policy != CachePolicy.networkOnly) {
        try {
          await saveLocal(
            CacheEntry(value: dto, cachedAt: now(), context: context),
          );
        } catch (_) {
          // A cache write failure must not discard a valid network response.
        }
      }
      if (!isCurrent()) return changed();
      return right(entity);
    } catch (error, trace) {
      if (!isCurrent()) return changed();
      if (policy == CachePolicy.networkFirst &&
          _isTransportFailure(error) &&
          hasValidCache()) {
        return fromCache();
      }
      return left(AppFailure.fromException(error, trace));
    }
  }

  static Future<Either<Failure, List<Entity>>> fetchListWithCache<DTO, Entity>({
    required CachePolicy policy,
    required Future<CacheEntry<List<DTO>>?> Function() getLocal,
    required Future<void> Function(CacheEntry<List<DTO>>) saveLocal,
    required Future<List<DTO>> Function() fetchRemote,
    required List<Entity> Function(List<DTO>) mapper,
    required NetworkInfo networkInfo,
    required CacheContext context,
    required CacheContext Function() currentContext,
    Duration cacheDuration = const Duration(hours: 24),
    DateTime Function()? clock,
    RequestCancellation? cancellation,
  }) => fetchWithCache<List<DTO>, List<Entity>>(
    policy: policy,
    getLocal: getLocal,
    saveLocal: saveLocal,
    fetchRemote: fetchRemote,
    mapper: mapper,
    networkInfo: networkInfo,
    context: context,
    currentContext: currentContext,
    cacheDuration: cacheDuration,
    clock: clock,
    cancellation: cancellation,
  );

  static bool _isTransportFailure(Object error) =>
      error is SocketException ||
      (error is DioException &&
          {
            DioExceptionType.connectionError,
            DioExceptionType.connectionTimeout,
            DioExceptionType.sendTimeout,
            DioExceptionType.receiveTimeout,
          }.contains(error.type));
}
