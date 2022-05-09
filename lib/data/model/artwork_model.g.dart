// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork_model.dart';

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
