// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServerPagination {

@JsonKey(name: "current_page") int get currentPage;@JsonKey(name: "last_page") int get lastPage;@JsonKey(name: "per_page") int get perPage;@JsonKey(name: "total") int get total;@JsonKey(name: "has_more_pages") bool get hasMorePages;@JsonKey(name: "next_page_url") String? get nextPageUrl;@JsonKey(name: "prev_page_url") String? get prevPageUrl;
/// Create a copy of ServerPagination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerPaginationCopyWith<ServerPagination> get copyWith => _$ServerPaginationCopyWithImpl<ServerPagination>(this as ServerPagination, _$identity);

  /// Serializes this ServerPagination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerPagination&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.total, total) || other.total == total)&&(identical(other.hasMorePages, hasMorePages) || other.hasMorePages == hasMorePages)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.prevPageUrl, prevPageUrl) || other.prevPageUrl == prevPageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,lastPage,perPage,total,hasMorePages,nextPageUrl,prevPageUrl);

@override
String toString() {
  return 'ServerPagination(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total, hasMorePages: $hasMorePages, nextPageUrl: $nextPageUrl, prevPageUrl: $prevPageUrl)';
}


}

/// @nodoc
abstract mixin class $ServerPaginationCopyWith<$Res>  {
  factory $ServerPaginationCopyWith(ServerPagination value, $Res Function(ServerPagination) _then) = _$ServerPaginationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "current_page") int currentPage,@JsonKey(name: "last_page") int lastPage,@JsonKey(name: "per_page") int perPage,@JsonKey(name: "total") int total,@JsonKey(name: "has_more_pages") bool hasMorePages,@JsonKey(name: "next_page_url") String? nextPageUrl,@JsonKey(name: "prev_page_url") String? prevPageUrl
});




}
/// @nodoc
class _$ServerPaginationCopyWithImpl<$Res>
    implements $ServerPaginationCopyWith<$Res> {
  _$ServerPaginationCopyWithImpl(this._self, this._then);

  final ServerPagination _self;
  final $Res Function(ServerPagination) _then;

/// Create a copy of ServerPagination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPage = null,Object? lastPage = null,Object? perPage = null,Object? total = null,Object? hasMorePages = null,Object? nextPageUrl = freezed,Object? prevPageUrl = freezed,}) {
  return _then(_self.copyWith(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,hasMorePages: null == hasMorePages ? _self.hasMorePages : hasMorePages // ignore: cast_nullable_to_non_nullable
as bool,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,prevPageUrl: freezed == prevPageUrl ? _self.prevPageUrl : prevPageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerPagination].
extension ServerPaginationPatterns on ServerPagination {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerPagination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerPagination() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerPagination value)  $default,){
final _that = this;
switch (_that) {
case _ServerPagination():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerPagination value)?  $default,){
final _that = this;
switch (_that) {
case _ServerPagination() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "current_page")  int currentPage, @JsonKey(name: "last_page")  int lastPage, @JsonKey(name: "per_page")  int perPage, @JsonKey(name: "total")  int total, @JsonKey(name: "has_more_pages")  bool hasMorePages, @JsonKey(name: "next_page_url")  String? nextPageUrl, @JsonKey(name: "prev_page_url")  String? prevPageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerPagination() when $default != null:
return $default(_that.currentPage,_that.lastPage,_that.perPage,_that.total,_that.hasMorePages,_that.nextPageUrl,_that.prevPageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "current_page")  int currentPage, @JsonKey(name: "last_page")  int lastPage, @JsonKey(name: "per_page")  int perPage, @JsonKey(name: "total")  int total, @JsonKey(name: "has_more_pages")  bool hasMorePages, @JsonKey(name: "next_page_url")  String? nextPageUrl, @JsonKey(name: "prev_page_url")  String? prevPageUrl)  $default,) {final _that = this;
switch (_that) {
case _ServerPagination():
return $default(_that.currentPage,_that.lastPage,_that.perPage,_that.total,_that.hasMorePages,_that.nextPageUrl,_that.prevPageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "current_page")  int currentPage, @JsonKey(name: "last_page")  int lastPage, @JsonKey(name: "per_page")  int perPage, @JsonKey(name: "total")  int total, @JsonKey(name: "has_more_pages")  bool hasMorePages, @JsonKey(name: "next_page_url")  String? nextPageUrl, @JsonKey(name: "prev_page_url")  String? prevPageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ServerPagination() when $default != null:
return $default(_that.currentPage,_that.lastPage,_that.perPage,_that.total,_that.hasMorePages,_that.nextPageUrl,_that.prevPageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerPagination implements ServerPagination {
  const _ServerPagination({@JsonKey(name: "current_page") required this.currentPage, @JsonKey(name: "last_page") required this.lastPage, @JsonKey(name: "per_page") required this.perPage, @JsonKey(name: "total") required this.total, @JsonKey(name: "has_more_pages") required this.hasMorePages, @JsonKey(name: "next_page_url") this.nextPageUrl, @JsonKey(name: "prev_page_url") this.prevPageUrl});
  factory _ServerPagination.fromJson(Map<String, dynamic> json) => _$ServerPaginationFromJson(json);

@override@JsonKey(name: "current_page") final  int currentPage;
@override@JsonKey(name: "last_page") final  int lastPage;
@override@JsonKey(name: "per_page") final  int perPage;
@override@JsonKey(name: "total") final  int total;
@override@JsonKey(name: "has_more_pages") final  bool hasMorePages;
@override@JsonKey(name: "next_page_url") final  String? nextPageUrl;
@override@JsonKey(name: "prev_page_url") final  String? prevPageUrl;

/// Create a copy of ServerPagination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerPaginationCopyWith<_ServerPagination> get copyWith => __$ServerPaginationCopyWithImpl<_ServerPagination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerPaginationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerPagination&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.total, total) || other.total == total)&&(identical(other.hasMorePages, hasMorePages) || other.hasMorePages == hasMorePages)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.prevPageUrl, prevPageUrl) || other.prevPageUrl == prevPageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,lastPage,perPage,total,hasMorePages,nextPageUrl,prevPageUrl);

@override
String toString() {
  return 'ServerPagination(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total, hasMorePages: $hasMorePages, nextPageUrl: $nextPageUrl, prevPageUrl: $prevPageUrl)';
}


}

/// @nodoc
abstract mixin class _$ServerPaginationCopyWith<$Res> implements $ServerPaginationCopyWith<$Res> {
  factory _$ServerPaginationCopyWith(_ServerPagination value, $Res Function(_ServerPagination) _then) = __$ServerPaginationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "current_page") int currentPage,@JsonKey(name: "last_page") int lastPage,@JsonKey(name: "per_page") int perPage,@JsonKey(name: "total") int total,@JsonKey(name: "has_more_pages") bool hasMorePages,@JsonKey(name: "next_page_url") String? nextPageUrl,@JsonKey(name: "prev_page_url") String? prevPageUrl
});




}
/// @nodoc
class __$ServerPaginationCopyWithImpl<$Res>
    implements _$ServerPaginationCopyWith<$Res> {
  __$ServerPaginationCopyWithImpl(this._self, this._then);

  final _ServerPagination _self;
  final $Res Function(_ServerPagination) _then;

/// Create a copy of ServerPagination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPage = null,Object? lastPage = null,Object? perPage = null,Object? total = null,Object? hasMorePages = null,Object? nextPageUrl = freezed,Object? prevPageUrl = freezed,}) {
  return _then(_ServerPagination(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,hasMorePages: null == hasMorePages ? _self.hasMorePages : hasMorePages // ignore: cast_nullable_to_non_nullable
as bool,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,prevPageUrl: freezed == prevPageUrl ? _self.prevPageUrl : prevPageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
