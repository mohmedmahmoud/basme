import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybim/pages/custum_widget/defaultbutton.dart';
import 'package:qr_flutter/qr_flutter.dart';

void dialogSucces({required String idUser}) => Get.defaultDialog(
        barrierDismissible: false,
        radius: 10,
        backgroundColor: Colors.white,
        onWillPop: () async => true,
        title: '',
        middleText: '',
        contentPadding: EdgeInsets.all(20),
        titleStyle: Get.textTheme.bodyText1,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.check_circle_outline,
                  size: 35,
                  color: Colors.green,
                ),
                Text(
                  'Opération effectuée \n avec succés',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(height: 40),
            QrImage(
              data: idUser,
              size: 200,
              errorStateBuilder: (cxt, err) {
                return const Center(
                  child: Text(
                    'Une erreur est survenue',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.lock_open,
                  size: 20,
                  color: Colors.black,
                ),
                Text(
                  idUser,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ],
        ),
        actions: [
          Defaultbutton(
            text: 'Retour',
            onTap: () => Get.back(),
            haveBorder: true,
            color: Colors.white,
            textcolor: Colors.black,
          )

          // widget
        ]);

// ----------------Success snack bar ----------------------
void successSnackBar({required String message}) {
  Get.snackbar(message, '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      borderRadius: 5,
      colorText: Colors.white);
}
