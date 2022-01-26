import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  void setUser(Map user) async {
    await GetStorage().write('user', user);
  }

// -------------------------- id attendance --------------------------
  void setIdAttendance({String? id}) async {
    await GetStorage().write('idAttendance', id);
  }

  Future<String?> getIdAttendance() async {
    return GetStorage().read('idAttendance');
  }

  void deleteIdAttendance() {
    GetStorage().remove('idAttendance');
  }

  // --------------------------- user ---------------------------
  Future<dynamic> getUser() async {
    return await GetStorage().read('user');
  }

  removeUser() async {
    await GetStorage().remove('user');
  }

  // ----------------------lang--------------------------------

  void writeLanguage(String lang) async {
    await GetStorage().write('lang', lang);
  }

  // Future<String> get readLanguage async {
  //   String lang = await GetStorage().read('lang');

  //     lang = 'fr';

  //   if (lang == 'fr' || lang == 'ar') {
  //     return lang;
  //   } else {
  //     return 'fr_FR';
  //   }
  // }

  Future<bool> get readOnbording async {
    bool isOnbording = await GetStorage().read('isOnbording');
    if (isOnbording == null) {
      isOnbording = false;
    }
    return isOnbording;
  }

  void writeOnbording() async {
    await GetStorage().write('isOnbording', true);
  }

  // void writeTheme(bool darkTheme) async {
  //   await GetStorage().write('dark', darkTheme);
  // }

  // Future<bool> get readTheme async {
  //   bool dark = await GetStorage().read('dark');
  //   if (dark == null) {
  //     dark = false;
  //   }
  //   return dark;
  // }

}
