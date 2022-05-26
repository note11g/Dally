import 'dart:typed_data';

import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/source/local_data_source.dart';
import 'package:intl/intl.dart';

import '../enums.dart';
import '../source/remote_data_source.dart';

class ArtworkRepository {
  static Future<String?> uploadArtworkImage(Uint8List raw,
      {required String uid}) async {
    final now = DateTime.now();
    return await RemoteDataSource.uploadArtworkImage(
        raw, "artwork_${uid}_${DateFormat("yyyyMMdd_hhmmss").format(now)}.png");
  }

  static Future<String?> uploadArtwork(ArtWork artWork) async {
    return (await RemoteDataSource.uploadArtwork(artWork)).toString();
  }

  static Future<ArtWork> getArtwork(String artId) {
    return RemoteDataSource.getArtwork(artId);
  }

  static Future<List<ArtWork>> getArtworksByGalleryType(GalleryType type) {
    return RemoteDataSource.getArtworkByType(type);
  }

  static Future<void> like(ArtWork artwork) {
    return LocalDataSource.like(artwork);
  }

  static Future<void> unLike(int artId) {
    return LocalDataSource.unlike(artId);
  }

  static Future<List<ArtWork>> getLikes() {
    return LocalDataSource.getLikes();
  }

  static listenLikes(Function() listener) {
    return LocalDataSource.listenLikes(listener);
  }
}
