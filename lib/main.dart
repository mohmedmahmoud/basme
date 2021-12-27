// import 'package:device_preview/device_preview.dart' as dv;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mybim/logic/binding.dart';

import 'package:mybim/pages/splash/splash_load.dart';

import 'package:mybim/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
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
      title: 'Flutter Demo',
      theme: myTheme,
      home: Splash(),
    );
  }
}
