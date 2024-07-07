// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_zone_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SosZoneEntityAdapter extends TypeAdapter<SosZoneEntity> {
  @override
  final int typeId = 0;

  @override
  SosZoneEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SosZoneEntity(
      id: fields[0] as num,
      lat: fields[1] as double,
      lang: fields[2] as double,
      emergencyType: fields[3] as String,
      radius: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SosZoneEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lang)
      ..writeByte(3)
      ..write(obj.emergencyType)
      ..writeByte(4)
      ..write(obj.radius);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SosZoneEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
