import 'package:dally/presentation/global_widgets.dart';
import 'package:dally/presentation/temp/main/temp_main_controller.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/resource/values/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TempMainPage extends GetView<TempMainController> {
  const TempMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        if (MediaQuery.of(context).size.width <= 580)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("${Path.imagePath}/temp_main_1.svg",
                  width: MediaQuery.of(context).size.width),
              SvgPicture.asset("${Path.imagePath}/temp_main_2.svg",
                  width: MediaQuery.of(context).size.width)
            ],
          ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("${Path.imagePath}/temp_logo_sub.svg",
                      height: MediaQuery.of(context).size.height / 40),
                  const SizedBox(height: 12),
                  Image.asset("${Path.imagePath}/temp_logo_main.png",
                      height: MediaQuery.of(context).size.height / 12),
                ],
              ),
              const SizedBox(height: 128),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: shadowButton(
                  onTap: controller.onClick,
                  color: ColorPalette.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shadowColor: const Color(0x26000000),
                  child: Obx(
                    () => Text(
                      controller.isLogin.value ? "작품 업로드 하기" : "시작하기",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: ColorPalette.white,
                          fontSize: 18,
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
