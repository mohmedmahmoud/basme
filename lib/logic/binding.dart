import 'package:get/get.dart';
import 'package:mybim/logic/home_controller.dart';
import 'package:mybim/logic/login_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
  }
}
