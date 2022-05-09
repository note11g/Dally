import 'dart:typed_data';

import 'package:dally/data/model/artwork_model.dart';
import 'package:intl/intl.dart';

import '../source/remote_data_source.dart';

class ArtworkRepository {
  static Future<String?> uploadArtworkImage(Uint8List raw, {required String uid}) async {
    final now = DateTime.now();
    return await RemoteDataSource.uploadArtworkImage(raw,
        "artwork_${uid}_${DateFormat("yyyyMMdd_hhmmss").format(now)}.png");
  }

  static Future<String?> uploadArtwork(ArtWork artWork) async {
    return (await RemoteDataSource.uploadArtwork(artWork)).toString();
  }


}