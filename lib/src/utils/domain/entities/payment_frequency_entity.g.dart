// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_frequency_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentFrequencyEntityAdapter
    extends TypeAdapter<PaymentFrequencyEntity> {
  @override
  final int typeId = 3;

  @override
  PaymentFrequencyEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentFrequencyEntity(
      id: fields[0] as int?,
      name: fields[2] as String,
      idTypeCustomer: fields[1] as int?,
      description: fields[3] as String?,
      recommendedPercentage: fields[4] as double,
      monthlyInstallments: fields[5] as int,
      daysInstallment: fields[6] as int,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentFrequencyEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idTypeCustomer)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.recommendedPercentage)
      ..writeByte(5)
      ..write(obj.monthlyInstallments)
      ..writeByte(6)
      ..write(obj.daysInstallment)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentFrequencyEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
