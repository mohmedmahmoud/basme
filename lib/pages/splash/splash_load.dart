import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Basme/data/model/user_model.dart';
import 'package:Basme/data/service/plus/local_storage.dart';
import 'package:Basme/logic/login_controller.dart';
import 'package:Basme/pages/homepage/home.dart';
import 'package:Basme/pages/homepage/homepage.dart';
import 'package:Basme/pages/login/login.dart';
import 'package:Basme/pages/super_user/lists_attendances.dart';
import 'package:Basme/style/size_config.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    LocalStorage().getUser().then((user) {
      print(user);
      if (user != null) {
        User userModel = User.fromJsonForLocalStroge(user);
        if (userModel.role == 'admin') {
          Get.to(() => ListUsersView(
                userModel: userModel,
              ));
        } else {
          Get.off(() => Home(
                userModel: userModel,
              ));
        }
      } else {
        Get.off(() => const Login());
      }
    });
    // Timer(const Duration(milliseconds: 3000), () => Get.to(() => Login()));
  }

  Future<FirebaseApp> initializeFirebase() {
    return Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return
        // FutureBuilder(
        // // Replace the 3 second delay with your initialization code:
        // future: Future.delayed(const Duration(seconds: 5)),
        // builder: (context, AsyncSnapshot snapshot) {
        //   // Show splash screen while waiting for app resources to load:
        //   if (snapshot.connectionState == ConnectionState.waiting) {

        const Scaffold(
            body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
