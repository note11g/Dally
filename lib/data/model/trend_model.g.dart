// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trend _$TrendFromJson(Map<String, dynamic> json) => Trend(
      artworks: (json['artworks'] as List<dynamic>)
          .map((e) => ArtWork.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TrendToJson(Trend instance) => <String, dynamic>{
      'artworks': instance.artworks,
      'tags': instance.tags,
    };
