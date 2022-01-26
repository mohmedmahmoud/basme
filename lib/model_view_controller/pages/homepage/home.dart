import 'package:Basme/model_view_controller/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';

import 'package:Basme/model_view_controller/pages/homepage/homepage.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.userModel}) : super(key: key);
  User userModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeComtroller) {
        if (homeComtroller.statusApp == 'newUser') {
          homeComtroller.getAtendence();
          return const Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                color: Colors.green,
                size: 50.0,
              ),
            ),
          );
        } else {
          return HomePage(userModel: userModel);
        }
      },
    );
  }
}
