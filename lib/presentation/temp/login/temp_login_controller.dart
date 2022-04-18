import 'package:dally/data/enums.dart';
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
        mode(LoginMode.register);
      } else {
        userName(user);
        mode(LoginMode.login);
        (await _sendOTP()) ? otpStatus(OTPStatus.sent) : failedOTP();
      }
    } else {
      if (otpStatus.value == OTPStatus.none) {
        (await _sendOTP()) ? otpStatus(OTPStatus.sent) : failedOTP();
      } else {
        final uid =
            await (mode.value == LoginMode.login ? _login : _register).call();

        if (uid != null) {
          if (mode.value == LoginMode.login) {
            Get.offAllNamed(Routes.tempMain);
          } else {
            Get.offNamed(Routes.tempSetProfile, arguments: {"uid": uid});
          }
        }
      }
    }
  }

  /*
    전화번호로 유저 있다면 이름 반환
   */
  Future<String?> _userExist(String phoneNumber) async {
    // todo : server creation
    return null;
  }

  /*
    OTP 요청 후, 성공 여부 반환
   */
  Future<bool> _sendOTP() async {
    // todo : server creation
    final isSucceed = await true;
    return isSucceed;
  }

  /*
    todo : 서버에서 인증번호 체크
    로그인 성공시 uid 반환
   */
  Future<String?> _login() async {
    // todo : server creation
    return "example_uid";
  }

  /*
    todo : 서버에서 인증번호 체크
    회원가입 성공시 uid 반환
   */
  Future<String?> _register() async {
    // todo : server creation
    return "example_uid";
  }

  void failedOTP() {
    Get.rawSnackbar(message: "인증코드 발송에 실패하였습니다. 잠시 후 다시 시도해주세요.");
  }
}
