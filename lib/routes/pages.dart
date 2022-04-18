import 'package:dally/presentation/main/main_controller.dart';
import 'package:dally/presentation/main/main_page.dart';
import 'package:dally/presentation/splash/splash_controller.dart';
import 'package:dally/presentation/splash/splash_page.dart';
import 'package:dally/presentation/temp/login/temp_login_controller.dart';
import 'package:dally/presentation/temp/login/temp_login_page.dart';
import 'package:dally/presentation/temp/main/temp_main_controller.dart';
import 'package:dally/presentation/temp/main/temp_main_page.dart';
import 'package:dally/presentation/temp/set_profile/temp_set_profile_controller.dart';
import 'package:dally/presentation/temp/set_profile/temp_set_profile_page.dart';
import 'package:dally/presentation/temp/upload/temp_upload_controller.dart';
import 'package:dally/presentation/temp/upload/temp_upload_page.dart';
import 'package:dally/routes/routes.dart';
import 'package:get/get.dart';

class ApplicationPages {
  static final pages = [
    GetPage(
        name: Routes.main,
        page: () => const MainPage(),
        binding: BindingsBuilder(() {
          Get.put(MainController());
        })),
    GetPage(
        name: Routes.splash,
        page: () => const SplashPage(),
        binding: BindingsBuilder(() {
          Get.put(SplashController());
        })),


    // temp
    GetPage(
        name: Routes.tempMain,
        page: () => const TempMainPage(),
        binding: BindingsBuilder(() {
          Get.put(TempMainController());
        })),

    GetPage(
        name: Routes.tempLogin,
        page: () => const TempLoginPage(),
        binding: BindingsBuilder(() {
          Get.put(TempLoginController());
        })),
    GetPage(
        name: Routes.tempSetProfile,
        page: () => const TempSetProfilePage(),
        binding: BindingsBuilder(() {
          Get.put(TempSetProfileController());
        })),

    GetPage(
        name: Routes.tempUpload,
        page: () => const TempUploadPage(),
        binding: BindingsBuilder(() {
          Get.put(TempUploadController());
        })),

  ];
}
