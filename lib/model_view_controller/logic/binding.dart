import 'package:Basme/model_view_controller/logic/home_controller.dart';
import 'package:get/get.dart';

import 'package:Basme/model_view_controller/logic/login_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
  }
}
