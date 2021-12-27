import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:mybim/data/model/attendance.dart';
import 'package:mybim/data/model/user_model.dart';
import 'package:mybim/data/service/firestore_atendance.dart';
import 'package:mybim/data/service/plus/local_storage.dart';
import 'package:mybim/data/service/plus/location.dart';
import 'package:mybim/pages/dialog/error.dart';
import 'package:mybim/pages/dialog/lodding.dart';
import 'package:mybim/pages/dialog/succes.dart';
import 'package:mybim/pages/login/login.dart';
import 'package:ntp/ntp.dart';

class HomeController extends GetxController {
  CountDownController circularcontroller = CountDownController();
  // int durationTimer = 60 * 60 * 8;
  // bool isStart = false;
  // String clockIn = '--:--';
  // String clockOut = '--:--';
  // String durationWork = '--:--';

  Attendance _attendance = Attendance();
  String _statusApp = 'newUser';
  String get statusApp => _statusApp;
  Attendance get attendance => _attendance;
  //location
  LocationData? _locationData;
  LocationData? get locationData => _locationData;

  // init state
  @override
  void onInit() {
    super.onInit();
  }
  // ---------------------------logout ----------

  void logout({required User user}) async {
    if (_statusApp != 'clockIn') {
      loddingDialog();
      await LocalStorage().removeUser();

      Get.offAll(() => Login());
    } else {
      dynamic isOk = await stop(user: user);
      isOk is bool ? Get.offAll(() => Login()) : null;
    }
  }

  // ---------------------------get attendance ----------

  void getAtendence() async {
    // loddingDialog(isPop: false);
    String? idAttendance = await LocalStorage().getIdAttendance();
    if (idAttendance != null) {
      HomeFireStore()
          .getAtendance(idAttendance: idAttendance)
          .then((atendance) {
        // Get.back();

        if (atendance.exists) {
          print('atendance ${atendance.data()}');
          _attendance = Attendance.fromJson(atendance.data());
          if (_attendance.status ?? false) {
            _statusApp = 'clockIn';
          } else {
            _statusApp = 'clockOut';
          }
        } else {
          _statusApp = 'clockIn';
          print('atendance not found');
        }
        update();
      }).catchError((error) {
        print('error: $error');
        Get.back();

        errorSnackBar(message: 'Une erreur est survenue');
      });
    } else {
      _statusApp = 'clockIn';
      update();
    }
  }

// -------------------------------start timer-----
  start({required User user}) async {
    loddingDialog();
    LocationDivice locationDivice = LocationDivice();
    _locationData = await locationDivice.getLocation();
    print('locationData: $_locationData');
    bool inWorking = locationDivice.positionIsOk(
      latitude: locationData?.latitude,
      longitude: locationData?.longitude,
      latitudeAgency: user.latitudeAgency,
      longitudeAgency: user.longitudeAgency,
    );

    print(inWorking);
    if (inWorking) {
      DateTime startDate = await NTP.now();

      _attendance = Attendance(
        nameUser: user.name,
        phoneUser: user.phone,
        idAgency: user.idAgency,
        idUser: user.id,
        status: true,
        clockIn: startDate,
        positionClockIn:
            GeoPoint(locationData?.latitude ?? 0, locationData?.longitude ?? 0),
      );
      addAttendanceToFirebase(attendance: _attendance);
    } else {
      Get.back();
      errorSnackBar(message: 'vous n\'etes pas dans la zone de travail');
    }
  }

  addAttendanceToFirebase({required Attendance attendance}) async {
    await HomeFireStore()
        .addAttendance(attendance: attendance.toJson())
        .then((attendanceData) {
      if (attendanceData != null) {
        LocalStorage().setIdAttendance(id: attendanceData.id);
        circularcontroller.start();
        Get.back();
        _statusApp = 'clockIn';
        update();
        successSnackBar(message: 'Votre presence est enregistrer');
      } else {
        Get.back();
        _attendance.status = false;
        print('error in attendanceData');
        errorSnackBar(message: 'Une erreur est survenue');
      }
    }).catchError((e) {
      Get.back();
      _attendance.status = false;
      print(e.toString());
      errorSnackBar(message: 'Une erreur est survenue');
    });
  }

// ---------------------------------stop timer-----
  stop({required User user}) async {
    loddingDialog();
    LocationDivice locationDivice = LocationDivice();
    _locationData = await locationDivice.getLocation();

    bool inWorking = locationDivice.positionIsOk(
      latitude: locationData!.latitude,
      longitude: locationData!.longitude,
      latitudeAgency: user.latitudeAgency,
      longitudeAgency: user.longitudeAgency,
    );

    print(inWorking);
    if (inWorking) {
      _attendance.clockOut = await NTP.now();
      _attendance.positionClockOut =
          GeoPoint(locationData?.latitude ?? 0, locationData?.longitude ?? 0);
      Duration duration = _attendance.clockOut!
          .difference(_attendance.clockIn ?? DateTime.now());
      _attendance.duration = duration.toString();
      _attendance.status = false;

      updateAttendance(attendance: _attendance);
      return true;
    } else {
      Get.back();
      errorSnackBar(message: 'vous n\'etes pas dans la zone de travail');
    }
  }

  updateAttendance({required Attendance attendance}) async {
    String? id = await LocalStorage().getIdAttendance();
    await HomeFireStore()
        .updateAttendance(
            attendance: attendance.toJson(), idAttendance: id ?? '')
        .then((value) {
      Get.back();
      circularcontroller.pause();
      _statusApp = 'clockOut';
      successSnackBar(message: 'Votre sortie est enregistrer');
      update();
    }).catchError((e) {
      Get.back();
      _attendance.status = true;
      print(e.toString());
      errorSnackBar(message: 'Une erreur est survenue');
    });
  }
}
