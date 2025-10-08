import '../../../../global_imports.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
abstract class AuthUserModel with _$AuthUserModel {
  @HiveType(typeId: 100, adapterName: 'AuthUserModelAdapter')
  const factory AuthUserModel({
    @HiveField(1) @JsonKey(name: "id")  required int id,
    @HiveField(2) @JsonKey(name: "name") required String name,
    @HiveField(3) @JsonKey(name: "email") String? email,
    @HiveField(4) @JsonKey(name: "phone") required String phone,
    @HiveField(7) @JsonKey(name: "fcm_token") String? fcmToken,

  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
