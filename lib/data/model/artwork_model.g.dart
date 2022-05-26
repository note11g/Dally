// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtWorkAdapter extends TypeAdapter<ArtWork> {
  @override
  final int typeId = 2;

  @override
  ArtWork read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArtWork(
      artId: fields[0] as int?,
      owner: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      tags: (fields[4] as List).cast<String>(),
      artImageUrl: fields[5] as String,
      gallery: fields[6] as GalleryType,
      createdTime: fields[7] as int?,
      lastModifiedTime: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ArtWork obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.artId)
      ..writeByte(1)
      ..write(obj.owner)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.tags)
      ..writeByte(5)
      ..write(obj.artImageUrl)
      ..writeByte(6)
      ..write(obj.gallery)
      ..writeByte(7)
      ..write(obj.createdTime)
      ..writeByte(8)
      ..write(obj.lastModifiedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtWorkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtWork _$ArtWorkFromJson(Map<String, dynamic> json) => ArtWork(
      artId: json['artId'] as int?,
      owner: json['owner'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      artImageUrl: json['artImageUrl'] as String,
      gallery: $enumDecode(_$GalleryTypeEnumMap, json['gallery']),
      createdTime: json['createdTime'] as int?,
      lastModifiedTime: json['lastModifiedTime'] as int?,
    );

Map<String, dynamic> _$ArtWorkToJson(ArtWork instance) => <String, dynamic>{
      'artId': instance.artId,
      'owner': instance.owner,
      'title': instance.title,
      'description': instance.description,
      'tags': instance.tags,
      'artImageUrl': instance.artImageUrl,
      'gallery': _$GalleryTypeEnumMap[instance.gallery],
      'createdTime': instance.createdTime,
      'lastModifiedTime': instance.lastModifiedTime,
    };

const _$GalleryTypeEnumMap = {
  GalleryType.illustration: 'illustration',
  GalleryType.drawing: 'drawing',
  GalleryType.landscape: 'landscape',
  GalleryType.portrait: 'portrait',
  GalleryType.stillLife: 'stillLife',
  GalleryType.none: 'none',
};
