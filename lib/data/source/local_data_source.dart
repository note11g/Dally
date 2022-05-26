import 'dart:convert';

import 'package:dally/data/model/search_record_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/artwork_model.dart';
import '../model/user_model.dart';

class LocalDataSource {
  static const _uidKey = "user_id_key";
  static const _userKey = 'user_key';

  static Future<Box<dynamic>> get _box async => await Hive.openBox('testBox');

  static Future<Box<SearchRecord>> get _searchBox async =>
      await Hive.openBox<SearchRecord>('searchBox');

  static Future<Box<ArtWork>> get _likeBox async =>
      await Hive.openBox<ArtWork>('likeBox');

  static Future<Box<User>> get _likeUserBox async =>
      await Hive.openBox<User>('likeUserBox');

  static Future<void> saveUid(String uid) async {
    await (await _box).put(_uidKey, uid);
  }

  static Future<String?> getUid() async {
    return (await _box).get(_uidKey);
  }

  static removeUid() async {
    await (await _box).delete(_uidKey);
  }

  static Future<void> saveUser(User user) async {
    await (await _box).put(_userKey, user.toJson());
  }

  static Future<User?> getUser() async {
    final Map<String, dynamic>? json = (await _box).get(_userKey);
    return json != null ? User.fromJson(json) : null;
  }

  static Future<void> saveSearchKeyword(SearchRecord record) async {
    final box = await _searchBox;
    final key = base64.encode(utf8.encode(record.keyword));
    await box.put(key, record);
  }

  static Future<List<SearchRecord>> getSearchKeywords() async {
    final box = await _searchBox;
    final values = box.values.toList();
    values.sort((a, b) => b.time - a.time);
    return values;
  }

  static Future<void> deleteSearchKeyword(SearchRecord record) async {
    final key = base64.encode(utf8.encode(record.keyword));
    final box = await _searchBox;
    await box.delete(key);
    print("deleted!");
  }

  static Future<void> like(ArtWork artwork) async {
    final box = await _likeBox;
    await box.put(artwork.artId, artwork);
  }

  static Future<List<ArtWork>> getLikes() async {
    final box = await _likeBox;
    return box.values.map((e) => e).toList();
  }

  static Future<void> unlike(int artId) async {
    final box = await _likeBox;
    await box.delete(artId);
  }

  // todo : 에러나면 listen 끊어주기
  static void listenLikes(Function() listener) async {
    final box = await _likeBox;
    box.listenable().addListener(listener);
  }
}
