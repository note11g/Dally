import 'package:dally/data/enums.dart';
import 'package:dally/data/repository/user_repository.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempLoginController extends GetxController {
  final phoneInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final otpInputController = TextEditingController();

  final mode = LoginMode.none.obs;
  final userName = "".obs;
  final otpStatus = OTPStatus.none.obs;

  @override
  Future<void> onInit() async {
    ever(mode, (LoginMode m) {
      if (m != LoginMode.none) {
        print("휴대폰 번호 검증 완료");
      }
    });
    ever(otpStatus, (OTPStatus s) {
      if (s == OTPStatus.sent) {
        print("OTP 문자 발송 됨");
      }
    });
    super.onInit();
  }

  Future<void> onClick() async {
    if (mode.value == LoginMode.none) {
      final user = await _userExist(phoneInputController.text);

      if (user == null) {
        // 유저가 없는 경우 => 회원가입
        mode(LoginMode.register);
      } else {
        // 유저가 있는 경우 => 로그인 (OTP 전송)
        userName(user);
        mode(LoginMode.login);
        (await _sendOTP(phoneInputController.text))
            ? otpStatus(OTPStatus.sent)
            : failedOTP();
      }
    } else {
      if (otpStatus.value == OTPStatus.none) {
        (await _sendOTP(phoneInputController.text))
            ? otpStatus(OTPStatus.sent)
            : failedOTP();
      } else {
        if (mode.value == LoginMode.login) {
          // 로그인
          final uid = await _login();
          if (uid != null) {
            Get.offAllNamed(Routes.tempMain);
          } else {
            Get.rawSnackbar(message: "인증번호가 올바르지 않습니다.");
            print("failed");
          }
        } else {
          // 회원가입
          final res = await _checkOTPWithRegister();
          if (res) {
            Get.offNamed(Routes.tempSetProfile, arguments: {
              "name": nameInputController.text,
              "phone": phoneInputController.text
            });
          } else {
            Get.rawSnackbar(message: "인증번호가 올바르지 않습니다.");
            print("failed");
          }
        }
      }
    }
  }

  /*
    전화번호로 유저 있다면 이름 반환
   */
  Future<String?> _userExist(String phone) async {
    // todo : server creation
    final name = await UserRepository.checkInit(phone);
    print("userExistCheck name : $name");
    return name;
  }

  /*
    OTP 요청 후, 성공 여부 반환
   */
  Future<bool> _sendOTP(String phone) async {
    final isSucceed = await UserRepository.sendOTP(phone);
    return isSucceed;
  }

  Future<String?> _login() async {
    // todo : server creation
    // todo : 직접 참조 (controller.text) 삭제
    final uid = await UserRepository.login(
        phone: phoneInputController.text, otp: otpInputController.text);

    return uid;
  }

  /*
    todo : 서버에서 인증번호 체크 => 성공시 회원가입 실패시 스낵바
          회원가입 성공시 다음단계
   */
  Future<bool> _checkOTPWithRegister() async {
    final status = await UserRepository.checkOTP(
        phoneInputController.text, otpInputController.text);
    return status;
  }

  void failedOTP() {
    Get.rawSnackbar(message: "인증코드 발송에 실패하였습니다. 잠시 후 다시 시도해주세요.");
  }
}
