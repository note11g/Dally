// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String,
      nickName: json['nickName'] as String,
      introduction: json['introduction'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      registerTime: json['registerTime'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'nickName': instance.nickName,
      'introduction': instance.introduction,
      'profileImageUrl': instance.profileImageUrl,
      'registerTime': instance.registerTime,
    };
