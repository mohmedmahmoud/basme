import 'package:get/get.dart';
import 'package:Basme/logic/home_controller.dart';
import 'package:Basme/logic/login_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
  }
}
