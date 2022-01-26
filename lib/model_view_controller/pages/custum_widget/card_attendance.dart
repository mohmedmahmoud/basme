import 'package:Basme/model_view_controller/data/model/attendance.dart';
import 'package:Basme/model_view_controller/style/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  attendance.role == null
                      ? const Text('')
                      : Text(
                          '${attendance.role}'.tr,
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
