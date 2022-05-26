import 'package:json_annotation/json_annotation.dart';

import 'artwork_model.dart';
import 'user_model.dart';

part 'search_model.g.dart';

@JsonSerializable()
class Search {
  final List<ArtWork> artworks;
  final List<User> users;

  Search({required this.artworks, required this.users});

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
