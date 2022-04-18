import 'dart:async';
import 'dart:io';

import 'package:dally/data/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TempUploadController extends GetxController {
  final titleInputController = TextEditingController();
  final infoInputController = TextEditingController();
  final tagInputController = TextEditingController();

  final galleryType = GalleryType.none.obs;
  final title = "".obs;
  final info = "".obs;
  final tag = "".obs;

  final imagePath = "".obs;

  @override
  void onInit() {
    final galleryType = Get.parameters['type']?.toGalleryType();
    if (galleryType != null) this.galleryType.value = galleryType;
    print("type : $galleryType");

    titleInputController.addListener(() => title(titleInputController.text));
    infoInputController.addListener(() => info(infoInputController.text));
    tagInputController.addListener(() => tag(tagInputController.text));

    super.onInit();
  }

  Future<void> addImageClick() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    imagePath.value = image.path;
  }

  Future<void> submit() async {
    // image path is blob.
  }
}
