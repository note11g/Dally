import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class User {
  @HiveField(0)
  String? uid;
  @HiveField(1)
  String name;
  @HiveField(2)
  String phone;
  @HiveField(3)
  String nickName;
  @HiveField(4)
  String introduction;
  @HiveField(5)
  String profileImageUrl;
  @HiveField(6)
  int? registerTime;

  User(
      {this.uid,
      required this.name,
      required this.phone,
      required this.nickName,
      required this.introduction,
      required this.profileImageUrl,
      this.registerTime});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
