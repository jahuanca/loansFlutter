// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_payment_account_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerPaymentAccountEntityAdapter
    extends TypeAdapter<CustomerPaymentAccountEntity> {
  @override
  final int typeId = 5;

  @override
  CustomerPaymentAccountEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerPaymentAccountEntity(
      id: fields[0] as int?,
      idCustomer: fields[1] as int?,
      idPaymentProvider: fields[2] as int,
      accountNumber: fields[3] as String?,
      cci: fields[4] as String?,
      phone: fields[5] as String?,
      holderName: fields[6] as String?,
      createdAt: fields[7] as DateTime?,
      updatedAt: fields[8] as DateTime?,
      isDefault: fields[9] as bool,
      observation: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerPaymentAccountEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idCustomer)
      ..writeByte(2)
      ..write(obj.idPaymentProvider)
      ..writeByte(3)
      ..write(obj.accountNumber)
      ..writeByte(4)
      ..write(obj.cci)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.holderName)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.isDefault)
      ..writeByte(10)
      ..write(obj.observation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerPaymentAccountEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
