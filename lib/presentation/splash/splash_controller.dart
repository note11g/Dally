import 'package:dally/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.offNamed(Routes.tempMain);
    });

    super.onInit();
  }
}