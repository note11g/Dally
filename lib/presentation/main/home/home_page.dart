import 'dart:ui';

import 'package:dally/data/enums.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/resource/values/path.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child:
                SvgPicture.asset("${Path.imagePath}/home_line_top_right.svg"),
            right: 0,
            top: 0),
        Positioned(
            child: SvgPicture.asset(
                "${Path.imagePath}/home_line_bottom_right.svg"),
            right: 0,
            bottom: 0),
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 64),
          children: [
            const Text(
              "전시관",
              style: TextStyle(
                  color: ColorPalette.mainBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 38),
            _navigateButton(GalleryType.illustration, rightPosition: 20),
            const SizedBox(height: 20),
            _navigateButton(GalleryType.drawing, rightPosition: 24),
            const SizedBox(height: 20),
            _navigateButton(GalleryType.landscape),
            const SizedBox(height: 20),
            _navigateButton(GalleryType.portrait),
            const SizedBox(height: 20),
            _navigateButton(GalleryType.stillLife),
          ],
        )
      ],
    );
  }

  Widget _navigateButton(GalleryType type, {double? rightPosition}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: ColorPalette.black,
        child: InkWell(
          onTap: () => Get.toNamed("${Routes.gallery}?type=${type.name}"),
          child: Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 93,
              ),
              Positioned(
                  child: SvgPicture.asset(
                      "${Path.imagePath}/main_btn_resource/left_line_${type.name}.svg"),
                  left: 0,
                  top: 0),
              if (rightPosition != null)
                Positioned(
                    child: SvgPicture.asset(
                        "${Path.imagePath}/main_btn_resource/right_line_${type.name}.svg"),
                    right: 0,
                    top: rightPosition),
              Positioned(
                  // text position is constant
                  child: SvgPicture.asset(
                      "${Path.imagePath}/main_btn_resource/text_${type.name}.svg"),
                  right: 13,
                  bottom: 10),
            ],
          ),
        ),
      ),
    );
  }
}
