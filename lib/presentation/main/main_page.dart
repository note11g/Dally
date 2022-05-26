import 'package:dally/presentation/widgets/AnimatedNavigationBar.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/resource/values/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'favorite/favorite_page.dart';
import 'home/home_page.dart';
import 'main_controller.dart';
import 'my/my_page.dart';
import 'search/search_page.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => IndexedStack(
              index: controller.nowPage.value,
              children: const [
                HomePage(),
                SearchPage(),
                FavoritePage(),
                MyPage(),
              ],
            )),
        bottomNavigationBar: Obx(
          () => AnimatedNavigationBar(
            backgroundColor: ColorPalette.black,
            onTap: controller.changeIndex,
            currentIndex: controller.navIdx.value,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Path.getBottomNavIcon("home")),
                  activeIcon: SvgPicture.asset(
                      Path.getBottomNavIcon("home", isFilled: true))),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Path.getBottomNavIcon("search")),
                  activeIcon: SvgPicture.asset(
                      Path.getBottomNavIcon("search", isFilled: true))),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Path.getBottomNavIcon("upload"))),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Path.getBottomNavIcon("favorite")),
                  activeIcon: SvgPicture.asset(
                      Path.getBottomNavIcon("favorite", isFilled: true))),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Path.getBottomNavIcon("my")),
                  activeIcon: SvgPicture.asset(
                      Path.getBottomNavIcon("my", isFilled: true))),
            ],
          ),
        ));
  }
}
