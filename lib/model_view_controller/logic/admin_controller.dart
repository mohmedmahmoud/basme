import 'package:Basme/model_view_controller/ui/dialog/hour_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Basme/model_view_controller/data/model/attendance.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';
import 'package:Basme/model_view_controller/data/service/firebase/firestore_atendance.dart';
import 'package:Basme/model_view_controller/data/service/firebase/firestore_user.dart';
import 'package:Basme/model_view_controller/data/service/local_storege/local_storage.dart';
import 'package:Basme/model_view_controller/ui/dialog/error.dart';
import 'package:Basme/model_view_controller/ui/dialog/lodding.dart';
import 'package:Basme/model_view_controller/ui/dialog/succes.dart';
import 'package:Basme/model_view_controller/ui/pages/login/login.dart';

class AdminController extends GetxController {
  // get attendances
  List<Attendance>? attendances;
  List<Attendance> attendances2 = [];
  TextEditingController searchController = TextEditingController();
  TimeOfDay? timeWorking = const TimeOfDay(hour: 08, minute: 00);
  int? timeWorkingInSeconds = 28000;
  final List<String> _roles = [
    'Chauffeur',
    'Médecin',
    'Opérateur',
    'Infirmier',
    'Technicien',
    'Devellopeur',
    'Autre',
  ];
  final List<String> _rolesFilter = [
    'tout',
    'Chauffeur',
    'Médecin',
    'Opérateur',
    'Infirmier',
    'Technicien',
    'Devellopeur',
    'Autre',
  ];
  List<String> get roles => _roles;
  List<String> get rolesFilter => _rolesFilter;
  String role = 'Devellopeur';
  int roleIndex = 0;

  // change role
  void changeRole(String role) {
    this.role = role;
    update();
  }

  // filter search
  filterAttendances({required String query}) {
    print(query);
    attendances = (query == 'tout')
        ? attendances2
        : attendances2.where((attendance) => attendance.role == query).toList();

    update();
  }

  gettimeWorking(BuildContext context) async {
    timeWorking = await showHour(context);
    if (timeWorking != null) {
      timeWorkingInSeconds =
          timeWorking!.hour * 3600 + timeWorking!.minute * 60;
      print(timeWorkingInSeconds);
    }
    update();
  }

  Future<List<Attendance>?> getAttendances({required String idAgency}) async {
    var values = await HomeFireStore().getAttendanceAgency(idAgency: idAgency);
    List<Attendance> newAttendances = [];
    for (var attendance in values.docs) {
      newAttendances.add(Attendance.fromJson(attendance.data()));
    }
    attendances = newAttendances;
    attendances2 = newAttendances;
    update();
    return attendances;
  }

  // ---------------------------logout ----------

  void logout({required User user}) async {
    loddingDialog();
    await LocalStorage().removeUser();

    Get.offAll(() => const Login());
  }

  addUser({required User userModel}) async {
    loddingDialog(isPop: true);
    User user = User(
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      role: role,
      idAgency: userModel.idAgency,
      idSuperUser: userModel.id,
      nameAgency: userModel.nameAgency,
      latitudeAgency: userModel.latitudeAgency,
      longitudeAgency: userModel.longitudeAgency,
      timeWorking: timeWorkingInSeconds,
    );
    dynamic idUser =
        await FireStoreUser().addUser(user: user.toJson()).catchError((e) {
      print(e.toString());
      errorSnackBar(message: 'Une erreur est survenue'.tr);
    });
    Get.back();
    if (idUser != null) {
      dialogSucces(idUser: idUser);
    } else {
      errorSnackBar(message: 'Une erreur est survenue'.tr);
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
