// import 'package:flutter/services.dart';
// import 'package:local_auth/auth_strings.dart';
// import 'package:local_auth/local_auth.dart';

// class LocalAuthApi {
//   static final _auth = LocalAuthentication();

//   static Future<bool> hasBiometrics() async {
//     try {
//       return await _auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       // ignore: avoid_print
//       print("error -------------- $e");
//       return false;
//     }
//   }

//   static Future<List<BiometricType>> getBiometrics() async {
//     try {
//       return await _auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       print("error -------------------$e");
//       return <BiometricType>[];
//     }
//   }

//   static Future<bool> authenticate() async {
//     final isAvailable = await hasBiometrics();
//     if (!isAvailable) return false;

//     try {
//       return await _auth.authenticate(
//           localizedReason: 'Scan Fingerprint to Authenticate',
//           useErrorDialogs: true,
//           stickyAuth: true,
//           biometricOnly: true,
//           androidAuthStrings: const AndroidAuthMessages());
//     } on PlatformException catch (e) {
//       print("error -------------------$e");
//       return false;
//     }
//   }
// }
