import 'package:dally/presentation/temp/set_profile/temp_set_profile_controller.dart';
import 'package:dally/resource/values/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import '../../../resource/values/colors.dart';
import '../../global_widgets.dart';

class TempSetProfilePage extends GetView<TempSetProfileController> {
  const TempSetProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _titleSection(), flex: 2),
          Expanded(child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 14),
            children: [
              _profileSection(),
              const SizedBox(height: 12),
              _inputSection()
            ],
          ), flex: 6),
          Expanded(child: _buttonSection(), flex: 2),
        ],
      ),
    ));
  }

  _titleSection() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text("등록을 위해 프로필을 설정해주세요.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text("작품에 보이는 이름과 사진이에요."),
          ]);

  _profileSection() => SizedBox(
      width: double.infinity,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Screenshot(
                  controller: controller.profileScreenshotController,
                  child: Obx(() => Container(
                        width: 94,
                        height: 94,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: controller.profileImagePath.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: Image.network(
                                    controller.profileImagePath.value!,
                                    fit: BoxFit.cover),
                              )
                            : SvgPicture.asset(
                                "${Path.imagePath}/profile_none.svg",
                                width: 94),
                      ))),
              Positioned(
                right: 0,
                bottom: 0,
                child: button(
                    onTap: controller.addProfileImage,
                    color: ColorPalette.mainBlue,
                    cornerRadius: 200,
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child:
                          Icon(Icons.add, size: 20, color: ColorPalette.white),
                    )),
              ),
            ]),
            const SizedBox(height: 24),
            Text(
              controller.nickName.value != "" ? controller.nickName.value : "작가 이름",
              style: const TextStyle(
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              controller.introduce.value != ""
                  ? controller.introduce.value
                  : "한줄 소개",
              style: const TextStyle(
                  letterSpacing: 0.5, color: ColorPalette.subText),
            ),
          ],
        ),
      ));

  _inputSection() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // name Section
            underlineInput(
                textEditingController: controller.nickNameInputController,
                inputTextStyle: const TextStyle(fontSize: 16),
                label: "작가 이름",
                hint: "최대 10자",
                maxLength: 10,
                keyboardType: TextInputType.name),

            // introduction Section
            const SizedBox(height: 28),
            underlineInput(
                textEditingController: controller.introInputController,
                inputTextStyle: const TextStyle(fontSize: 16),
                label: "한줄 소개",
                hint: "최대 30자",
                maxLength: 30,
                keyboardType: TextInputType.text),
          ]);

  _buttonSection() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() => shadowButton(
                  enable: controller.name.isNotEmpty &&
                      controller.introduce.isNotEmpty &&
                      controller.profileImagePath.value != null,
                  onTap: controller.onClick,
                  color: ColorPalette.black,
                  disabledColor: ColorPalette.gray200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shadowColor: const Color(0x26000000),
                  child: const Text(
                    "완료",
                    style: TextStyle(
                        color: ColorPalette.white,
                        fontSize: 18,
                        letterSpacing: 0.5),
                    textAlign: TextAlign.center,
                  ),
                )),
          ]);
}
