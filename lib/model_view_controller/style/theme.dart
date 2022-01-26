import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

final ThemeData myTheme = ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: whiteColor,
  primarySwatch: const MaterialColor(4280861781, {
    50: Color(0xffeafbef),
    100: Color(0xffd5f6de),
    200: Color(0xffaaeebe),
    300: Color(0xff80e59d),
    400: Color(0xff56dc7c),
    500: Color(0xff2bd45c),
    600: Color(0xff23a949),
    700: Color(0xff1a7f37),
    800: Color(0xff115525),
    900: Color(0xff092a12)
  }),
  brightness: Brightness.light,
  primaryColor: const Color(0xff00C569),
  primaryColorBrightness: Brightness.light,
  primaryColorLight: const Color(0xffd5f6de),
  primaryColorDark: const Color(0xff1a7f37),
);

const Color greyColor = Color(0xFFEEEEEE);
const whiteColor = Color(0xFFFDFDFD);








// ThemeData(
//   primarySwatch: const MaterialColor(4293980398, {
//     50: Color(0xfff3f3f1),
//     100: Color(0xffe7e7e4),
//     200: Color(0xffcfcfc9),
//     300: Color(0xffb7b7ae),
//     400: Color(0xff9f9f93),
//     500: Color(0xff878778),
//     600: Color(0xff6c6c60),
//     700: Color(0xff515148),
//     800: Color(0xff363630),
//     900: Color(0xff1b1b18)
//   }),
//   brightness: Brightness.light,
//   primaryColor:
//       //  const Color.fromRGBO(240, 156, 34, 1),
//       const Color(0xfff0f0ee),
//   primaryColorBrightness: Brightness.light,
//   primaryColorLight: const Color(0xffe7e7e4),
//   primaryColorDark: const Color(0xff515148),
//   accentColor: Color.fromRGBO(60, 72, 101, 1),
//   accentColorBrightness: Brightness.dark,
//   canvasColor: const Color.fromRGBO(240, 156, 34, 1),
//   scaffoldBackgroundColor: const Color(0xFFFFFFFF),
//   bottomAppBarColor: Color(0xffffffff),
//   cardColor: Color(0xffffffff),
//   dividerColor: Color(0x1f000000),
//   highlightColor: Color(0x66bcbcbc),
//   splashColor: Color(0x66c8c8c8),
//   selectedRowColor: Color(0xfff5f5f5),
//   unselectedWidgetColor: Color(0x8a000000),
//   disabledColor: Color(0x61000000),
//   buttonColor: Color(0xffe0e0e0),
//   toggleableActiveColor: Color(0xff6c6c60),
//   secondaryHeaderColor: Color(0xfff3f3f1),
//   textSelectionColor: Color(0xffcfcfc9),
//   cursorColor: Color(0xff4285f4),
//   textSelectionHandleColor: Color(0xffb7b7ae),
//   backgroundColor: Color(0xffcfcfc9),
//   dialogBackgroundColor: Color(0xffffffff),
//   indicatorColor: Color(0xff878778),
//   hintColor: Color(0x8a000000),
//   errorColor: Color(0xffd32f2f),
//   buttonTheme: ButtonThemeData(
//     textTheme: ButtonTextTheme.normal,
//     minWidth: 88,
//     height: 36,
//     padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
//     shape: RoundedRectangleBorder(
//       side: BorderSide(
//         color: Color(0xff000000),
//         width: 0,
//         style: BorderStyle.none,
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(2.0)),
//     ),
//     alignedDropdown: false,
//     buttonColor: const Color(0xffe0e0e0),
//     disabledColor: const Color(0x61000000),
//     highlightColor: const Color(0x29000000),
//     splashColor: const Color(0x1f000000),
//     focusColor: const Color.fromRGBO(240, 156, 34, 1),
//     hoverColor: const Color(0x0a000000),
//     colorScheme: const ColorScheme(
//       primary: Color(0xfff0f0ee),
//       primaryVariant: Color(0xff515148),
//       secondary: Color(0xff878778),
//       secondaryVariant: Color(0xff515148),
//       surface: Color(0xffffffff),
//       background: Color(0xffcfcfc9),
//       error: Color(0xffd32f2f),
//       onPrimary: Color(0xff000000),
//       onSecondary: Color(0xffffffff),
//       onSurface: Color(0xff000000),
//       onBackground: Color(0xff000000),
//       onError: Color(0xffffffff),
//       brightness: Brightness.light,
//     ),
//   ),
//   fontFamily: 'Inter',
//   textTheme: TextTheme(

    
//       ),
//   inputDecorationTheme: InputDecorationTheme(
//     labelStyle: TextStyle(
//       color: Color(0xdd000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     helperStyle: TextStyle(
//       color: Color(0xdd000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     hintStyle: TextStyle(
//       color: Color(0xdd000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     errorStyle: TextStyle(
//       color: Color(0xdd000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     errorMaxLines: null,
//     isDense: false,
//     contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
//     isCollapsed: false,
//     prefixStyle: TextStyle(
//       color: Color(0xdd000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     suffixStyle: TextStyle(
//       color: Color(0xdd000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     counterStyle: TextStyle(
//       color: Color(0xdd000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     filled: false,
//     fillColor: Color(0x00000000),
//     errorBorder: UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Color(0xff000000),
//         width: 1,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(4.0)),
//     ),
//     focusedBorder: UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Color(0xff000000),
//         width: 1,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(4.0)),
//     ),
//     focusedErrorBorder: UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Color(0xff000000),
//         width: 1,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(4.0)),
//     ),
//     disabledBorder: UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Color(0xff000000),
//         width: 1,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(4.0)),
//     ),
//     enabledBorder: UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Color(0xff000000),
//         width: 1,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(4.0)),
//     ),
//     border: UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Color(0xff000000),
//         width: 1,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(4.0)),
//     ),
//   ),
//   iconTheme: IconThemeData(
//     color: Color(0xdd000000),
//     opacity: 1,
//     size: 24,
//   ),
//   primaryIconTheme: IconThemeData(
//     color: Color(0xff000000),
//     opacity: 1,
//     size: 24,
//   ),
//   accentIconTheme: IconThemeData(
//     color: Color(0xffffffff),
//     opacity: 1,
//     size: 24,
//   ),
//   sliderTheme: SliderThemeData(
//     activeTrackColor: null,
//     inactiveTrackColor: null,
//     disabledActiveTrackColor: null,
//     disabledInactiveTrackColor: null,
//     activeTickMarkColor: null,
//     inactiveTickMarkColor: null,
//     disabledActiveTickMarkColor: null,
//     disabledInactiveTickMarkColor: null,
//     thumbColor: null,
//     disabledThumbColor: null,
//     overlayColor: null,
//     valueIndicatorColor: null,
//     showValueIndicator: null,
//     valueIndicatorTextStyle: TextStyle(
//       color: Color(0xffffffff),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//   ),
//   tabBarTheme: TabBarTheme(
//     indicatorSize: TabBarIndicatorSize.tab,
//     labelColor: Color(0xdd000000),
//     unselectedLabelColor: Color(0xb2000000),
//   ),
//   chipTheme: ChipThemeData(
//     backgroundColor: Color(0x1f000000),
//     brightness: Brightness.light,
//     deleteIconColor: Color(0xde000000),
//     disabledColor: Color(0x0c000000),
//     labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
//     labelStyle: TextStyle(
//       color: Color(0xde000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
//     secondaryLabelStyle: TextStyle(
//       color: Color(0x3d000000),
//       fontSize: null,
//       fontWeight: FontWeight.w400,
//       fontStyle: FontStyle.normal,
//     ),
//     secondarySelectedColor: Color(0x3df0f0ee),
//     selectedColor: Color(0x3d000000),
//     shape: StadiumBorder(
//         side: BorderSide(
//       color: Color(0xff000000),
//       width: 0,
//       style: BorderStyle.none,
//     )),
//   ),
//   dialogTheme: DialogTheme(
//       shape: RoundedRectangleBorder(
//     side: BorderSide(
//       color: Color(0xff000000),
//       width: 0,
//       style: BorderStyle.none,
//     ),
//     borderRadius: BorderRadius.all(Radius.circular(0.0)),
//   )),
// );
