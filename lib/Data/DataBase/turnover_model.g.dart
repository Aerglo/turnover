// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turnover_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TurnoverAdapter extends TypeAdapter<Turnover> {
  @override
  final int typeId = 0;

  @override
  Turnover read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Turnover(
      title: fields[0] as String,
      amount: fields[1] as double,
      deposit: fields[2] as bool,
      category: fields[3] as String,
      description: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Turnover obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.deposit)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TurnoverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
