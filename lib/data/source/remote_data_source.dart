import 'dart:convert';
import 'dart:typed_data';

import 'package:dally/data/client.dart';
import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../enums.dart';
import '../model/search_model.dart';
import '../model/trend_model.dart';

class RemoteDataSource {
  static final _dio =
      kDebugMode ? (Dio()..interceptors.add(LogInterceptor())) : Dio();

  // 테스트
  static Future<String> hello() {
    return RestClient(_dio).hello();
  }

  // user init 여부 (register 여부)
  static Future<String?> checkInit(String phone) {
    return RestClient(_dio)
        .getUserNameByPhone(phone)
        .then((v) => v?["userName"]);
  }

  static Future<User?> getUser(String uid) {
    return RestClient(_dio).getUser(uid).then((v) => v?["user"]);
  }

  static Future<String?> sendOTP(String phone) {
    return RestClient(_dio).sendOTP({"phone": phone}).then((v) => v["status"]);
  }

  // register 전에 checkOTP
  static Future<bool> checkOTP(String phone, String otp) {
    return RestClient(_dio).checkOTP({"phone": phone, "otp": otp}).then(
        (v) => v["status"] ?? false);
  }

  // 로그인
  static Future<String?> login(String phone, String otp) {
    return RestClient(_dio)
        .login({"phone": phone, "otp": otp}).then((v) => v["uid"]);
  }

  static Future<String?> register(User user) {
    return RestClient(_dio).register(user).then((v) => v["uid"]);
  }

  // 프로필 이미지 업로드
  static Future<String?> uploadProfile(Uint8List raw, String fileName) async {
    final uri = Uri.parse('https://api.note11.dev/api/v1/image/profile/upload');

    final imageFile =
        http.MultipartFile.fromBytes('file', raw, filename: fileName);

    final request = http.MultipartRequest('POST', uri);
    request.files.add(imageFile);

    final response = await request.send();
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      print(res.body);
      final map = jsonDecode(res.body);
      return map?["imageUrl"];
    } else {
      return null;
    }
  }

  /// artwork

  static Future<String?> uploadArtworkImage(
      Uint8List raw, String fileName) async {
    final uri = Uri.parse('https://api.note11.dev/api/v1/image/artwork/upload');

    final imageFile =
        http.MultipartFile.fromBytes('file', raw, filename: fileName);

    final request = http.MultipartRequest('POST', uri);
    request.files.add(imageFile);

    final response = await request.send();
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      print(res.body);
      final map = jsonDecode(res.body);
      return map?["imageUrl"];
    } else {
      return null;
    }
  }

  static Future<int?> uploadArtwork(ArtWork artWork) {
    return RestClient(_dio).uploadArtwork(artWork).then((v) => v["id"]);
  }

  static Future<ArtWork> getArtwork(String artId) {
    return RestClient(_dio).getArtwork(artId);
  }

  static Future<List<ArtWork>> getArtworkByType(GalleryType type) {
    return RestClient(_dio)
        .getArtworkByType(type.name)
        .then((m) => m["artwork"] ?? []);
  }

  static Future<Trend?> getTrends() {
    return RestClient(_dio).getTrend();
  }

  static Future<Search?> search(String keyword) {
    return RestClient(_dio).search(keyword);
  }

  static Future<List<ArtWork>> getUsersArtworks(String uid) {
    return RestClient(_dio)
        .getUsersArtworks(uid)
        .then((v) => v["artworks"] ?? []);
  }
}
