import 'package:json_annotation/json_annotation.dart';

import 'artwork_model.dart';

part 'trend_model.g.dart';

@JsonSerializable()
class Trend {

  final List<ArtWork> artworks;
  final List<String> tags;

  Trend({required this.artworks, required this.tags});

  factory Trend.fromJson(Map<String, dynamic> json) => _$TrendFromJson(json);

  Map<String, dynamic> toJson() => _$TrendToJson(this);
}
