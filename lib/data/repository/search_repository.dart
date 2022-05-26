import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/search_model.dart';
import 'package:dally/data/model/search_record_model.dart';
import 'package:dally/data/model/trend_model.dart';
import 'package:dally/data/source/local_data_source.dart';
import 'package:dally/data/source/remote_data_source.dart';

class SearchRepository {
  static Future saveKeyword(String keyword) async {
    final time = DateTime.now().millisecondsSinceEpoch;
    final record = SearchRecord(keyword: keyword, time: time);

    await LocalDataSource.saveSearchKeyword(record);
  }

  static Future<List<SearchRecord>> getKeywords() {
    return LocalDataSource.getSearchKeywords();
  }

  static Future deleteKeyword(SearchRecord record) {
    return LocalDataSource.deleteSearchKeyword(record);
  }

  static Future<Trend?> getTrend() {
    return RemoteDataSource.getTrends();
  }

  static Future<Search?> search(String keyword) {
    return RemoteDataSource.search(keyword);
  }

  static Future<List<ArtWork>> getUsersArtworks(String uid) {
    return RemoteDataSource.getUsersArtworks(uid);
  }
}
