import 'dart:async';

import 'package:dally/core/util/alert_util.dart';
import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/search_model.dart';
import 'package:dally/data/model/search_record_model.dart';
import 'package:dally/data/repository/artwork_repository.dart';
import 'package:dally/data/repository/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/user_model.dart';
import '../../../data/repository/user_repository.dart';

class SearchController extends GetxService {
  final searchInputController = TextEditingController();

  final mode = 0.obs; // 0 : none, 1 : search, 2 : searched
  final searchResultTab = 0.obs;

  final recentSearchList = <SearchRecord>[].obs;
  final searchResult = <ArtWork>[].obs;
  final searchResultUserList = <User>[].obs; // 작품의 유저 리스트

  final searchUserList = <User>[].obs; // 유저검색
  final usersArtworksMap = <String, List<ArtWork>>{}.obs;

  final trendHashTagList = <String>[].obs;
  final trendArtworkList = <ArtWork>[].obs;
  final trendArtworkUserList = <User>[].obs;

  final likeArtworksId = <int>[].obs;

  @override
  void onInit() {
    SearchRepository.getKeywords()
        .then((value) => recentSearchList.addAll(value));

    SearchRepository.getTrend().then((value) async {
      if (value != null) {
        trendHashTagList
            .assignAll(value.tags.map((e) => e.replaceAll("#", "")));
        for (final artwork in value.artworks) {
          final user = await UserRepository.getUser(userId: artwork.owner);
          trendArtworkUserList.add(user!);
        }
        trendArtworkList.assignAll(value.artworks);
      }
    });

    ArtworkRepository.listenLikes(() {
      ArtworkRepository.getLikes().then((likes) {
        likeArtworksId.clear();
        for (var likeArtwork in likes) {
          likeArtworksId.add(likeArtwork.artId!);
        }
      });
    });

    super.onInit();
  }

  Future<void> search(String k) async {
    final keyword = k.trim();
    print(keyword);
    if (keyword == "") {
      searchInputController.clear();
      Alert.show("키워드를 입력해주세요.");
      return;
    }

    searchResult.clear();
    searchResultUserList.clear();
    searchUserList.clear();
    usersArtworksMap.clear();

    mode.value = 2;
    searchInputController.text = keyword;

    await SearchRepository.saveKeyword(keyword);

    final Search? data =
        await Alert.load(() => SearchRepository.search(keyword));

    if (data == null || (data.artworks.isEmpty && data.users.isEmpty)) {
      mode.value = 0;
      Alert.show("검색 결과가 없어요. 다른 키워드로 다시 검색해주세요.");
      return;
    }

    for (final art in data.artworks) {
      await UserRepository.getUser(userId: art.owner).then((User? user) {
        searchResultUserList.add(user!);
      });
    }

    for (final user in data.users) {
      await SearchRepository.getUsersArtworks(user.uid!).then((artworks) {
        usersArtworksMap[user.uid!] = artworks;
      });
    }

    searchResult.assignAll(data.artworks);
    searchUserList.assignAll(data.users);

    if (searchResult.isEmpty) {
      searchResultTab.value = 1;
    } else {
      searchResultTab.value = 0;
    }

    recentSearchList.assignAll(await SearchRepository.getKeywords());
  }

  void deleteSearchKeyword(SearchRecord record) async {
    await SearchRepository.deleteKeyword(record);
    recentSearchList.assignAll(await SearchRepository.getKeywords());
  }

  void tapLike(ArtWork artwork, {required bool isLiked}) async {
    print("[tapped!] ${artwork.toJson()}");
    isLiked
        ? ArtworkRepository.unLike(artwork.artId!)
        : ArtworkRepository.like(artwork);
  }
}
