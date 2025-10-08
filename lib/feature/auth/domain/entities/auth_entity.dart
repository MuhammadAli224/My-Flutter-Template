import '../../../../global_imports.dart';


part 'auth_entity.freezed.dart';

@freezed
abstract class AuthEntity with _$AuthEntity {
  const factory AuthEntity({
    required int id,
    required String name,
    String? email,
    required String phone,
    String? fcmToken,
  }) = _AuthEntity;
}