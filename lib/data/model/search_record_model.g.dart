// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_record_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchRecordAdapter extends TypeAdapter<SearchRecord> {
  @override
  final int typeId = 1;

  @override
  SearchRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchRecord(
      keyword: fields[0] as String,
      time: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SearchRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.keyword)
      ..writeByte(1)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
