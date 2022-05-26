import 'package:hive/hive.dart';

part 'enums.g.dart';

enum LoginMode { none, login, register }

enum OTPStatus { none, sent }

@HiveType(typeId: 4)
enum GalleryType {
  @HiveField(0)
  illustration,
  @HiveField(1)
  drawing,
  @HiveField(2)
  landscape,
  @HiveField(3)
  portrait,
  @HiveField(4)
  stillLife,
  @HiveField(5)
  none
}

extension StringToGalleryType on String {
  GalleryType toGalleryType() {
    for (var type in GalleryType.values) {
      if (this == type.name) return type;
    }
    return GalleryType.none;
  }
}

extension GalleryToKorean on GalleryType {
  String get korean {
    switch (this) {
      case GalleryType.illustration:
        return "일러스트";
      case GalleryType.drawing:
        return "드로잉";
      case GalleryType.landscape:
        return "풍경화";
      case GalleryType.portrait:
        return "인물화";
      case GalleryType.stillLife:
        return "정물화";
      case GalleryType.none:
        return "선택 안됨";
    }
  }
}
