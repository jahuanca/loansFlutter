// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoanEntityAdapter extends TypeAdapter<LoanEntity> {
  @override
  final int typeId = 1;

  @override
  LoanEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoanEntity(
      id: fields[0] as int?,
      idCustomer: fields[1] as int,
      idUser: fields[2] as int,
      idPaymentFrequency: fields[3] as int,
      amount: fields[4] as double,
      percentage: fields[5] as double,
      startDate: fields[6] as DateTime,
      ganancy: fields[7] as double,
      idPaymentMethod: fields[8] as int,
      observation: fields[9] as String?,
      idStateLoan: fields[10] as int,
      evidence: fields[11] as String,
      createdAt: fields[12] as DateTime,
      updatedAt: fields[13] as DateTime,
      installmentsNumber: fields[14] as int,
      daysBetweenInstallments: fields[15] as int,
      customerEntity: fields[16] as CustomerEntity?,
      paymentFrequencyEntity: fields[17] as PaymentFrequencyEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, LoanEntity obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idCustomer)
      ..writeByte(2)
      ..write(obj.idUser)
      ..writeByte(3)
      ..write(obj.idPaymentFrequency)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.percentage)
      ..writeByte(6)
      ..write(obj.startDate)
      ..writeByte(7)
      ..write(obj.ganancy)
      ..writeByte(8)
      ..write(obj.idPaymentMethod)
      ..writeByte(9)
      ..write(obj.observation)
      ..writeByte(10)
      ..write(obj.idStateLoan)
      ..writeByte(11)
      ..write(obj.evidence)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.installmentsNumber)
      ..writeByte(15)
      ..write(obj.daysBetweenInstallments)
      ..writeByte(16)
      ..write(obj.customerEntity)
      ..writeByte(17)
      ..write(obj.paymentFrequencyEntity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoanEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
