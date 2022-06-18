import 'package:dally/data/repository/user_repository.dart';
import 'package:dally/presentation/gallery/gallery_controller.dart';
import 'package:dally/presentation/gallery/gallery_page.dart';
import 'package:dally/presentation/main/favorite/favorite_controller.dart';
import 'package:dally/presentation/main/home/home_controller.dart';
import 'package:dally/presentation/main/main_controller.dart';
import 'package:dally/presentation/main/main_page.dart';
import 'package:dally/presentation/main/my/my_controller.dart';
import 'package:dally/presentation/main/search/search_controller.dart';
import 'package:dally/presentation/temp/login/temp_login_controller.dart';
import 'package:dally/presentation/temp/login/temp_login_page.dart';
import 'package:dally/presentation/temp/main/temp_main_controller.dart';
import 'package:dally/presentation/temp/main/temp_main_page.dart';
import 'package:dally/presentation/temp/set_profile/temp_set_profile_controller.dart';
import 'package:dally/presentation/temp/set_profile/temp_set_profile_page.dart';
import 'package:dally/presentation/temp/test_page.dart';
import 'package:dally/presentation/temp/upload/temp_upload_controller.dart';
import 'package:dally/presentation/temp/upload/temp_upload_page.dart';
import 'package:dally/presentation/user/user_controller.dart';
import 'package:dally/presentation/user/user_page.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationPages {
  static final pages = [
    GetPage(
        name: Routes.main,
        page: () => const MainPage(),
        binding: BindingsBuilder(() {
          Get.put(MainController());
          Get.lazyPut(() => HomeController());
          Get.lazyPut(() => SearchController());
          Get.lazyPut(() => FavoriteController());
          Get.lazyPut(() => MyController());
        })),

    GetPage(
        name: Routes.gallery,
        page: () => const GalleryPage(),
        binding: BindingsBuilder(() {
          Get.put(GalleryController());
        })),

    GetPage(
        name: Routes.user,
        page: () => const UserPage(),
        binding: BindingsBuilder(() {
          Get.put(UserController());
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

    GetPage(
      name: Routes.tempLogout,
      page: () => const Scaffold(),
      binding: BindingsBuilder(() async {
        await UserRepository.logout();
        Get.offAllNamed(Routes.tempMain);
      }),
    ),

    GetPage(name: Routes.test, page: () => const TestPage()),
  ];
}
