import 'package:dally/presentation/temp/upload/temp_upload_bottom_sheet.dart';
import 'package:dally/presentation/temp/upload/temp_upload_controller.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/resource/values/path.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dally/data/enums.dart';

import '../../global_widgets.dart';

class TempUploadPage extends GetView<TempUploadController> {
  const TempUploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 32),
          children: [
            Row(children: [
              button(
                  onTap: () => Get.offAllNamed(Routes.tempMain),
                  child: const Icon(Icons.arrow_back_ios, size: 22),
                  padding: const EdgeInsets.symmetric(vertical: 4)),
            ]),
            const SizedBox(height: 32),
            _imageSection(),
            const SizedBox(height: 32),
            _inputSection(),
          ],
        )),
        SizedBox(
            width: double.infinity,
            child: Obx(() => button(
                enable: controller.imagePath.isNotEmpty &&
                    controller.title.isNotEmpty &&
                    controller.info.isNotEmpty &&
                    controller.tag.isNotEmpty &&
                    controller.galleryType.value != GalleryType.none,
                onTap: controller.submit,
                padding: const EdgeInsets.symmetric(vertical: 24),
                color: ColorPalette.black,
                disabledColor: ColorPalette.gray200,
                child: const Text(
                  "등록하기",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.white,
                      fontSize: 18),
                  textAlign: TextAlign.center,
                )))),
      ],
    ));
  }

  Widget _imageSection() => Obx(() => SizedBox(
      width: double.infinity,
      height: controller.imagePath.isNotEmpty ? null : 200,
      child: button(
        onTap: controller.addImageClick,
        color: ColorPalette.gray200,
        child: Obx(() => controller.imagePath.isNotEmpty
            ? Image.network(controller.imagePath.value)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("${Path.imagePath}/temp_upload_icon.svg",
                      height: 54, color: ColorPalette.gray300)
                ],
              )),
      )));

  _inputSection() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // title Section
            underlineInput(
                textEditingController: controller.titleInputController,
                inputTextStyle: const TextStyle(fontSize: 16),
                label: "제목",
                labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                hint: "작품의 제목을 기입합니다",
                maxLength: 50,
                keyboardType: TextInputType.text),

            // info Section
            const SizedBox(height: 28),
            underlineInput(
                textEditingController: controller.infoInputController,
                inputTextStyle: const TextStyle(fontSize: 16),
                label: "작품 설명",
                labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                hint: "작품에 대해 자유롭게 설명 합니다",
                maxLine: 3,
                keyboardType: TextInputType.multiline),

            // tag Section
            const SizedBox(height: 28),
            underlineInput(
                textEditingController: controller.tagInputController,
                inputTextStyle: const TextStyle(fontSize: 16),
                label: "작품 태그 (최대 5개)",
                labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                hint: "태그는 띄어쓰기로 구분합니다",
                maxLength: 50,
                keyboardType: TextInputType.text),
            const SizedBox(height: 28),
            const Text("선택된 전시관",
                style: TextStyle(fontWeight: FontWeight.w500)),
            button(
                onTap: _showSelectBottomSheet,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Text(controller.galleryType.value.korean,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16))),
                    const Icon(Icons.arrow_forward_ios,
                        size: 24, color: ColorPalette.black),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 16)),
          ]);

  // function
  _showSelectBottomSheet() => showModalBottomSheet(
      context: Get.context!,
      backgroundColor: ColorPalette.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return tempUploadBottomSheet(
            onClear: () => Get.back(),
            onSelect: (type) {
              controller.galleryType(type);
              Get.back();
            });
      });
}
