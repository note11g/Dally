import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/trend_model.dart';
import 'package:dally/data/model/user_model.dart';
import 'package:dally/data/repository/artwork_repository.dart';
import 'package:dally/data/repository/search_repository.dart';
import 'package:dally/data/repository/user_repository.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final tab = 0.obs;

  final likeArtworks = <ArtWork>[].obs;
  final likeArtworksUserMap = <String, User?>{}.obs;

  final likeUsers = <User>[].obs;
  final likeUsersArtworks = <ArtWork>[].obs;

  @override
  void onInit() {
    ArtworkRepository.getLikes().then((artworks) async {
      for (final art in artworks) {
        await UserRepository.getUser(userId: art.owner).then((User? user) {
          likeArtworksUserMap[art.owner] = user;
        });
      }

      likeArtworks.assignAll(artworks);
    });

    ArtworkRepository.listenLikes(() {
      ArtworkRepository.getLikes().then((artworks) async {
        for (final art in artworks) {
          if (!likeArtworksUserMap.containsKey(art.owner)) {
            await UserRepository.getUser(userId: art.owner).then((User? user) {
              likeArtworksUserMap[art.owner] = user;
            });
          }
        }

        likeArtworks.assignAll(artworks);
      });
    });

    SearchRepository.getTrend().then((Trend? t) async {
      final artworks = t?.artworks ?? [];
      if (artworks.isNotEmpty) {
        likeUsers.clear();
        likeUsersArtworks.clear();
        for (final art in artworks) {
          if (!likeArtworksUserMap.containsKey(art.owner)) {
            likeArtworksUserMap[art.owner] =
                await UserRepository.getUser(userId: art.owner);
          }
          final user = likeArtworksUserMap[art.owner];
          if (user != null) {
            likeUsers.add(user);
            likeUsersArtworks.add(art);
          }
        }
      }
    });

    super.onInit();
  }

  void tapLike(ArtWork artwork, {required bool isLiked}) async {
    print("[tapped!] ${artwork.toJson()}");
    isLiked
        ? ArtworkRepository.unLike(artwork.artId!)
        : ArtworkRepository.like(artwork);
  }
}
