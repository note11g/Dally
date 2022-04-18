import 'package:dally/data/enums.dart';
import 'package:dally/presentation/global_widgets.dart';
import 'package:dally/presentation/temp/login/temp_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource/values/colors.dart';

class TempLoginPage extends GetView<TempLoginController> {
  const TempLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _titleSection(), flex: 2),
          Expanded(child: _inputSection(), flex: 4),
          Expanded(child: _buttonSection(), flex: 2),
        ],
      ),
    ));
  }

  _titleSection() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() => Text(
                controller.mode.value == LoginMode.login
                    ? "${controller.userName.value}님 반가워요!"
                    : "등록을 위한 기본 정보를 입력합니다.",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 6),
            Obx(() => Text(controller.mode.value == LoginMode.login
                ? "다시 만나게 되어 정말 반가워요."
                : "개인정보는 노출되지 않아요.")),
          ]);

  _inputSection() => Obx(() => ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            if (controller.mode.value == LoginMode.none)
              const SizedBox(height: 32),
            // Phone Section
            underlineInput(
                enable: controller.mode.value == LoginMode.none,
                textEditingController: controller.phoneInputController,
                inputTextStyle: const TextStyle(fontSize: 26),
                label: "전화번호",
                hint: "01096313770",
                maxLength: 11,
                keyboardType: TextInputType.phone),
            // Name Section
            if (controller.mode.value == LoginMode.register)
              const SizedBox(height: 20),
            if (controller.mode.value == LoginMode.register)
              underlineInput(
                  enable: controller.otpStatus.value == OTPStatus.none,
                  textEditingController: controller.nameInputController,
                  inputTextStyle: const TextStyle(fontSize: 26),
                  label: "이름(실명)",
                  hint: "홍길동",
                  maxLength: 10,
                  keyboardType: TextInputType.name),
            // OTP Section
            if (controller.otpStatus.value == OTPStatus.sent)
              const SizedBox(height: 20),
            if (controller.otpStatus.value == OTPStatus.sent)
              underlineInput(
                  textEditingController: controller.otpInputController,
                  inputTextStyle: const TextStyle(fontSize: 26),
                  label: "인증번호",
                  hint: "123456",
                  maxLength: 6,
                  keyboardType: TextInputType.number),
          ]));

  _buttonSection() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            shadowButton(
              onTap: controller.onClick,
              color: ColorPalette.black,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              shadowColor: const Color(0x26000000),
              child: Text(
                "다음",
                style: const TextStyle(
                    color: ColorPalette.white,
                    fontSize: 18,
                    letterSpacing: 0.5),
                textAlign: TextAlign.center,
              ),
            ),
          ]);
}
