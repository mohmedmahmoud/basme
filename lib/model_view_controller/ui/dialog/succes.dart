import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Basme/model_view_controller/ui/custum_widget/defaultbutton.dart';
import 'package:qr_flutter/qr_flutter.dart';

void dialogSucces({required String idUser}) => Get.bottomSheet(
    SizedBox(
      height: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 30,
                color: Colors.green,
              ),
              Text(
                'Opération effectuée \n avec succés'.tr,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 150,
            child: QrImage(
              data: idUser,
              size: 148,
              errorStateBuilder: (cxt, err) {
                return Center(
                  child: Text(
                    'Une erreur est survenue'.tr,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
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
              SelectableText(
                idUser,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ],
      ),
    ),
    backgroundColor: Colors.white
    //  barrierDismissible: false,
    // radius: 10,
    // backgroundColor: Colors.white,
    // onWillPop: () async => true,
    // title: '',
    // middleText: '',
    // contentPadding: const EdgeInsets.all(20),
    // titleStyle: Get.textTheme.bodyText1,
    // actions: [
    //   Defaultbutton(
    //     text: 'Retour'.tr,
    //     onTap: () => Get.back(),
    //     haveBorder: true,
    //     color: Colors.white,
    //     textcolor: Colors.black,
    //   )

    // widget
    // ]

    );

// ----------------Success snack bar ----------------------
void successSnackBar({required String message}) {
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white,
    titleText: Text(
      ' ✔ ' + 'Réussi !'.tr,
      style: const TextStyle(
          color: Colors.green, letterSpacing: 1.5, fontWeight: FontWeight.bold),
    ),
    messageText: Text(message.tr,
        style: const TextStyle(
          color: Colors.green,
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
