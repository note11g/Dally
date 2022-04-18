import 'package:dally/presentation/temp/upload/temp_upload_bottom_sheet.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempMainController extends GetxController {
  final isLogin = true.obs;

  onClick() {
    if (isLogin.value) {
      _startUpload();
    } else {
      _goLogin();
    }
  }

  _goLogin() => Get.toNamed(Routes.tempLogin);

  _startUpload() {
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
  }
}
