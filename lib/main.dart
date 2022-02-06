// import 'package:device_preview/device_preview.dart' as dv;

import 'package:Basme/model_view_controller/data/service/lang/traslation.dart';
import 'package:Basme/model_view_controller/logic/binding.dart';
import 'package:Basme/model_view_controller/pages/splash/splash_load.dart';
import 'package:Basme/model_view_controller/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
      // name: defaultFirebaseAppName,
      // options: const FirebaseOptions(
      //     apiKey: 'AIzaSyCl6dlVkLWbRlHXCDmu3CjR4yYG82Oh_Vk',
      //     appId:
      //         '467324606757-5cbddh9iuasd34piksn7huopq6gm3icf.apps.googleusercontent.com',
      //     messagingSenderId: '',
      //     projectId: "abchir-47f81"),
      );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // for rotation
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    // const MyApp()
    // dv.DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    const MyApp(), // Wrap your app
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // useInheritedMediaQuery: true, // Set to true
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      // ----------lang
      translations: Translation(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('fr'),
      defaultTransition: Transition.cupertino,
      theme: myTheme,
      home: Splash(),
    );
  }
}
