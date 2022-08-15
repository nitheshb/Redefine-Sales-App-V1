// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ThemeExtension on ThemeData {
  Color get colorPrimary => brightness == Brightness.dark
      ? const Color.fromARGB(255, 29, 29, 29)
      : const Color(0xFFFFFFFF);
  Color get colorPrimaryDark => brightness == Brightness.dark
      ? const Color.fromARGB(255, 236, 163, 152)
      : const Color.fromARGB(255, 236, 163, 152);
  Color get colorAccent => const Color.fromARGB(255, 51, 99, 255);
  Color get successColor => const Color.fromARGB(255, 41, 204, 57);
  Color get kYellowColor => const Color(0xffFFCB33);
  Color get kRedColor => const Color(0xffE62E2E);
  Color get kGreenLight => const Color.fromARGB(255, 244, 252, 245);
  Color get kGreenLight2 => const Color.fromARGB(255, 233, 250, 235);
  Color get kGreenDark => const Color.fromARGB(255, 0, 128, 13);
  Color get btnTextCol => brightness == Brightness.dark
      ? const Color(0xe8e9e9e9)
      : const Color(0xff494646);
  Color get sheetColor => brightness == Brightness.dark
      ? const Color(0xff232323)
      : const Color(0xf0ffffff);
  Color get curveBG => brightness == Brightness.dark
      ? const Color(0x8D4A4A48)
      : const Color(0xB4F1F1F1);
}

class Themes {
  static final light = ThemeData.light().copyWith(
    // backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xffffffff),
            statusBarIconBrightness: Brightness.dark)),
    scaffoldBackgroundColor: const Color(0xffffffff),
    // textTheme: TextTheme(headline1: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w800,color: Theme.of(context).btnTextCol),headline2: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.w600),headline3: GoogleFonts.quicksand(fontSize: 14,fontWeight: FontWeight.w600))
  );
  static final dark = ThemeData.dark().copyWith(
    // backgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xf2161616),
            statusBarIconBrightness: Brightness.light)),
    scaffoldBackgroundColor: const Color(0xff161616),
  );
}
