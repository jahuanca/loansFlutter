// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_of_dashboard_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SummaryOfDashboardResponseAdapter
    extends TypeAdapter<SummaryOfDashboardResponse> {
  @override
  final int typeId = 0;

  @override
  SummaryOfDashboardResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SummaryOfDashboardResponse(
      loans: fields[0] as String,
      amounts: fields[1] as String,
      ganancy: fields[2] as String,
      renovar: fields[3] as String,
      injection: fields[4] as double,
      cesaron: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SummaryOfDashboardResponse obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.loans)
      ..writeByte(1)
      ..write(obj.amounts)
      ..writeByte(2)
      ..write(obj.ganancy)
      ..writeByte(3)
      ..write(obj.renovar)
      ..writeByte(4)
      ..write(obj.injection)
      ..writeByte(5)
      ..write(obj.cesaron);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SummaryOfDashboardResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
