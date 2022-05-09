import 'package:json_annotation/json_annotation.dart';

import '../enums.dart';

part 'artwork_model.g.dart';

@JsonSerializable()
class ArtWork {
  final int? artId;
  final String owner;
  final String title;
  final String description;
  final List<String> tags;
  final String artImageUrl;
  final GalleryType gallery;
  final int? createdTime;
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
