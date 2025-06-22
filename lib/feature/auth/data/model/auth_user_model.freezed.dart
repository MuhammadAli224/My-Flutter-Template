// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) {
  return _AuthUserModel.fromJson(json);
}

/// @nodoc
mixin _$AuthUserModel {
  @HiveField(1)
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @HiveField(2)
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(name: "email")
  String? get email => throw _privateConstructorUsedError;
  @HiveField(4)
  @JsonKey(name: "phone")
  String get phone => throw _privateConstructorUsedError;
  @HiveField(7)
  @JsonKey(name: "fcm_token")
  String? get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this AuthUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthUserModelCopyWith<AuthUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserModelCopyWith<$Res> {
  factory $AuthUserModelCopyWith(
          AuthUserModel value, $Res Function(AuthUserModel) then) =
      _$AuthUserModelCopyWithImpl<$Res, AuthUserModel>;
  @useResult
  $Res call(
      {@HiveField(1) @JsonKey(name: "id") int id,
      @HiveField(2) @JsonKey(name: "name") String name,
      @HiveField(3) @JsonKey(name: "email") String? email,
      @HiveField(4) @JsonKey(name: "phone") String phone,
      @HiveField(7) @JsonKey(name: "fcm_token") String? fcmToken});
}

/// @nodoc
class _$AuthUserModelCopyWithImpl<$Res, $Val extends AuthUserModel>
    implements $AuthUserModelCopyWith<$Res> {
  _$AuthUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? phone = null,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUserModelImplCopyWith<$Res>
    implements $AuthUserModelCopyWith<$Res> {
  factory _$$AuthUserModelImplCopyWith(
          _$AuthUserModelImpl value, $Res Function(_$AuthUserModelImpl) then) =
      __$$AuthUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(1) @JsonKey(name: "id") int id,
      @HiveField(2) @JsonKey(name: "name") String name,
      @HiveField(3) @JsonKey(name: "email") String? email,
      @HiveField(4) @JsonKey(name: "phone") String phone,
      @HiveField(7) @JsonKey(name: "fcm_token") String? fcmToken});
}

/// @nodoc
class __$$AuthUserModelImplCopyWithImpl<$Res>
    extends _$AuthUserModelCopyWithImpl<$Res, _$AuthUserModelImpl>
    implements _$$AuthUserModelImplCopyWith<$Res> {
  __$$AuthUserModelImplCopyWithImpl(
      _$AuthUserModelImpl _value, $Res Function(_$AuthUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? phone = null,
    Object? fcmToken = freezed,
  }) {
    return _then(_$AuthUserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 100, adapterName: 'AuthUserModelAdapter')
class _$AuthUserModelImpl implements _AuthUserModel {
  const _$AuthUserModelImpl(
      {@HiveField(1) @JsonKey(name: "id") required this.id,
      @HiveField(2) @JsonKey(name: "name") required this.name,
      @HiveField(3) @JsonKey(name: "email") this.email,
      @HiveField(4) @JsonKey(name: "phone") required this.phone,
      @HiveField(7) @JsonKey(name: "fcm_token") this.fcmToken});

  factory _$AuthUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserModelImplFromJson(json);

  @override
  @HiveField(1)
  @JsonKey(name: "id")
  final int id;
  @override
  @HiveField(2)
  @JsonKey(name: "name")
  final String name;
  @override
  @HiveField(3)
  @JsonKey(name: "email")
  final String? email;
  @override
  @HiveField(4)
  @JsonKey(name: "phone")
  final String phone;
  @override
  @HiveField(7)
  @JsonKey(name: "fcm_token")
  final String? fcmToken;

  @override
  String toString() {
    return 'AuthUserModel(id: $id, name: $name, email: $email, phone: $phone, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, email, phone, fcmToken);

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserModelImplCopyWith<_$AuthUserModelImpl> get copyWith =>
      __$$AuthUserModelImplCopyWithImpl<_$AuthUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserModelImplToJson(
      this,
    );
  }
}

abstract class _AuthUserModel implements AuthUserModel {
  const factory _AuthUserModel(
          {@HiveField(1) @JsonKey(name: "id") required final int id,
          @HiveField(2) @JsonKey(name: "name") required final String name,
          @HiveField(3) @JsonKey(name: "email") final String? email,
          @HiveField(4) @JsonKey(name: "phone") required final String phone,
          @HiveField(7) @JsonKey(name: "fcm_token") final String? fcmToken}) =
      _$AuthUserModelImpl;

  factory _AuthUserModel.fromJson(Map<String, dynamic> json) =
      _$AuthUserModelImpl.fromJson;

  @override
  @HiveField(1)
  @JsonKey(name: "id")
  int get id;
  @override
  @HiveField(2)
  @JsonKey(name: "name")
  String get name;
  @override
  @HiveField(3)
  @JsonKey(name: "email")
  String? get email;
  @override
  @HiveField(4)
  @JsonKey(name: "phone")
  String get phone;
  @override
  @HiveField(7)
  @JsonKey(name: "fcm_token")
  String? get fcmToken;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserModelImplCopyWith<_$AuthUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
