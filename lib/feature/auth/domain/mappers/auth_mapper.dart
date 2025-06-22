import '../../../../global_imports.dart';

extension AuthMapper on AuthUserModel {
  AuthEntity toEntity() =>
      AuthEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,

        fcmToken: fcmToken,
      );
}

extension AuthEntityMapper on AuthEntity {
  AuthUserModel toModel() =>
      AuthUserModel(
        id: id,
        name: name,
        email: email,
        phone: phone,

        fcmToken: fcmToken,
      );
}
