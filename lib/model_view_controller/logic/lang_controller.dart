import 'dart:ui';

// import 'package:Basme/data/service/local_storege/local_storage.dart';
import 'package:get/get.dart';

class LangController extends GetxController {
  String lang = 'fr';

  //  change lang
  changeLang(String lang) {
    this.lang = lang;
    Get.updateLocale(Locale(lang));
    // LocalStorage localStorage = LocalStorage();
    // localStorage.writeLanguage(lang);
    update();
  }

  @override
  void onInit() {
    lang = Get.deviceLocale!.languageCode;
    print(Get.deviceLocale.toString());
    if (lang == 'ar') {
      lang = 'ar';
      // update();
    } else {
      lang = 'fr';
    }
    super.onInit();
  }
}
