enum LoginMode { none, login, register }

enum OTPStatus { none, sent }

enum GalleryType { illustration, drawing, landscape, portrait, stillLife, none }

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
