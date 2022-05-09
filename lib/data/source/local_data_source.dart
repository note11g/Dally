import 'package:hive_flutter/hive_flutter.dart';

import '../model/user_model.dart';

class LocalDataSource {
  static const _uidKey = "user_id_key";
  static const _userKey = 'user_key';

  static Future<Box<dynamic>> get _box async => await Hive.openBox('testBox');

  static Future saveUid(String uid) async {
    await (await _box).put(_uidKey, uid);
  }

  static Future<String?> getUid() async {
    return (await _box).get(_uidKey);
  }

  static removeUid() async {
    await (await _box).delete(_uidKey);
  }

  static Future saveUser(User user) async {
    await (await _box).put(_userKey, user.toJson());
  }

  static Future<User?> getUser() async {
    final Map<String, dynamic>? json = (await _box).get(_userKey);
    return json != null ? User.fromJson(json) : null;
  }
}
