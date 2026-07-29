// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerEntityAdapter extends TypeAdapter<CustomerEntity> {
  @override
  final int typeId = 2;

  @override
  CustomerEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      lastName: fields[3] as String,
      address: fields[4] as String,
      idTypeCustomer: fields[9] as int,
      idTypeDocument: fields[8] as int,
      document: fields[10] as String,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      phone: fields[7] as String?,
      alias: fields[2] as String?,
      latitude: fields[5] as String?,
      longitude: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.alias)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
      ..write(obj.longitude)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.idTypeDocument)
      ..writeByte(9)
      ..write(obj.idTypeCustomer)
      ..writeByte(10)
      ..write(obj.document)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
