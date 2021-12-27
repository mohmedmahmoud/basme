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
    return await GetStorage().read('idAttendance');
  }

  void deleteIdAttendance() {
    GetStorage().remove('idAttendance');
  }

  // --------------------------- user ---------------------------
  Future<dynamic> getUser() async {
    return await GetStorage().read('user');

    // if (null == user) {
    //   print('is not exist');
    //   return user;
    // } else {
    //   print('is  exist');
    //   return user;
    // }
  }

  removeUser() async {
    await GetStorage().remove('user');
  }

  // enregistrer dans le telephone la language
  // void writeLanguage(String lang) async {
  //   await GetStorage().write('lang', lang);
  // }

  // lire le language enregistrer
  // Future<String> get readLanguage async {
  //   String lang = await GetStorage().read('lang');
  //   if (lang == null) lang = Platform.localeName;
  //   if (lang == 'fr_FR' || lang == 'ar')
  //     return lang;
  //   else
  //     return 'fr_FR';
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
