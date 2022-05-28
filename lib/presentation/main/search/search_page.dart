import 'package:cached_network_image/cached_network_image.dart';
import 'package:dally/data/enums.dart';
import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/user_model.dart';
import 'package:dally/presentation/global_widgets.dart';
import 'package:dally/presentation/widgets/AnimatedNavigationBar.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/resource/values/path.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'search_controller.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _inputSection(),
          Expanded(child: Obx(() {
            switch (controller.mode.value) {
              case 0:
                return _noneMode();
              case 1:
                return _searchMode();
              default:
                return _searchedMode();
            }
          })),
        ],
      ),
    );
  }

  Widget _noneMode() {
    return ListView(
      controller: ScrollController(),
      children: [
        Obx(() => _hashTagSection(rankList: controller.trendHashTagList)),
        const SizedBox(height: 12),
        _todayArtworkSection(),
      ],
    );
  }

  Widget _searchMode() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("최근 검색어",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: -0.2)),
          const SizedBox(height: 8),
          Expanded(
              child: ListView.builder(
                  itemCount: controller.recentSearchList.length,
                  controller: ScrollController(),
                  itemBuilder: (context, index) {
                    final searchRecent = controller.recentSearchList[index];
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () =>
                                controller.search(searchRecent.keyword),
                            child: Text(searchRecent.keyword,
                                style: const TextStyle(fontSize: 16)),
                          )),
                          InkWell(
                            onTap: () =>
                                controller.deleteSearchKeyword(searchRecent),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                  "${Path.imagePath}/icon_clear.svg"),
                            ),
                          )
                        ]);
                  }))
        ]));
  }

  Widget _searchedMode() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                offset: Offset(0, 8), blurRadius: 8, color: Color(0x0F000000))
          ]),
          child: Obx(() => AnimatedNavigationBar(
              backgroundColor: ColorPalette.white,
              indicatorColor: ColorPalette.mainBlue,
              indicatorPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              onTap: controller.searchResultTab,
              items: const [
                BottomNavigationBarItem(
                    icon: Text(
                      "작품",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.subText),
                    ),
                    activeIcon: Text(
                      "작품",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.mainBlue),
                    )),
                BottomNavigationBarItem(
                    icon: Text(
                      "작가",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.subText),
                    ),
                    activeIcon: Text(
                      "작가",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.mainBlue),
                    ))
              ],
              currentIndex: controller.searchResultTab.value)),
        ),
        Expanded(
            child: Obx(() => IndexedStack(
                  index: controller.searchResultTab.value,
                  children: [
                    ListView.builder(
                        controller: ScrollController(),
                        padding: const EdgeInsets.symmetric(vertical: 26),
                        itemCount: controller.searchResult.length,
                        itemBuilder: (context, index) {
                          final artwork = controller.searchResult[index];
                          final user = controller.searchResultUserList[index];
                          return Obx(() => _tempArtworkItem(
                              isLiked: controller.likeArtworksId
                                  .contains(artwork.artId!),
                              artwork: artwork,
                              owner: user));
                        }),
                    ListView.builder(
                      controller: ScrollController(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 26, horizontal: 36),
                      itemCount: controller.searchUserList.length,
                      itemBuilder: (context, index) {
                        final user = controller.searchUserList[index];
                        return Obx(() => _tempUserItem(user,
                            artworks:
                                controller.usersArtworksMap[user.uid!] ?? []));
                      },
                    )
                  ],
                ))),
      ],
    );
  }

  Widget _inputSection() {
    return Container(
      decoration: BoxDecoration(color: ColorPalette.white, boxShadow: [
        BoxShadow(
            color: ColorPalette.black.withOpacity(0.08),
            offset: const Offset(0, 1),
            blurRadius: 6,
            spreadRadius: 0)
      ]),
      padding: const EdgeInsets.fromLTRB(36, 72, 36, 24),
      child: Container(
        color: ColorPalette.gray100,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("${Path.imagePath}/icon_search.svg"),
            const SizedBox(width: 12),
            Expanded(
                child: input(
                    textEditingController: controller.searchInputController,
                    hint: "D’Ally 내에서 검색",
                    onTap: () => controller.mode.value = 1,
                    textInputAction: TextInputAction.search,
                    onSubmitted: controller.search,
                    keyboardType: TextInputType.text,
                    hintStyle: const TextStyle(
                        color: ColorPalette.gray300,
                        fontSize: 16,
                        letterSpacing: 0.5))),
          ],
        ),
      ),
    );
  }

  Widget _hashTagSection({required List<String> rankList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rankList
            .asMap()
            .entries
            .map((e) => Container(
                margin: const EdgeInsets.only(top: 4),
                child: button(
                  onTap: () => controller.search(e.value),
                  child: Row(children: [
                    _rankIcon(e.key + 1),
                    const SizedBox(width: 6),
                    Text(e.value,
                        style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: -0.2,
                        ))
                  ]),
                )))
            .toList()
          ..insert(
              0,
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: const Text("인기 해시태그",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: -0.2)),
              )),
      ),
    );
  }

  Widget _todayArtworkSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: Text("오늘의 작품",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: -0.2)),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Column(
              children: controller.trendArtworkList
                  .asMap()
                  .entries
                  .map((entry) => _tempArtworkItem(
                      isLiked:
                          controller.likeArtworksId.contains(entry.value.artId),
                      artwork: entry.value,
                      owner: controller.trendArtworkUserList[entry.key]))
                  .toList()),
        )
      ],
    );
  }

  Widget _tempArtworkItem(
      {required ArtWork artwork, required User owner, bool? isLiked}) {
    const double _height = 274 + 28;

    return button(
      onTap: () => Get.toNamed("${Routes.gallery}?id=${artwork.artId}"),
      child: Container(
        height: _height,
        margin: const EdgeInsets.symmetric(horizontal: 26),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned(
              top: 21,
              left: 0,
              right: 0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: ColorPalette.black.withOpacity(0.08),
                            offset: const Offset(1, 2),
                            blurRadius: 6,
                            spreadRadius: 0)
                      ]),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Column(children: [
                            SizedBox(
                              height: 192,
                              child: CachedNetworkImage(
                                width: double.infinity,
                                imageUrl: artwork.artImageUrl,
                                fit: BoxFit.fitWidth,
                                placeholder: (context, _) => const Center(
                                  child: CircularProgressIndicator(
                                      color: ColorPalette.mainBlue),
                                ),
                              ),
                            ),
                            Container(
                              color: ColorPalette.white,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.fromLTRB(14, 14, 14, 12),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(artwork.title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5)),
                                    Wrap(
                                      children: artwork.tags
                                          .map((e) => Text(
                                              "#${e.replaceAll("#", "")} ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: ColorPalette.gray300)))
                                          .toList(),
                                    )
                                  ]),
                            )
                          ])))),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: button(
                  onTap: () => Get.toNamed("${Routes.user}?uid=${owner.uid}"),
                  child: SizedBox(
                    height: 42,
                    child: Stack(children: [
                      Positioned(
                          left: 24,
                          top: 0,
                          bottom: 0,
                          child: Center(
                              child: Container(
                                  width: 132,
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 4, 0, 4),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorPalette.black
                                                .withOpacity(0.08),
                                            offset: const Offset(0, 1),
                                            blurRadius: 6,
                                            spreadRadius: 0)
                                      ],
                                      color: ColorPalette.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(owner.nickName,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(artwork.gallery.korean,
                                                  style: const TextStyle(
                                                      fontSize: 8,
                                                      color: ColorPalette
                                                          .subText)),
                                            ])
                                      ])))),
                      Positioned(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: CachedNetworkImage(
                              errorWidget: (ctx, msg, e) => Container(
                                color: ColorPalette.mainBlue,
                              ),
                              imageUrl: owner.profileImageUrl,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                )),
            Positioned(
              top: 192,
              right: 16,
              child: button(
                  color: ColorPalette.white,
                  cornerRadius: 9999,
                  onTap: () =>
                      controller.tapLike(artwork, isLiked: isLiked ?? false),
                  padding: const EdgeInsets.all(11),
                  child: isLiked == true
                      ? SvgPicture.asset("${Path.imagePath}/icon_like.svg")
                      : SvgPicture.asset("${Path.imagePath}/icon_unlike.svg",
                          width: 22, height: 20)),
            )
          ],
        ),
      ),
    );
  }

  Widget _tempUserItem(User user, {required List<ArtWork> artworks}) {
    return button(
      onTap: () => Get.toNamed("${Routes.user}?uid=${user.uid}"),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 56,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: CachedNetworkImage(
                      imageUrl: user.profileImageUrl,
                      placeholder: (ctx, _) => Container(
                          color: ColorPalette.mainBlue,
                          child: const Center(
                              child: CircularProgressIndicator(
                                  color: ColorPalette.white))),
                    ),
                  )),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.nickName,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.5)),
                  const SizedBox(width: 1),
                  Text(user.introduction,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.subText,
                          letterSpacing: 0.5)),
                ],
              )),
              SvgPicture.asset("${Path.imagePath}/icon_arrow_right.svg")
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 14),
            child:
                Divider(color: ColorPalette.gray100, height: 1, thickness: 1),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  color: const Color(0xFFD3DAE3),
                  child: artworks.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: artworks[0].artImageUrl,
                          fit: BoxFit.fitWidth,
                          width: double.infinity)
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 70,
                  color: const Color(0xFFD3DAE3),
                  child: artworks.length > 1
                      ? CachedNetworkImage(
                          imageUrl: artworks[1].artImageUrl,
                          fit: BoxFit.fitWidth,
                          width: double.infinity)
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 70,
                  color: const Color(0xFFD3DAE3),
                  child: artworks.length > 2
                      ? CachedNetworkImage(
                          imageUrl: artworks[2].artImageUrl,
                          fit: BoxFit.fitWidth,
                          width: double.infinity)
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rankIcon(int rank) {
    return Stack(
      children: [
        SvgPicture.asset("${Path.imagePath}/icon_base_ranking.svg"),
        Positioned(
            child: Center(
                child: Text("$rank",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: ColorPalette.white))),
            top: 0,
            bottom: 0,
            left: 0,
            right: 0),
      ],
    );
  }
}
