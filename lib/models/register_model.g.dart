// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterModelAdapter extends TypeAdapter<RegisterModel> {
  @override
  final int typeId = 0;

  @override
  RegisterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterModel(
      username: fields[0] as String,
      password: fields[1] as String,
      phoneNumber: fields[2] as String,
      email: fields[3] as String,
      path: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
