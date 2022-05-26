import 'package:cached_network_image/cached_network_image.dart';
import 'package:dally/data/enums.dart';
import 'package:dally/resource/values/path.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/model/artwork_model.dart';
import '../../../data/model/user_model.dart';
import '../../../resource/values/colors.dart';
import '../../global_widgets.dart';
import '../../widgets/AnimatedNavigationBar.dart';
import 'favorite_controller.dart';

class FavoritePage extends GetView<FavoriteController> {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
              padding: const EdgeInsets.only(top: 64),
              onTap: controller.tab,
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
              currentIndex: controller.tab.value)),
        ),
        Expanded(
            child: Obx(() => IndexedStack(
                  index: controller.tab.value,
                  children: [
                    ListView.builder(
                        controller: ScrollController(),
                        padding: const EdgeInsets.symmetric(vertical: 26),
                        itemCount: controller.likeArtworks.length,
                        itemBuilder: (context, index) {
                          final artwork = controller.likeArtworks[index];
                          final user =
                              controller.likeArtworksUserMap[artwork.owner];
                          return _tempArtworkItem(
                              isLiked: true, artwork: artwork, owner: user!);
                        }),
                    ListView(
                      controller: ScrollController(),
                      padding: const EdgeInsets.only(bottom: 26),
                      children: [
                        Container(
                          color: ColorPalette.white,
                          padding: const EdgeInsets.only(top: 24, bottom: 16),
                          child: _profilesSection(),
                        ),
                        const SizedBox(height: 24),
                        Column(
                          children: controller.likeUsersArtworks
                              .asMap()
                              .entries
                              .map((m) => _tempArtworkItem(
                                  artwork: m.value,
                                  owner: controller
                                      .likeArtworksUserMap[m.value.owner]!))
                              .toList(),
                        )
                      ],
                    )
                  ],
                ))),
      ],
    ));
  }

  Widget _profilesSection() {
    return SingleChildScrollView(
      child: Row(
        children: controller.likeUsers
            .asMap()
            .entries
            .map((m) => Padding(
                  padding: (m.key == 0)
                      ? const EdgeInsets.only(left: 36, right: 14)
                      : const EdgeInsets.only(right: 14),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999)),
                            child: CachedNetworkImage(
                              imageUrl: m.value.profileImageUrl,
                            ),
                          ),
                          if (m.key == 0 || m.key == 1)
                            Positioned(
                                bottom: 4,
                                right: 1,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: ColorPalette.white,
                                      borderRadius:
                                          BorderRadius.circular(99.0)),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorPalette.mainBlue,
                                          borderRadius:
                                              BorderRadius.circular(99.0))),
                                ))
                        ],
                      ),
                      Text(m.value.nickName,
                          style: const TextStyle(letterSpacing: 0.5))
                    ],
                  ),
                ))
            .toList(),
      ),
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
}
