import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:Basme/model_view_controller/data/model/attendance.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';
import 'package:Basme/model_view_controller/data/service/firebase/firestore_atendance.dart';
import 'package:Basme/model_view_controller/data/service/local_storege/local_storage.dart';
import 'package:Basme/model_view_controller/data/service/location/location.dart';
import 'package:Basme/model_view_controller/ui/dialog/error.dart';
import 'package:Basme/model_view_controller/ui/dialog/lodding.dart';
import 'package:Basme/model_view_controller/ui/dialog/succes.dart';
import 'package:Basme/model_view_controller/ui/pages/login/login.dart';
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
  int timeCircler = 8 * 60 * 60;

  // init state
  @override
  void onInit() {
    super.onInit();
  }
  // ---------------------------logout ----------

  void logout({required User user}) async {
    print("------------$_statusApp");
    loddingDialog();
    if (_statusApp != 'clockIn') {
      LocalStorage().removeUser();
      LocalStorage().deleteIdAttendance();

      Get.offAll(() => const Login());
    } else {
      Get.back();
      errorSnackBar(message: 'Déconnecter avant terminer la session'.tr);
    }
  }

  // ---------------------------get attendance ----------

  void getAtendence({int? timeworking}) async {
    // loddingDialog(isPop: false);
    String? idAttendance = await LocalStorage().getIdAttendance();
    print("idAttendance: -------------$idAttendance---------------------");
    if (idAttendance != null) {
      HomeFireStore()
          .getAtendance(idAttendance: idAttendance)
          .then((atendance) {
        // Get.back();

        if (atendance.exists) {
          _attendance = Attendance.fromJson(atendance.data());

          if (_attendance.status ?? false) {
            _statusApp = 'clockIn';
            // _attendance.duration = DateTime.now().difference(_attendance.clockIn?? DateTime.now()).inSeconds;
            Duration timeWorking = DateTime.now()
                .difference(_attendance.clockIn ?? DateTime.now());
            timeCircler = timeCircler - timeWorking.inSeconds;
          } else {
            _statusApp = 'clockOut';
          }
        } else {
          // _statusApp = 'clockIn';
          print('atendance not found');
        }
        update();
      }).catchError((error) {
        print('error: $error');
        Get.back();

        errorSnackBar(message: 'Une erreur est survenue'.tr);
      });
    } else {
      _statusApp = 'clockIn';
      update();
    }
  }

// -------------------------------start timer-----
  start({required User user}) async {
    loddingDialog();

    bool inWorking = false;
    int counter = 2;
    while (counter > 0) {
      counter--;
      LocationDivice locationDivice = LocationDivice();
      _locationData = await locationDivice.getLocation();
      print('locationData: $_locationData');
      inWorking = locationDivice.positionIsOk(
        latitude: locationData?.latitude,
        longitude: locationData?.longitude,
        latitudeAgency: user.latitudeAgency,
        longitudeAgency: user.longitudeAgency,
      );
      if (inWorking) {
        break;
      }
    }
    print(inWorking);
    if (inWorking) {
      DateTime startDate = await NTP
          .now(timeout: const Duration(seconds: 30))
          .onError((error, stackTrace) {
        print('error: $error');
        print('stackTrace: $stackTrace');
        Get.back();
        errorSnackBar(message: 'Une erreur est survenue'.tr);
        return DateTime.now();
      });
      timeCircler = user.timeWorking ?? 8 * 60 * 60;

      _attendance = Attendance(
        nameUser: user.name,
        phoneUser: user.phone,
        idAgency: user.idAgency,
        idUser: user.id,
        role: user.role,
        status: true,
        clockIn: startDate,
        positionClockIn:
            GeoPoint(locationData?.latitude ?? 0, locationData?.longitude ?? 0),
      );
      addAttendanceToFirebase(attendance: _attendance);
    } else {
      Get.back();
      errorSnackBar(
          message:
              "Nous rencontrons des problèmes pour identifier votre position! , Veillez réessayer"
                  .tr);
    }
  }

  addAttendanceToFirebase({required Attendance attendance}) async {
    await HomeFireStore()
        .addAttendance(attendance: attendance.toJson())
        .then((attendanceData) {
      LocalStorage().setIdAttendance(id: attendanceData.id);
      circularcontroller.start();
      Get.back();
      _statusApp = 'clockIn';
      update();
      successSnackBar(message: 'Votre presence est enregistrer'.tr);
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      Get.back();
      _attendance.status = false;
      print('error in attendanceData');
      errorSnackBar(message: 'Une erreur est survenue'.tr);
    }).catchError((e) {
      Get.back();
      _attendance.status = false;
      print(e.toString());
      errorSnackBar(message: 'Une erreur est survenue'.tr);
    });
  }

// ---------------------------------stop timer-----
  stop({required User user}) async {
    loddingDialog();

    bool inWorking = false;
    int counter = 2;
    while (counter > 0) {
      counter--;
      LocationDivice locationDivice = LocationDivice();
      _locationData = await locationDivice.getLocation();
      print('locationData: $_locationData');
      inWorking = locationDivice.positionIsOk(
        latitude: locationData?.latitude,
        longitude: locationData?.longitude,
        latitudeAgency: user.latitudeAgency,
        longitudeAgency: user.longitudeAgency,
      );
      if (inWorking) {
        break;
      }
    }
    print(inWorking);
    if (inWorking) {
      _attendance.clockOut = await NTP
          .now(timeout: const Duration(seconds: 30))
          .onError((error, stackTrace) {
        print('error: $error');
        print('stackTrace: $stackTrace');
        Get.back();
        errorSnackBar(message: 'Une erreur est survenue'.tr);
        return DateTime.now();
      });

      _attendance.positionClockOut =
          GeoPoint(locationData?.latitude ?? 0, locationData?.longitude ?? 0);
      Duration duration = _attendance.clockOut!
          .difference(_attendance.clockIn ?? DateTime.now());
      _attendance.duration = duration.toString();
      _attendance.status = false;

      updateAttendance(attendance: _attendance);
      Get.back();
    } else {
      Get.back();
      errorSnackBar(message: 'vous n\'etes pas dans la zone de travail'.tr);
    }
  }

  updateAttendance({required Attendance attendance}) async {
    String? id = await LocalStorage().getIdAttendance();

    await HomeFireStore()
        .updateAttendance(
      attendance: attendance.toJson(),
      idAttendance: id ?? '',
    )
        .then((value) {
      circularcontroller.pause();
      _statusApp = 'clockOut';
      successSnackBar(message: 'Votre sortie est enregistrer'.tr);
      update();
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      _attendance.status = true;
      print('error in attendanceData');
      errorSnackBar(message: 'Une erreur est survenue'.tr);
    }).catchError((e) {
      _attendance.status = true;
      print(e.toString());
      errorSnackBar(message: 'Une erreur est survenue'.tr);
    });
  }

  // -----------------get time working -----------
  int getTimeWorking(int timeWorking) {
    Duration duration =
        DateTime.now().difference(_attendance.clockIn ?? DateTime.now());
    // circularcontroller.start();
    return duration.inSeconds;
  }
}
