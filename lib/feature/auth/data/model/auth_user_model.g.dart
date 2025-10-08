// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthUserModelAdapter extends TypeAdapter<_AuthUserModel> {
  @override
  final typeId = 100;

  @override
  _AuthUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _AuthUserModel(
      id: (fields[1] as num).toInt(),
      name: fields[2] as String,
      email: fields[3] as String?,
      phone: fields[4] as String,
      fcmToken: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _AuthUserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.fcmToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) =>
    _AuthUserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$AuthUserModelToJson(_AuthUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'fcm_token': instance.fcmToken,
    };
