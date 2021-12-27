// -----------------waitting ----------------
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

void loddingDialog({bool? isPop}) {
  Get.dialog(
      WillPopScope(
        onWillPop: () async => isPop ?? true,
        child: const Center(
            child: SpinKitChasingDots(
          color: Colors.white,
          size: 40.0,
        )),
      ),
      barrierDismissible: false);
}
