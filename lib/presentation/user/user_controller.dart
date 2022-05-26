import 'package:dally/data/enums.dart';
import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/user_model.dart';
import 'package:dally/data/repository/artwork_repository.dart';
import 'package:dally/data/repository/search_repository.dart';
import 'package:dally/data/repository/user_repository.dart';
import 'package:dally/routes/routes.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Rx<User?> user = (null as User?).obs;
  final artworks = <ArtWork>[].obs;
  final likeList = <int>[].obs;
  final filteredArtworks = <ArtWork>[].obs;
  final nowGalleryType = GalleryType.none.obs;

  @override
  void onInit() {
    final userId = Get.parameters["uid"] ?? "";



    ever(user, (User? user) {
      if (user != null) {
        SearchRepository.getUsersArtworks(user.uid!.toString())
            .then((artworks) {
          this.artworks.assignAll(artworks);
        });
      }
    });

    ArtworkRepository.getLikes().then((likes) {
      likeList.clear();
      for (var likeArtwork in likes) {
        likeList.add(likeArtwork.artId!);
      }
    });

    if (userId.isNotEmpty) {
      UserRepository.getUser(userId: userId).then((v) {
        if (v != null) {
          user.value = v;
        }
      });
    } else {
      Get.offAllNamed(Routes.main);
    }

    super.onInit();
  }

  void tapLike(ArtWork artwork, {required bool isLiked}) async {
    print("[tapped!] ${artwork.toJson()}");
    isLiked
        ? ArtworkRepository.unLike(artwork.artId!)
        : ArtworkRepository.like(artwork);

    ArtworkRepository.getLikes().then((likes) {
      likeList.clear();
      for (var likeArtwork in likes) {
        likeList.add(likeArtwork.artId!);
      }
    });
  }

  void typeOnChanged(GalleryType? t) {
    print(t?.korean);
    if (t != null) {
      nowGalleryType.value = t;
      if (t != GalleryType.none) {
        filteredArtworks.clear();
        for (final art in artworks) {
          if (art.gallery == t) {
            filteredArtworks.add(art);
          }
        }
      }
    }
  }
}
