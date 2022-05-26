import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enums.dart';

part 'artwork_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class ArtWork {
  @HiveField(0)
  final int? artId;
  @HiveField(1)
  final String owner;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final List<String> tags;
  @HiveField(5)
  final String artImageUrl;
  @HiveField(6)
  final GalleryType gallery;
  @HiveField(7)
  final int? createdTime;
  @HiveField(8)
  final int? lastModifiedTime;

  ArtWork(
      {this.artId,
      required this.owner,
      required this.title,
      required this.description,
      required this.tags,
      required this.artImageUrl,
      required this.gallery,
      this.createdTime,
      this.lastModifiedTime});

  factory ArtWork.fromJson(Map<String, dynamic> json) =>
      _$ArtWorkFromJson(json);

  Map<String, dynamic> toJson() => _$ArtWorkToJson(this);
}
