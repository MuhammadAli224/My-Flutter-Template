// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServerPagination _$ServerPaginationFromJson(Map<String, dynamic> json) {
  return _ServerPagination.fromJson(json);
}

/// @nodoc
mixin _$ServerPagination {
  @JsonKey(name: "current_page")
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: "last_page")
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: "per_page")
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: "total")
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: "has_more_pages")
  bool get hasMorePages => throw _privateConstructorUsedError;
  @JsonKey(name: "next_page_url")
  String? get nextPageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "prev_page_url")
  String? get prevPageUrl => throw _privateConstructorUsedError;

  /// Serializes this ServerPagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerPagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerPaginationCopyWith<ServerPagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerPaginationCopyWith<$Res> {
  factory $ServerPaginationCopyWith(
          ServerPagination value, $Res Function(ServerPagination) then) =
      _$ServerPaginationCopyWithImpl<$Res, ServerPagination>;
  @useResult
  $Res call(
      {@JsonKey(name: "current_page") int currentPage,
      @JsonKey(name: "last_page") int lastPage,
      @JsonKey(name: "per_page") int perPage,
      @JsonKey(name: "total") int total,
      @JsonKey(name: "has_more_pages") bool hasMorePages,
      @JsonKey(name: "next_page_url") String? nextPageUrl,
      @JsonKey(name: "prev_page_url") String? prevPageUrl});
}

/// @nodoc
class _$ServerPaginationCopyWithImpl<$Res, $Val extends ServerPagination>
    implements $ServerPaginationCopyWith<$Res> {
  _$ServerPaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerPagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? lastPage = null,
    Object? perPage = null,
    Object? total = null,
    Object? hasMorePages = null,
    Object? nextPageUrl = freezed,
    Object? prevPageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      hasMorePages: null == hasMorePages
          ? _value.hasMorePages
          : hasMorePages // ignore: cast_nullable_to_non_nullable
              as bool,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      prevPageUrl: freezed == prevPageUrl
          ? _value.prevPageUrl
          : prevPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerPaginationImplCopyWith<$Res>
    implements $ServerPaginationCopyWith<$Res> {
  factory _$$ServerPaginationImplCopyWith(_$ServerPaginationImpl value,
          $Res Function(_$ServerPaginationImpl) then) =
      __$$ServerPaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "current_page") int currentPage,
      @JsonKey(name: "last_page") int lastPage,
      @JsonKey(name: "per_page") int perPage,
      @JsonKey(name: "total") int total,
      @JsonKey(name: "has_more_pages") bool hasMorePages,
      @JsonKey(name: "next_page_url") String? nextPageUrl,
      @JsonKey(name: "prev_page_url") String? prevPageUrl});
}

/// @nodoc
class __$$ServerPaginationImplCopyWithImpl<$Res>
    extends _$ServerPaginationCopyWithImpl<$Res, _$ServerPaginationImpl>
    implements _$$ServerPaginationImplCopyWith<$Res> {
  __$$ServerPaginationImplCopyWithImpl(_$ServerPaginationImpl _value,
      $Res Function(_$ServerPaginationImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServerPagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? lastPage = null,
    Object? perPage = null,
    Object? total = null,
    Object? hasMorePages = null,
    Object? nextPageUrl = freezed,
    Object? prevPageUrl = freezed,
  }) {
    return _then(_$ServerPaginationImpl(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      hasMorePages: null == hasMorePages
          ? _value.hasMorePages
          : hasMorePages // ignore: cast_nullable_to_non_nullable
              as bool,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      prevPageUrl: freezed == prevPageUrl
          ? _value.prevPageUrl
          : prevPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerPaginationImpl implements _ServerPagination {
  const _$ServerPaginationImpl(
      {@JsonKey(name: "current_page") required this.currentPage,
      @JsonKey(name: "last_page") required this.lastPage,
      @JsonKey(name: "per_page") required this.perPage,
      @JsonKey(name: "total") required this.total,
      @JsonKey(name: "has_more_pages") required this.hasMorePages,
      @JsonKey(name: "next_page_url") this.nextPageUrl,
      @JsonKey(name: "prev_page_url") this.prevPageUrl});

  factory _$ServerPaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerPaginationImplFromJson(json);

  @override
  @JsonKey(name: "current_page")
  final int currentPage;
  @override
  @JsonKey(name: "last_page")
  final int lastPage;
  @override
  @JsonKey(name: "per_page")
  final int perPage;
  @override
  @JsonKey(name: "total")
  final int total;
  @override
  @JsonKey(name: "has_more_pages")
  final bool hasMorePages;
  @override
  @JsonKey(name: "next_page_url")
  final String? nextPageUrl;
  @override
  @JsonKey(name: "prev_page_url")
  final String? prevPageUrl;

  @override
  String toString() {
    return 'ServerPagination(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total, hasMorePages: $hasMorePages, nextPageUrl: $nextPageUrl, prevPageUrl: $prevPageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerPaginationImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.hasMorePages, hasMorePages) ||
                other.hasMorePages == hasMorePages) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.prevPageUrl, prevPageUrl) ||
                other.prevPageUrl == prevPageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentPage, lastPage, perPage,
      total, hasMorePages, nextPageUrl, prevPageUrl);

  /// Create a copy of ServerPagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerPaginationImplCopyWith<_$ServerPaginationImpl> get copyWith =>
      __$$ServerPaginationImplCopyWithImpl<_$ServerPaginationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerPaginationImplToJson(
      this,
    );
  }
}

abstract class _ServerPagination implements ServerPagination {
  const factory _ServerPagination(
          {@JsonKey(name: "current_page") required final int currentPage,
          @JsonKey(name: "last_page") required final int lastPage,
          @JsonKey(name: "per_page") required final int perPage,
          @JsonKey(name: "total") required final int total,
          @JsonKey(name: "has_more_pages") required final bool hasMorePages,
          @JsonKey(name: "next_page_url") final String? nextPageUrl,
          @JsonKey(name: "prev_page_url") final String? prevPageUrl}) =
      _$ServerPaginationImpl;

  factory _ServerPagination.fromJson(Map<String, dynamic> json) =
      _$ServerPaginationImpl.fromJson;

  @override
  @JsonKey(name: "current_page")
  int get currentPage;
  @override
  @JsonKey(name: "last_page")
  int get lastPage;
  @override
  @JsonKey(name: "per_page")
  int get perPage;
  @override
  @JsonKey(name: "total")
  int get total;
  @override
  @JsonKey(name: "has_more_pages")
  bool get hasMorePages;
  @override
  @JsonKey(name: "next_page_url")
  String? get nextPageUrl;
  @override
  @JsonKey(name: "prev_page_url")
  String? get prevPageUrl;

  /// Create a copy of ServerPagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerPaginationImplCopyWith<_$ServerPaginationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
