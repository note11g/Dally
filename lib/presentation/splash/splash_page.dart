import 'package:dally/presentation/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("스플래시 페이지"),
        )
    );
  }
}
