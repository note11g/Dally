import 'package:dally/presentation/main/main_controller.dart';
import 'package:dally/presentation/main/main_page.dart';
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
  ];
}
