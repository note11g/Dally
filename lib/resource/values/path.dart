import 'package:dally/data/enums.dart';

class Path {
  static const String imagePath = "assets/imgs";

  static String getBottomNavIcon(String name, {bool isFilled = false}) =>
      "$imagePath/main_${name}_${isFilled ? "filled" : "outlined"}_icon.svg";

  static String getGalleryBackgroundImage({required GalleryType type}) =>
      "$imagePath/gallery_background/gallery_${type.name}.svg";
}
