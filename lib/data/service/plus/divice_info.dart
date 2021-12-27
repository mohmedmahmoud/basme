import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class DiviceInfo {
  Future<String?> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        String deviceName = build.model;
        print('deviceName: $deviceName');
        AndroidBuildVersion androidBuildVersion = build.version;
        String idDivice = build.androidId; //UUID for Android

        return idDivice;
      } else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        String deviceName = data.name;
        print('deviceName: $deviceName');
        String deviceVersion = data.systemVersion;
        String idDivice = data.identifierForVendor; //UUID for iOS
        print(' ---indentifier--- ' + idDivice);
        return idDivice;
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }
}
