// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthUserModelAdapter extends TypeAdapter<_$AuthUserModelImpl> {
  @override
  final int typeId = 100;

  @override
  _$AuthUserModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AuthUserModelImpl(
      id: fields[1] as int,
      name: fields[2] as String,
      email: fields[3] as String?,
      phone: fields[4] as String,
      fcmToken: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AuthUserModelImpl obj) {
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

_$AuthUserModelImpl _$$AuthUserModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$$AuthUserModelImplToJson(_$AuthUserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'fcm_token': instance.fcmToken,
    };
