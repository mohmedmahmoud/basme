// ----------------Error snack bar ----------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackBar({required String message}) {
  Get.snackbar(message, '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      borderRadius: 5,
      colorText: Colors.white);
}
