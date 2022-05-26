import 'dart:typed_data';

import 'package:dally/data/source/local_data_source.dart';
import 'package:dally/data/source/remote_data_source.dart';
import 'package:intl/intl.dart';

import '../model/user_model.dart';

class UserRepository {
  static Future test() async {
    final res = await RemoteDataSource.hello();
    print("server test : $res");
  }

  static Future<String?> checkInit(String phone) async {
    final userName = await RemoteDataSource.checkInit(phone);
    return userName;
  }

  static Future<bool> sendOTP(String phone) async {
    final res = await RemoteDataSource.sendOTP(phone);
    return res == "succeed";
  }

  static Future<bool> checkOTP(String phone, String otp) async {
    return RemoteDataSource.checkOTP(phone, otp);
  }

  static Future<String?> login(
      {required String phone, required String otp}) async {
    final uid = await RemoteDataSource.login(phone, otp);
    if (uid != null) {
      await LocalDataSource.saveUid(uid);
      await getUser(userId: uid);
    }
    return uid;
  }

  static Future<String?> register(User user) async {
    final uid = await RemoteDataSource.register(user);
    if (uid != null) {
      await LocalDataSource.saveUid(uid);
      await getUser(userId: uid);
    }
    return uid;
  }

  static Future<bool> isSigned() {
    return LocalDataSource.getUid().then((v) => v != null);
  }

  static Future logout() async {
    await LocalDataSource.removeUid();
  }

  static Future<User?> getUser({String? userId}) async {
    final uid = userId ?? await LocalDataSource.getUid();
    if (uid == null) return null;
    final user = await RemoteDataSource.getUser(uid);
    if (user != null) {
      await LocalDataSource.saveUser(user);
    }
    return user;
  }

  // profile image upload
  // return imageUrl
  static Future<String?> uploadProfile(Uint8List raw,
      {required String phone}) async {
    final now = DateTime.now();
    return await RemoteDataSource.uploadProfile(raw,
        "profile_${phone}_${DateFormat("yyyyMMdd_hhmmss").format(now)}.png");
  }
}
