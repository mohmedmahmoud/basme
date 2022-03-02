import 'package:barcode_scan2/barcode_scan2.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';
import 'package:Basme/model_view_controller/data/service/firebase/firestore_user.dart';
import 'package:Basme/model_view_controller/data/service/divice_info/divice_info.dart';
import 'package:Basme/model_view_controller/data/service/local_storege/local_storage.dart';
import 'package:Basme/model_view_controller/ui/dialog/error.dart';

import 'package:Basme/model_view_controller/ui/dialog/lodding.dart';
import 'package:Basme/model_view_controller/ui/pages/homepage/homepage.dart';
import 'package:Basme/model_view_controller/ui/pages/login/register.dart';
import 'package:Basme/model_view_controller/ui/pages/super_user/lists_attendances.dart';

class LoginController extends GetxController {
  bool isSignUp = true;
  PageController pageController = PageController();

  void toggleSignUpOrSignIn() {
    isSignUp = !isSignUp;
    update();
  }

  signIn({required String phone, required String password}) async {
    loddingDialog();
    DiviceInfo diviceInfo = DiviceInfo();
    String? phoneId = await diviceInfo.getDeviceInfo();

    FireStoreUser()
        .signIn(
      phone: phone,
      password: password,
    )
        .then((users) {
      if (users.docs.isNotEmpty) {
        users.docs.forEach((user) {
          User userModel = User.fromJson(user.data());
          print(user.data());
          if (userModel.phoneId == phoneId) {
            print('------------------------------');
            LocalStorage().setUser(userModel.toJsonForLocalStroge());
            Get.back();
            if (userModel.role == 'admin') {
              print('ok');
              Get.to(() => ListUsersView(
                    userModel: userModel,
                  ));
            } else {
              Get.offAll(() => HomePage(
                    userModel: userModel,
                  ));
            }
          } else {
            Get.back();
            errorSnackBar(message: 'telephone déja utilisé'.tr);
            print(phoneId);
          }
        });
      } else {
        Get.back();
        print('user not exist  ');

        errorSnackBar(message: ' verifier le numero ou la mot de passe'.tr);
      }
    }).catchError((error) {
      print('error: $error');

      errorSnackBar(message: 'Une erreur est survenue'.tr);
    });
  }

  signUp({required User user}) async {
    loddingDialog();
    await FireStoreUser().updateUser(userModel: user).then((value) {
      LocalStorage().setUser(user.toJsonForLocalStroge());
      Get.back();
      Get.offAll(() => HomePage(
            userModel: user,
          ));
    }).catchError((e) {
      Get.back();
      print(e.toString());
      errorSnackBar(message: 'Une erreur est survenue'.tr);
    });
  }

  toSignIn() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  toSignUp() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  qrCodeAuthentification() async {
    ScanOptions options = const ScanOptions(
        // set the options
        );
    ScanResult result = await BarcodeScanner.scan();
    // print('------${result.rawContent}------');
    // print('------${result.format}------');

    authWithCode(code: result.rawContent);
  }

  authWithCode({required String code}) async {
    loddingDialog();

    FireStoreUser().checkUserExist(id: code).then((user) {
      if (user.exists) {
        print(user.data());
        User userModel = User.fromJson(user.data());
        Get.back();

        DiviceInfo().getDeviceInfo().then((phoneId) {
          if (userModel.phoneId == null || userModel.phoneId == phoneId) {
            userModel.phoneId = phoneId;
            userModel.id = user.id;

            Get.to(() => Register(
                  userModel: userModel,
                ));
          } else {
            errorSnackBar(message: 'telephone déja utilisé'.tr);
          }
        });

        // Get.to(()=>Register());
      } else {
        print('user not exist  user: ${user.data()}');
        Get.back();
        errorSnackBar(message: 'Ce code n\'existe pas'.tr);
      }
    }).catchError((error) {
      print('error: $error');
      Get.back();
      errorSnackBar(message: 'Une erreur est survenue'.tr);
    });
  }
}
