import 'dart:ui';

import 'package:Basme/model_view_controller/pages/custum_widget/card_attendance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:Basme/model_view_controller/data/model/attendance.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';
import 'package:Basme/model_view_controller/logic/admin_controller.dart';

import 'package:Basme/model_view_controller/pages/custum_widget/loddingWidget.dart';
import 'package:Basme/model_view_controller/pages/dialog/alertdialog_widget.dart';
import 'package:Basme/model_view_controller/pages/super_user/add_user.dart';
import 'package:Basme/model_view_controller/style/input_decoration.dart';
import 'package:Basme/model_view_controller/style/size_config.dart';

class ListUsersView extends StatelessWidget {
  ListUsersView({Key? key, required this.userModel}) : super(key: key);
  final User userModel;
  final AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          mini: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          onPressed: () {
            Get.to(() => AddUserView(
                  userModel: userModel,
                ));
          },
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
            size: 20,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FutureBuilder<List<Attendance>?>(
              future: adminController.getAttendances(
                  idAgency: userModel.idAgency ?? ''),
              builder: (context, AsyncSnapshot snapshot) {
                return GetBuilder<AdminController>(
                  init: AdminController(),
                  builder: (adminController) => RefreshIndicator(
                    onRefresh: () async {
                      adminController.getAttendances(
                          idAgency: userModel.idAgency ?? '');
                    },
                    child: ListView(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 4),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: adminController.searchController,
                                  onChanged: (value) {
                                    adminController.searchUser(
                                        query: adminController
                                            .searchController.text);
                                  },
                                  decoration: inputDecoration().copyWith(
                                    hintText: 'Chercher'.tr,
                                    prefixIcon: const Icon(
                                        CupertinoIcons.search,
                                        size: 20),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.green.shade200,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            ),
                            Container(
                              // height: getProportionateScreenHeight(55),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(0, 4),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: PopupMenuButton(
                                icon: const Icon(
                                  Icons.more_vert_rounded,
                                  size: 20,
                                  color: Colors.black45,
                                ),
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
                                            adminController.logout(
                                                user: userModel);
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
                                  // PopupMenuItem(
                                  //   value: 0,
                                  //   child: Text(
                                  //     "Déconnection".tr,
                                  //     style: const TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
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
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(40),
                          child: ListView.custom(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            childrenDelegate:
                                SliverChildBuilderDelegate((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (adminController.roleIndex != index) {
                                    adminController.roleIndex = index;
                                    adminController.filterAttendances(
                                        query:
                                            adminController.rolesFilter[index]);
                                  }
                                },
                                child: Container(
                                  // height: getProportionateScreenHeight(40),
                                  padding: EdgeInsets.only(
                                      right: getProportionateScreenWidth(10),
                                      left: getProportionateScreenWidth(10)),

                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: getProportionateScreenWidth(10)),
                                  decoration: BoxDecoration(
                                    color: (adminController.roleIndex == index)
                                        ? Colors.grey
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${adminController.rolesFilter[index]}'.tr,
                                    style: TextStyle(
                                      color:
                                          (adminController.roleIndex == index)
                                              ? Colors.white
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }, childCount: adminController.rolesFilter.length),
                          ),
                        ),
                        Stack(
                          children: [
                            Positioned(
                              right: getProportionateScreenWidth(5),
                              top: getProportionateScreenWidth(120),
                              child: Container(
                                width: getProportionateScreenWidth(45),
                                height: getProportionateScreenWidth(45),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(5)),
                                ),
                              ),
                            ),
                            Positioned(
                              left: getProportionateScreenWidth(5),
                              top: getProportionateScreenWidth(240),
                              child: Container(
                                width: getProportionateScreenWidth(120),
                                height: getProportionateScreenWidth(120),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(10)),
                                ),
                              ),
                            ),
                            (adminController.attendances != null)
                                ? SizedBox(
                                    height: SizeConfig.screenHeight! * 0.8,
                                    child: GroupedListView<Attendance, String>(
                                      shrinkWrap: true,
                                      elements: adminController.attendances!,
                                      groupBy: (element) => element.clockIn
                                          .toString()
                                          .substring(0, 10),
                                      groupSeparatorBuilder: (String value) =>
                                          Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      itemBuilder:
                                          (context, Attendance element) =>
                                              CardAttendance(
                                        attendance: element,
                                      ),
                                      // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
                                      useStickyGroupSeparators:
                                          true, // optional
                                      // floatingHeader: true, // optional
                                      order: GroupedListOrder.DESC, // optional
                                    ),
                                  )
                                : const ShimmerWidget(),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
