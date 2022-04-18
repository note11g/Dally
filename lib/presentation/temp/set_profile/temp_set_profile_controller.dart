
import 'dart:io';
import 'dart:typed_data';

import 'package:dally/routes/routes.dart';
import 'package:download/download.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class TempSetProfileController extends GetxController {
  final nameInputController = TextEditingController();
  final introInputController = TextEditingController();

  final profileScreenshotController = ScreenshotController();

  final name = "".obs;
  final introduce = "".obs;

  late final String uid;

  final Rx<String?> profileImagePath = Rx<String?>(null);

  @override
  void onInit() {
    final String? uid = Get.arguments != null
        ? Get.arguments["uid"]
        : (kDebugMode ? "debugModeNullUid" : null);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (uid == null) Get.offAllNamed(Routes.tempMain);
    });
    if (uid != null) {
      this.uid = uid;
      print(uid);
    }

    nameInputController.addListener(() {
      name.value = nameInputController.text;
    });
    introInputController.addListener(() {
      introduce.value = introInputController.text;
    });

    super.onInit();
  }

  Future<void> onClick() async {
    _getLoadedImage();
  }

  Future<void> addProfileImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    profileImagePath.value = image.path;
  }

  Future<void> _getLoadedImage() async {
    try {
      final rawImageData = (await profileScreenshotController.capture())!;
      final stream = Stream.fromIterable(rawImageData);

      download(stream, "profile_test.png");

    } catch (e) {
      Get.rawSnackbar(message: "이미지 압축 오류 발생. 다시 시도 하거나, 개발자에게 문의해주세요.\n$e");
    }
  }
}
