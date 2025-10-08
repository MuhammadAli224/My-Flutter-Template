import '../../global_imports.dart';

part 'server_pagination.freezed.dart';
part 'server_pagination.g.dart';

@freezed
abstract class ServerPagination with _$ServerPagination {
  const factory ServerPagination({
    @JsonKey(name: "current_page") required int currentPage,
    @JsonKey(name: "last_page") required int lastPage,
    @JsonKey(name: "per_page") required int perPage,
    @JsonKey(name: "total") required int total,
    @JsonKey(name: "has_more_pages") required bool hasMorePages,
    @JsonKey(name: "next_page_url") String? nextPageUrl,
    @JsonKey(name: "prev_page_url") String? prevPageUrl,
  }) = _ServerPagination;

  factory ServerPagination.fromJson(Map<String, dynamic> json) =>
      _$ServerPaginationFromJson(json);
}
