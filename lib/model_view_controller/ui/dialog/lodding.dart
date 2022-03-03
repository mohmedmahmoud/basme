// -----------------waitting ----------------
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

void loddingDialog({bool? isPop}) {
  Get.dialog(
      // WillPopScope(
      //   onWillPop: () async => isPop ?? true,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(),
          SpinKitChasingDots(
            color: Colors.white,
            size: 40.0,
          ),
          // InkWell(
          //   onTap: () {},
          //   child: Icon(
          //     Icons.close,
          //     color: Colors.white,
          //   ),
          // )
          // MaterialButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   child: Text(
          //     'Cancel',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
      barrierDismissible: true);
}
