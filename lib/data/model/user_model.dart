import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';


@JsonSerializable()
class User {
  String? uid;
  String name;
  String phone;
  String nickName;
  String introduction;
  String profileImageUrl;
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
