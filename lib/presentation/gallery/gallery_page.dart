import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dally/data/enums.dart';
import 'package:dally/data/model/user_model.dart';
import 'package:dally/presentation/global_widgets.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/resource/values/path.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'gallery_controller.dart';

class GalleryPage extends GetView<GalleryController> {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.black,
        body: Center(
          child: Container(
            color: ColorPalette.backGroundGray,
            width: MediaQuery.of(context).size.width <= 500 ? null : 400,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _backgroundImageSection(controller.nowCategory.value,
                      context: context),
                ),
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 72, left: 30),
                      child: _headerSection(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 48, left: 36, right: 36, bottom: 16),
                      child: Obx(() => _profileSection(controller.nowUserMap[
                          "${controller.nowArtwork.value?.owner}"])),
                    ),
                    Obx(() => _pictureSection()),
                    const SizedBox(height: 420)
                  ],
                ),
                _buildBottomDrawer(context),
              ],
            ),
          ),
        ));
  }

  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.symmetric(horizontal: 38),
            decoration: const BoxDecoration(
                color: ColorPalette.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                      child: Container(
                    width: 40,
                    height: 2,
                    color: ColorPalette.mainBlue,
                  )),
                ),
                const SizedBox(height: 8),
                const Text(
                  "제목",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
                const SizedBox(height: 8),
                Obx(() => Text("${controller.nowArtwork.value?.title}",
                    style: const TextStyle(fontSize: 16, letterSpacing: 0.5)))
              ],
            ),
          ),
          Positioned(
              right: 36,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: Material(
                    color: ColorPalette.white,
                    child: GestureDetector(
                      onTapDown: (TapDownDetails a) {
                        (controller.nowArtwork.value != null
                                ? () => controller.like(
                                    controller.nowArtwork.value!,
                                    controller.likeList.contains(
                                        controller.nowArtwork.value?.artId))
                                : null)
                            ?.call();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: AbsorbPointer(
                        child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Obx(() => controller.likeList.contains(
                                    controller.nowArtwork.value?.artId)
                                ? SvgPicture.asset(
                                    "${Path.imagePath}/icon_like.svg",
                                    width: 30,
                                    height: 27)
                                : SvgPicture.asset(
                                    "${Path.imagePath}/icon_unlike.svg",
                                    width: 30,
                                    height: 27))),
                      ),
                    )),
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
        width: double.infinity,
        color: ColorPalette.white,
        child: Obx(() =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "작품설명",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5),
              ),
              const SizedBox(height: 8),
              Text("${controller.nowArtwork.value?.description}",
                  style: const TextStyle(fontSize: 16, letterSpacing: 0.5)),
              const SizedBox(height: 20),
              if (controller.nowArtwork.value != null)
                Wrap(
                  children: controller.nowArtwork.value!.tags
                      .map((e) => Text("#${e.replaceAll("#", "")} ",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: ColorPalette.subText)))
                      .toList(),
                )
            ])),
      ),
      headerHeight: 140,
      drawerHeight: 420,
      // todo : dynamic
      color: Colors.transparent,
      controller: controller.bottomDrawerController,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 60,
          spreadRadius: 5,
          offset: const Offset(2, -6), // changes position of shadow
        ),
      ],
    );
  }

  Row _headerSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        button(
            child: SvgPicture.asset("${Path.imagePath}/icon_arrow_left.svg"),
            onTap: () {
              if (Navigator.canPop(Get.context!)) {
                Get.back();
              } else {
                Get.offNamed(Routes.main);
              }
            }),
        const SizedBox(width: 2),
        if (controller.nowCategory.value != GalleryType.none)
          Obx(() => Text(controller.nowCategory.value.korean,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.mainBlue,
                  letterSpacing: 0.5))),
      ],
    );
  }

  Widget _profileSection(User? user) {
    return button(
        onTap: user != null
            ? () => Get.toNamed("${Routes.user}?uid=${user.uid}")
            : null,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: user != null
                    ? CachedNetworkImage(
                        imageUrl: user.profileImageUrl, width: 56, height: 56)
                    : Container(
                        width: 56,
                        height: 56,
                        color: ColorPalette.transparent)),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user?.nickName ?? "",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5)),
                Text(
                  user?.introduction ?? "",
                  style: const TextStyle(
                      letterSpacing: 0.5, color: ColorPalette.subText),
                )
              ],
            ))
          ],
        ));
  }

  Widget _pictureSection() {
    return CarouselSlider(
      items: controller.nowList
          .map((artwork) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CachedNetworkImage(
                imageUrl: artwork.artImageUrl,
                placeholder: (ctx, str) => const Center(
                    child: CircularProgressIndicator(
                  color: ColorPalette.mainBlue,
                )),
              )))
          .toList(),
      carouselController: controller.sliderController,
      options: CarouselOptions(
        autoPlay: false,
        enableInfiniteScroll: controller.nowList.length != 1,
        aspectRatio: 0.88,
        onPageChanged: (index, _) => controller.onPageChanged(index),
        initialPage: controller.nowIndex.value,
      ),
    );
  }

  Widget _backgroundImageSection(GalleryType type,
      {required BuildContext context}) {
    return type == GalleryType.none
        ? Container()
        : SvgPicture.asset(Path.getGalleryBackgroundImage(type: type),
            width: MediaQuery.of(context).size.width <= 500
                ? MediaQuery.of(context).size.width
                : 400);
  }
}
