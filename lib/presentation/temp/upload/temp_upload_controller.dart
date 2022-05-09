import 'dart:async';

import 'package:dally/data/enums.dart';
import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/repository/artwork_repository.dart';
import 'package:dally/data/source/local_data_source.dart';
import 'package:dally/presentation/global_widgets.dart';
import 'package:dally/routes/routes.dart';
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

  XFile? image;

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
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image!.path;
    }
  }

  Future<void> submit() async {
    final uid = await LocalDataSource.getUid();
    print("image upload start($uid) : ${imagePath.value}");
    Get.dialog(loadingDialog(), barrierDismissible: false); //loading indicator
    final url = await ArtworkRepository.uploadArtworkImage(
        await image!.readAsBytes(),
        uid: uid!);
    if (url == null) {
      Get.rawSnackbar(message: "이미지 업로드에 실패하였습니다.");
      return;
    }
    print("image upload succeed : $url");
    final tags = tag.value.split(" ");

    final artwork = ArtWork(
        owner: uid,
        title: title.value,
        description: info.value,
        tags: tags,
        artImageUrl: url,
        gallery: galleryType.value);

    print("upload start : $artwork");
    final artworkId = await ArtworkRepository.uploadArtwork(artwork);
    if (artworkId == null) {
      Get.back(); //dialog off
      Get.rawSnackbar(message: "업로드에 실패하였습니다.");
    } else {
      print("upload succeed! id: $artworkId");
      Get.back(); //dialog off
      Get.offAllNamed(Routes.tempMain, arguments: {
        "upload" : true
      });
    }
  }
}
