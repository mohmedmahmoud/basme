import 'package:Basme/model_view_controller/logic/home_controller.dart';
import 'package:Basme/model_view_controller/ui/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';

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
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  SvgPicture.asset('assets/icons/logo.svg', height: 100),
                  const SizedBox(height: 20),
                  const SpinKitFadingCircle(
                    color: Colors.green,
                    size: 50.0,
                  ),
                ],
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
