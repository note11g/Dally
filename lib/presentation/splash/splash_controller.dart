import 'package:dally/data/repository/user_repository.dart';
import 'package:dally/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {

    final stopwatch = Stopwatch()..start();
    await UserRepository.test();
    stopwatch.stop();

    await Future.delayed(
        Duration(milliseconds: 2000 - stopwatch.elapsedMilliseconds));
    Get.offNamed(Routes.tempMain);

    super.onInit();
  }
}