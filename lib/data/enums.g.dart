// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GalleryTypeAdapter extends TypeAdapter<GalleryType> {
  @override
  final int typeId = 4;

  @override
  GalleryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GalleryType.illustration;
      case 1:
        return GalleryType.drawing;
      case 2:
        return GalleryType.landscape;
      case 3:
        return GalleryType.portrait;
      case 4:
        return GalleryType.stillLife;
      case 5:
        return GalleryType.none;
      default:
        return GalleryType.illustration;
    }
  }

  @override
  void write(BinaryWriter writer, GalleryType obj) {
    switch (obj) {
      case GalleryType.illustration:
        writer.writeByte(0);
        break;
      case GalleryType.drawing:
        writer.writeByte(1);
        break;
      case GalleryType.landscape:
        writer.writeByte(2);
        break;
      case GalleryType.portrait:
        writer.writeByte(3);
        break;
      case GalleryType.stillLife:
        writer.writeByte(4);
        break;
      case GalleryType.none:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
