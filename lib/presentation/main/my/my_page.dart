import 'package:cached_network_image/cached_network_image.dart';
import 'package:dally/core/util/alert_util.dart';
import 'package:dally/data/enums.dart';
import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/user_model.dart';
import 'package:dally/presentation/global_widgets.dart';
import 'package:dally/presentation/user/user_page.dart';
import 'package:dally/resource/values/path.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../resource/values/colors.dart';
import 'my_controller.dart';

class MyPage extends GetView<MyController> {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: ListView(
        controller: ScrollController(),
        padding: const EdgeInsets.only(top: 78, bottom: 28),
        children: [
          _profileSection(),
          _artworkSection(),
        ],
      ),
    );
  }

  _profileSection() => Container(
      color: ColorPalette.white,
      width: double.infinity,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: button(
                      onTap: () {
                        // todo
                        Alert.show("준비중인 기능입니다.");
                      },
                      child: SvgPicture.asset(
                          "${Path.imagePath}/icon_setting.svg")),
                )
              ],
            ),
            const SizedBox(height: 2),
            Obx(() => Container(
                  width: 94,
                  height: 94,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: controller.user.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Image.network(
                              controller.user.value!.profileImageUrl,
                              fit: BoxFit.cover),
                        )
                      : SvgPicture.asset("${Path.imagePath}/profile_none.svg",
                          width: 94),
                )),
            const SizedBox(height: 24),
            Text(
              controller.user.value?.nickName ?? "",
              style: const TextStyle(
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              controller.user.value?.introduction ?? "",
              style: const TextStyle(
                  letterSpacing: 0.5, color: ColorPalette.subText),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("${Path.imagePath}/icon_my_heart.svg"),
                        const SizedBox(width: 16),
                        const Text("16", style: TextStyle(letterSpacing: 0.5)),
                      ],
                    )),
                const SizedBox(width: 24),
                button(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            "${Path.imagePath}/icon_my_message.svg"),
                        const SizedBox(width: 16),
                        const Text("11", style: TextStyle(letterSpacing: 0.5)),
                      ],
                    )),
              ],
            ),
            const SizedBox(height: 28),
          ],
        ),
      ));

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
                                padding: const EdgeInsets.fromLTRB(24, 4, 0, 4),
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
                                                    color:
                                                        ColorPalette.subText)),
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

  _artworkSection() => Container(
        color: ColorPalette.backGroundGray,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: DropdownButton(
                    underline: Container(),
                    value: controller.nowGalleryType.value,
                    items: [
                      DropdownMenuItem(
                          child: Text(GalleryType.none.korean),
                          value: GalleryType.none),
                      DropdownMenuItem(
                          child: Text(GalleryType.illustration.korean),
                          value: GalleryType.illustration),
                      DropdownMenuItem(
                          child: Text(GalleryType.drawing.korean),
                          value: GalleryType.drawing),
                      DropdownMenuItem(
                          child: Text(GalleryType.landscape.korean),
                          value: GalleryType.landscape),
                      DropdownMenuItem(
                          child: Text(GalleryType.portrait.korean),
                          value: GalleryType.portrait),
                      DropdownMenuItem(
                          child: Text(GalleryType.stillLife.korean),
                          value: GalleryType.stillLife),
                    ],
                    onChanged: controller.typeOnChanged,
                  ),
                ),
                Obx(() => Column(
                      children:
                          (controller.nowGalleryType.value == GalleryType.none
                                  ? controller.artworks
                                  : controller.filteredArtworks)
                              .map((art) => Obx(() => _tempArtworkItem(
                                  owner: controller.user.value!,
                                  artwork: art,
                                  isLiked:
                                      controller.likeList.contains(art.artId))))
                              .toList(),
                    )),
              ],
            )),
      );
}
