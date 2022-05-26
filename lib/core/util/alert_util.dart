import 'package:dally/resource/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/global_widgets.dart';

class Alert {
  static SnackbarStatus _status = SnackbarStatus.CLOSED;

  static show(String message) {
    if (_status != SnackbarStatus.CLOSED && _status != SnackbarStatus.CLOSING) Get.back();
    Get.showSnackbar(GetSnackBar(
      messageText: Text(message, style: const TextStyle(fontSize: 16)),
      margin: const EdgeInsets.symmetric(vertical: 108, horizontal: 28),
      borderRadius: 8.0,
      backgroundColor: ColorPalette.white,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 800),
      boxShadows: [
        BoxShadow(
            offset: const Offset(1, 2),
            blurRadius: 8,
            color: ColorPalette.black.withOpacity(0.12))
      ],
      snackbarStatus: (status) => _status = status ?? SnackbarStatus.CLOSED,
    ));
  }

  static Future<T> load<T>(Future<T> Function() func) async {
    Get.dialog(loadingDialog(), barrierDismissible: false);
    final res = await func.call();
    Get.back();
    return res;
  }
}
