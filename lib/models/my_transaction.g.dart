// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyTransactionAdapter extends TypeAdapter<MyTransaction> {
  @override
  final int typeId = 1;

  @override
  MyTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyTransaction(
      title: fields[1] as String,
      amount: fields[2] as double,
      createdAt: fields[3] as DateTime?,
      id: fields[0] as String?,
    )
      .._type = fields[4] as String
      .._category = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, MyTransaction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj._type)
      ..writeByte(5)
      ..write(obj._category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
