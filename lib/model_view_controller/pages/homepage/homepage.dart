import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';
import 'package:Basme/model_view_controller/logic/home_controller.dart';
import 'package:Basme/model_view_controller/pages/custum_widget/card_timer.dart';
import 'package:Basme/model_view_controller/pages/custum_widget/defaultbutton.dart';
import 'package:Basme/model_view_controller/pages/dialog/alertdialog_widget.dart';
import 'package:Basme/model_view_controller/style/size_config.dart';
import 'package:Basme/model_view_controller/style/theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.userModel}) : super(key: key);
  User userModel;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return Scaffold(
            bottomNavigationBar: Container(
              padding: const EdgeInsetsDirectional.all(20),
              decoration: BoxDecoration(
                borderRadius: (homeController.attendance.status ?? false)
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))
                    : null,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 6,
                    spreadRadius: 3,
                    offset: Offset(2.0, 2.0),
                  )
                ],
                color: Colors.white,
              ),
              child: (homeController.attendance.status ?? false)
                  ? Defaultbutton(
                      text: 'Terminer'.tr,
                      color: Colors.white10,
                      haveBorder: true,
                      textcolor: Colors.black54,
                      onTap: () => homeController.stop(user: widget.userModel),
                    )
                  : Defaultbutton(
                      text: 'Commancer'.tr,
                      haveIcon: true,
                      icon: Icons.power_settings_new_outlined,
                      color: Theme.of(context).primaryColor,
                      textcolor: Colors.white,
                      onTap: () {
                        homeController.start(user: widget.userModel);
                        // _homeController.getAtendence(
                        //     idUser: widget.userModel.id ?? '');
                      }),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    left: getProportionateScreenWidth(-10),
                    top: getProportionateScreenWidth(75),
                    child: Container(
                      width: getProportionateScreenWidth(90),
                      height: getProportionateScreenWidth(90),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(5)),
                      ),
                    ),
                  ),
                  Positioned(
                    right: getProportionateScreenWidth(5),
                    top: getProportionateScreenWidth(90),
                    child: Container(
                      width: getProportionateScreenWidth(40),
                      height: getProportionateScreenWidth(40),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(2.5)),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: 10),
                          child: Text(
                            '${widget.userModel.nameAgency ?? '--------'}',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(30),
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // SizedBox(
                        //   height: getProportionateScreenHeight(20),
                        // ),
                        SizedBox(
                          height: getProportionateScreenWidth(150),
                          child: Stack(
                            children: [
                              Positioned(
                                top: getProportionateScreenWidth(15),
                                left: getProportionateScreenWidth(25),
                                child: Container(
                                  height: getProportionateScreenWidth(75),
                                  width: getProportionateScreenWidth(280),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(2.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        getProportionateScreenWidth(7.5)),
                                  ),
                                  padding: EdgeInsets.all(
                                      getProportionateScreenWidth(15)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/profil-icon.svg',
                                        color: Colors.black,
                                        width: getProportionateScreenWidth(40),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            ((widget.userModel.name!.length <=
                                                        18)
                                                    ? widget.userModel.name
                                                    : '${widget.userModel.name}'
                                                            .substring(0, 15) +
                                                        '.. ') ??
                                                '---------',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w900,
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        15)),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  widget.userModel.phone ?? '',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          12)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // const Expanded(child: SizedBox()),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: getProportionateScreenHeight(30),
                                right: getProportionateScreenWidth(15),
                                child: Container(
                                  width: SizeConfig.screenWidth! * 0.12,
                                  height: getProportionateScreenHeight(50),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: getProportionateScreenWidth(
                                  //         getProportionateScreenWidth(8))),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(2.0, 2.0),
                                      ),
                                    ],
                                  ),
                                  child: PopupMenuButton(
                                    icon: const Icon(Icons.more_vert_rounded,
                                        color: Colors.black45),
                                    onSelected: (val) {
                                      if (val == 0) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialogWidget(
                                              contentText:
                                                  "Voulez-vous vraiment vous déconnecter ?"
                                                      .tr,
                                              confirmFunction: () {
                                                Get.back();
                                                homeController.logout(
                                                    user: widget.userModel);
                                              },
                                              declineFunction: () {
                                                Get.back();
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 0,
                                        child: Text(
                                          "Déconnection".tr,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  // InkWell(
                                  //     onTap: () =>
                                  //         adminController.logout(user: userModel),
                                  //     child: const Icon(
                                  //       Icons.logout_outlined,
                                  //       size: 20,
                                  //       color: Colors.black45,
                                  //     )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CartTimer(
                              title: "heure d'arrivée".tr,
                              icon: CupertinoIcons.arrow_up_right_square,
                              time: (homeController.attendance.clockIn == null)
                                  ? '--:--'
                                  : homeController.attendance.clockIn
                                      .toString()
                                      .substring(10, 16),
                            ),
                            CartTimer(
                              title: 'heure de sortie'.tr,
                              icon: CupertinoIcons.arrow_down_right_square,
                              time: (homeController.attendance.clockOut == null)
                                  ? '--:--'
                                  : homeController.attendance.clockOut
                                      .toString()
                                      .substring(10, 16),
                            ),
                            CartTimer(
                              title: 'temps effectié'.tr,
                              icon: CupertinoIcons.stopwatch,
                              time: homeController.attendance.duration == null
                                  ? '--:--'
                                  : homeController.attendance.duration!
                                      .substring(0, 4),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CircularCountDownTimer(
                          duration: homeController.timeCircler,

                          controller: homeController.circularcontroller,

                          width: MediaQuery.of(context).size.width / 3,

                          // Height of the Countdown Widget.
                          height: MediaQuery.of(context).size.height / 4,

                          // Ring Color for Countdown Widget.
                          ringColor: greyColor,

                          // Filling Color for Countdown Widget.
                          fillColor: (homeController.attendance.status ?? false)
                              ? Theme.of(context).primaryColor
                              : greyColor,

                          // Filling Gradient for Countdown Widget.
                          fillGradient: null,

                          // Background Color for Countdown Widget.
                          // backgroundColor: Colors.white,

                          // Background Gradient for Countdown Widget.

                          // Border Thickness of the Countdown Ring.
                          strokeWidth: 5,

                          // Begin and end contours with a flat edge and no extension.
                          strokeCap: StrokeCap.round,

                          // Text Style for Countdown Text.
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: (homeController.attendance.status ?? false)
                                  ? Theme.of(context).primaryColor
                                  : greyColor,
                              fontSize: 18),

                          // Format for the Countdown Text.
                          textFormat: CountdownTextFormat.HH_MM_SS,

                          // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                          isReverse: true,

                          // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                          isReverseAnimation: false,

                          // Handles visibility of the Countdown Text.
                          isTimerTextShown: true,

                          // Handles the timer start.
                          autoStart: false,

                          // This Callback will execute when the Countdown Starts.
                          onStart: () {
                            // Here, do whatever you want

                            print('Countdown Started');
                          },

                          // This Callback will execute when the Countdown Ends.
                          onComplete: () {
                            // Here, do whatever you want
                            print('Countdown Completed');
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (homeController.attendance.status ?? false)
                              const Icon(Icons.maps_home_work_outlined,
                                  color: Colors.black54, size: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              ((homeController.attendance.status ?? false))
                                  ? 'Vous êtes en travail'.tr
                                  : ' ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
