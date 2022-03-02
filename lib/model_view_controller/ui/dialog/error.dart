// ----------------Error snack bar ----------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackBar({required String message}) {
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white,
    titleText: Text(
      ' ❌ ' + 'Erreur !'.tr,
      style: const TextStyle(
          color: Colors.red, letterSpacing: 1.5, fontWeight: FontWeight.bold),
    ),
    messageText: Text(message.tr,
        style: const TextStyle(
          color: Colors.red,
        )),
    colorText: Colors.white,
    boxShadows: [
      BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(1, 1),
          blurRadius: 10)
    ],
  );
}
