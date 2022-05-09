import 'package:dally/presentation/temp/upload/temp_upload_bottom_sheet.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/user_repository.dart';

class TempMainController extends GetxController {
  final isLogin = false.obs;

  onClick() async {
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

  @override
  void onInit() async {
    isLogin(await UserRepository.isSigned());
    try {
      final bool? isUploaded = Get.arguments["upload"];
      if (isUploaded != null && isUploaded) {
        Get.rawSnackbar(message: "업로드에 성공하였습니다!");
      }
    } catch (e) {}
    super.onInit();
  }
}
