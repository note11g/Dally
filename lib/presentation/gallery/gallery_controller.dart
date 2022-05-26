import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dally/data/enums.dart';
import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/user_model.dart';
import 'package:dally/data/repository/artwork_repository.dart';
import 'package:dally/data/repository/user_repository.dart';
import 'package:dally/routes/routes.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  final sliderController = CarouselController();
  final bottomDrawerController = BottomDrawerController();

  // ignore: unnecessary_cast
  final nowArtwork = (null as ArtWork?).obs;

  final nowIndex = 0.obs;

  final nowCategory = GalleryType.none.obs;
  final nowList = <ArtWork>[].obs;
  final nowUserMap =
      <String, User>{}.obs; // todo : nowArtworksUser migrate to this

  final likeList = <int>[].obs;

  @override
  void onInit() {
    final artId = Get.parameters["id"] ?? "";
    final galleryType = Get.parameters["type"] ?? "";

    print("artwork id : ${Get.parameters["id"]}");

    ever(nowArtwork, (ArtWork? artwork) {
      if (artwork != null) {
        if (!nowUserMap.containsKey(artwork.owner.toString())) {
          UserRepository.getUser(userId: artwork.owner.toString()).then((it) {
            if (it != null) {
              nowUserMap[artwork.owner.toString()] = it;
            }
          });
        }
      }
    });

    ArtworkRepository.getLikes().then((likes) {
      likeList.clear();
      for (var likeArtwork in likes) {
        likeList.add(likeArtwork.artId!);
      }
    });

    ArtworkRepository.listenLikes(() {
      ArtworkRepository.getLikes().then((likes) {
        likeList.clear();
        for (var likeArtwork in likes) {
          likeList.add(likeArtwork.artId!);
        }
      });
    });

    // artId만 들어온 경우
    if (artId.isNotEmpty && galleryType.isEmpty) {
      ArtworkRepository.getArtwork(artId).then((v) {
        nowArtwork.value = v;

        nowList.clear();
        nowList.add(v);
        // todo : 랜덤으로 nowList 채우기
      });
    } else if (galleryType.isNotEmpty) {
      final type = galleryType.toGalleryType();
      nowCategory.value = type;
      ArtworkRepository.getArtworksByGalleryType(type).then((v) {
        v.shuffle();
        nowList.assignAll(v);

        for (final artwork in nowList) {
          if (artwork.artId.toString() == artId) {
            nowArtwork.value = artwork;
          }
        }

        if (nowList.isNotEmpty) {
          nowArtwork.value ??= nowList.first;
        } else {
          Get.offAllNamed(Routes.main);
        }
      });
    } else {
      Get.offAllNamed(Routes.main);
    }

    super.onInit();
  }

  void onPageChanged(int index) async {
    print("onPageChanged! index : $index");
    nowIndex.value = index;
    nowArtwork.value = nowList[index];
  }

  void like(ArtWork artwork, bool isLiked) {
    if (isLiked) {
      ArtworkRepository.unLike(artwork.artId!);
    } else {
      ArtworkRepository.like(artwork);
    }
  }
}
