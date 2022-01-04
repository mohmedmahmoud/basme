import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:Basme/data/model/attendance.dart';
import 'package:Basme/data/model/user_model.dart';
import 'package:Basme/logic/admin_controller.dart';
import 'package:Basme/pages/custum_widget/empty_content.dart';
import 'package:Basme/pages/custum_widget/loddingWidget.dart';
import 'package:Basme/pages/dialog/alertdialog_widget.dart';
import 'package:Basme/pages/super_user/add_user.dart';
import 'package:Basme/style/input_decoration.dart';
import 'package:Basme/style/size_config.dart';

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
                                    hintText: 'Search',
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
                              // width: getProportionateScreenWidth(30),
                              padding: EdgeInsets.symmetric(
                                  // horizontal: getProportionateScreenWidth(5),
                                  ),

                              height: getProportionateScreenHeight(55),
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
                                              "voulez-vous vraiment vous déconnecter ?",
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
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text(
                                      "Déconnection",
                                      style: TextStyle(
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
                                  if (adminController.role != index) {
                                    adminController.role = index;
                                    adminController.filterAttendances(
                                        query: adminController.roles[index]);
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
                                    color: (adminController.role == index)
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
                                    '${adminController.roles[index]}',
                                    style: TextStyle(
                                      color: (adminController.role == index)
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }, childCount: adminController.roles.length),
                          ),
                        ),
                        // ignore: unnecessary_null_comparison
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
                                  itemBuilder: (context, Attendance element) =>
                                      CardAttendance(
                                    attendance: element,
                                  ),
                                  // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
                                  useStickyGroupSeparators: true, // optional
                                  // floatingHeader: true, // optional
                                  order: GroupedListOrder.DESC, // optional
                                ),
                              )
                            : const ShimmerWidget(),
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

class CardAttendance extends StatelessWidget {
  const CardAttendance({
    Key? key,
    required this.attendance,
  }) : super(key: key);

  final Attendance attendance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(
        //   MonthlyDetail(),
        //   arguments: index,
        // );
      },
      onLongPress: () {
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialogWidget(
        //       contentText: "هل أنت متأكد أنك تريد حذف الميعاد ؟",
        //       confirmFunction: () {
        //         controller
        //             .deleteMonthly(controller.monthly[index].id);
        //         Get.back();
        //       },
        //       declineFunction: () {
        //         Get.back();
        //       },
        //     );
        //   },
        // );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: attendance.status ?? false
              ? Colors.green[300]
              : Colors.orange[300],
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 3,
              spreadRadius: 1.5,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(
            left: 5,
          ),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (attendance.nameUser == null)
                        ? '----'
                        : (attendance.nameUser!.length > 17)
                            ? attendance.nameUser!.substring(0, 17) + '..'
                            : attendance.nameUser ?? '-----',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Text(
                    attendance.phoneUser ?? '-------',
                    // softWrap: false,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w200),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Text(
                    attendance.role ?? '-------',
                    // softWrap: false,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_up_right_square,
                    color: Colors.green.shade200,
                    size: 20,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Text(((attendance.clockIn != null)
                      ? attendance.clockIn.toString().substring(10, 16)
                      : '--:--')),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 1,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // if (attendance.clockOut != null) const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_down_right_square,
                    color: Colors.orange.shade200,
                    size: 20,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Text((attendance.clockOut != null)
                      ? attendance.clockOut.toString().substring(10, 16)
                      : '--:--'),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 1,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.stopwatch,
                    color: Colors.black45,
                    size: 20,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Text(((attendance.duration != null)
                      ? attendance.duration!.substring(0, 4)
                      : '--:--')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
