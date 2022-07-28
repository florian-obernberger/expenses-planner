// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensesItemAdapter extends TypeAdapter<ExpensesItem> {
  @override
  final int typeId = 0;

  @override
  ExpensesItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpensesItem(
      title: fields[0] as String,
      subTitle: fields[1] as String?,
      value: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExpensesItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subTitle)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensesItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
