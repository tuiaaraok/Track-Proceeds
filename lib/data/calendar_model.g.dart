// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarModelAdapter extends TypeAdapter<CalendarModel> {
  @override
  final int typeId = 1;

  @override
  CalendarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarModel(
      day: (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<DayIs>())),
    );
  }

  @override
  void write(BinaryWriter writer, CalendarModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DayIsAdapter extends TypeAdapter<DayIs> {
  @override
  final int typeId = 2;

  @override
  DayIs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayIs(
      data: fields[0] as DateTime,
      start: fields[1] as String?,
      finish: fields[2] as String?,
      payment: fields[3] as String?,
      tip: fields[4] as String?,
      note: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DayIs obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.finish)
      ..writeByte(3)
      ..write(obj.payment)
      ..writeByte(4)
      ..write(obj.tip)
      ..writeByte(5)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayIsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
