import 'package:hive/hive.dart';

part 'search_record_model.g.dart';

@HiveType(typeId: 1)
class SearchRecord {
  @HiveField(0)
  final String keyword;

  @HiveField(1)
  final int time;


  SearchRecord({required this.keyword, required this.time});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchRecord &&
          runtimeType == other.runtimeType &&
          keyword == other.keyword;

  @override
  int get hashCode => keyword.hashCode;

  @override
  String toString() {
    return 'SearchRecord{keyword: $keyword, time: $time}';
  }
}
