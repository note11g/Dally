import 'dart:typed_data';

import 'package:dally/data/model/user_model.dart';
import 'package:dally/data/repository/user_repository.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

import '../../global_widgets.dart';

class TempSetProfileController extends GetxController {
  final nickNameInputController = TextEditingController();
  final introInputController = TextEditingController();

  final profileScreenshotController = ScreenshotController();

  final nickName = "".obs;
  final introduce = "".obs;

  late final String name;
  late final String phone;

  final Rx<String?> profileImagePath = Rx<String?>(null);

  @override
  void onInit() {
    final String? name = Get.arguments?["name"];
    final String? phone = Get.arguments?["phone"];

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (name == null || phone == null) Get.offAllNamed(Routes.tempMain);
    });
    if (name != null && phone != null) {
      this.name = name;
      this.phone = phone;
      print(name);
    }

    nickNameInputController.addListener(() {
      nickName.value = nickNameInputController.text;
    });
    introInputController.addListener(() {
      introduce.value = introInputController.text;
    });

    super.onInit();
  }

  Future<void> onClick() async {
    final file = await _getLoadedImage();
    Get.dialog(loadingDialog(), barrierDismissible: false); //loading indicator

    if (file != null) {
      final imageUrl = await UserRepository.uploadProfile(file, phone: phone);

      if (imageUrl != null) {
        final user = User(
            name: name,
            phone: phone,
            nickName: nickName.value,
            introduction: introduce.value,
            profileImageUrl: imageUrl);

        final uid = await UserRepository.register(user);
        Get.back();
        print("회원가입 완료! uid : $uid");

        Get.offAllNamed(Routes.tempMain);
      } else {
        Get.rawSnackbar(message: "프로필 사진 업로드 오류입니다. 관리자에게 문의하세요.");
      }
    } else {
      Get.rawSnackbar(message: "프로필 사진 오류입니다. 관리자에게 문의하세요.");
    }
  }

  Future<void> addProfileImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    profileImagePath.value = image.path;
  }

  Future<Uint8List?> _getLoadedImage() async {
    try {
      final rawImageData = (await profileScreenshotController.capture())!;
      return rawImageData;
    } catch (e) {
      print(e);
      Get.rawSnackbar(message: "이미지 압축 오류 발생. 다시 시도 하거나, 개발자에게 문의해주세요.\n$e");
      return null;
    }
  }
}
