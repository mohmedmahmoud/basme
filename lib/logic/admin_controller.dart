import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybim/data/model/attendance.dart';
import 'package:mybim/data/model/user_model.dart';
import 'package:mybim/data/service/firestore_atendance.dart';
import 'package:mybim/data/service/firestore_user.dart';
import 'package:mybim/data/service/plus/local_storage.dart';
import 'package:mybim/pages/dialog/error.dart';
import 'package:mybim/pages/dialog/lodding.dart';
import 'package:mybim/pages/dialog/succes.dart';
import 'package:mybim/pages/login/login.dart';

class AdminController extends GetxController {
  // get attendances
  List<Attendance>? attendances;
  List<Attendance> attendances2 = [];
  TextEditingController searchController = TextEditingController();
  Future<List<Attendance>?> getAttendances({required String idAgency}) async {
    var values = await HomeFireStore().getAttendanceAgency(idAgency: idAgency);
    List<Attendance> newAttendances = [];
    for (var attendance in values.docs) {
      newAttendances.add(Attendance.fromJson(attendance.data()));
    }
    attendances = newAttendances;
    attendances2 = newAttendances;
    return attendances;
  }

  // ---------------------------logout ----------

  void logout({required User user}) async {
    loddingDialog();
    await LocalStorage().removeUser();

    Get.offAll(() => const Login());
  }

  addUser({required String role, required User userModel}) async {
    loddingDialog(isPop: false);
    User user = User(
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      role: role,
      idAgency: userModel.idAgency,
      idSuperUser: userModel.id,
      nameAgency: userModel.nameAgency,
      latitudeAgency: userModel.latitudeAgency,
      longitudeAgency: userModel.longitudeAgency,
    );
    String idUser =
        await FireStoreUser().addUser(user: user.toJson()).catchError((e) {
      print(e.toString());
      errorSnackBar(message: 'Une erreur est survenue');
    });
    if (idUser != null) {
      Get.back();
      dialogSucces(idUser: idUser);
      // successSnackBar(message: 'L\'utilisateur a été ajouté avec succès');
    }
  }

  // ----------------------------search----
  searchUser({required String query}) {
    print(query);
    attendances = (query.isEmpty)
        ? attendances2
        : attendances2
            .where((attendance) =>
                (attendance.nameUser != null && attendance.phoneUser != null)
                    ? (attendance.nameUser!
                            .toLowerCase()
                            .startsWith(query.toLowerCase()) ||
                        attendance.phoneUser!.startsWith(query))
                    : false)
            .toList();

    update();
  }
}
