import 'package:dally/presentation/temp/upload/temp_upload_bottom_sheet.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final nowPage = 0.obs;
  final navIdx = 0.obs;

  void changeIndex(int i) {
    if (i == 2) {
      showModalBottomSheet(
          context: Get.context!,
          backgroundColor: ColorPalette.transparent,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return tempUploadBottomSheet(
              onClear: () => Get.back(),
              onSelect: (type) =>
                  Get.toNamed("${Routes.tempUpload}?type=${type.name}"),
            );
          });
      return;
    } else if (2 < i) {
      nowPage.value = i - 1;
    } else {
      nowPage.value = i;
    }

    navIdx.value = i;
  }
}
