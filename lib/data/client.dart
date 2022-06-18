import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/search_model.dart';
import 'package:dally/data/model/trend_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'model/user_model.dart';

part 'client.g.dart';

@RestApi(baseUrl: "https://api.note11.dev/api/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("")
  Future<String> hello();

  /// USER Auth
  @POST("/user/auth/test/regi")
  Future<Map<String, String>> register(@Body() User user);

  @POST("/user/auth/login")
  Future<Map<String, String?>> login(@Body() Map<String, String> map);

  @POST("/user/auth/send")
  Future<Map<String, String>> sendOTP(@Body() Map<String, String> map);

  @POST("/user/auth/check")
  Future<Map<String, bool>> checkOTP(@Body() Map<String, String> map);

  @POST("/user/get/valid_phone")
  @FormUrlEncoded()
  Future<Map<String, String>?> getUserNameByPhone(@Field() String phone);

  @POST("/user/get")
  @FormUrlEncoded()
  Future<Map<String, User?>?> getUser(@Field() String uid);

  /// artwork
  @POST("/artwork/upload")
  Future<Map<String, int>> uploadArtwork(@Body() ArtWork artWork);

  @GET("/artwork/{id}")
  Future<ArtWork> getArtwork(@Path("id") String artId);

  @GET("/artwork/gallery/{type}")
  Future<Map<String, List<ArtWork>>> getArtworkByType(
      @Path("type") String galleryType);

  /// trend
  @GET("/artwork/trend")
  Future<Trend?> getTrend();

  /// search
  @GET("/search?keyword={k}")
  Future<Search?> search(@Path("k") String keyword);

  /// user's artwork
  @GET("/artwork/user/{id}")
  Future<Map<String, List<ArtWork>>> getUsersArtworks(@Path("id") String uid);
}
