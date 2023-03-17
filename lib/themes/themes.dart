// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Profile/profile_controller.dart';

ProfileController profileController = Get.put(ProfileController());

extension ThemeExtension on ThemeData {
  Color get colorPrimary => brightness == Brightness.dark
      ? const Color.fromARGB(255, 29, 29, 29)
      : const Color(0xFFFFFFFF);
  Color get colorPrimaryDark => profileController.currentTheme.value == 'light'
      ? const Color(0xffFF7562)
      : profileController.currentTheme.value == 'blue'
          ? const Color(0xff6EC2FB)
          : profileController.currentTheme.value == 'green'
              ? const Color(0xff4CD471)
              : const Color(0xffFF7562);

  Color get colorAccent => const Color.fromRGBO(236, 163, 152, 1);
  Color get overlayColor => Color(0xFFFFEDEB);
  Color get successColor => const Color.fromARGB(255, 41, 204, 57);
  Color get kBlueColor => const Color.fromARGB(255, 51, 99, 255);
  Color get kYellowColor => const Color(0xffFFCB33);
  Color get kRedColor => const Color(0xffE62E2E);
  Color get kGreenLight => const Color.fromARGB(255, 244, 252, 245);
  Color get kGreenLight2 => const Color.fromARGB(255, 233, 250, 235);
  Color get kGreenDark => const Color.fromARGB(255, 0, 128, 13);
  Color get kLightGrayColor => const Color.fromRGBO(0, 0, 0, 0.33);
  Color get kBadgeColor => const Color(0xFF7D8FB3);
  Color get kBadgeColorBg => const Color.fromARGB(255, 239, 243, 248);
  Color get kContactIconColor => Color.fromARGB(255, 16, 50, 117);
  Color get btnTextCol => brightness == Brightness.dark
      ? const Color(0xe8e9e9e9)
      : Color.fromARGB(255, 27, 27, 27);
  Color get sheetColor => brightness == Brightness.dark
      ? const Color(0xff232323)
      : const Color(0xf0ffffff);
  Color get curveBG => brightness == Brightness.dark
      ? const Color(0x8D4A4A48)
      : const Color(0xB4F1F1F1);
  TextStyle get kTitleStyle =>
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600);
  TextStyle get kSubTitle =>
      GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600);
  TextStyle get kNormalStyle =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700);
  TextStyle get kPrimaryTxtStyle =>
      GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600);
  TextStyle get kTabTextLg =>
      GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.w700);
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

  static final blueTheme = ThemeData.light().copyWith(
    // backgroundColor: Colors.white,
    primaryColor: const Color(0xff6EC2FB),
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff6EC2FB),
            statusBarIconBrightness: Brightness.dark)),
    scaffoldBackgroundColor: const Color(0xffffffff),
    // textTheme: TextTheme(headline1: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w800,color: Theme.of(context).btnTextCol),headline2: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.w600),headline3: GoogleFonts.quicksand(fontSize: 14,fontWeight: FontWeight.w600))
  );

  static final greenTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    primaryColor: const Color(0xff4CD471),
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: const Color(0xffffffff),
            statusBarIconBrightness: Brightness.dark)),
    scaffoldBackgroundColor: const Color(0xffffffff),
    // textTheme: TextTheme(headline1: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w800,color: Theme.of(context).btnTextCol),headline2: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.w600),headline3: GoogleFonts.quicksand(fontSize: 14,fontWeight: FontWeight.w600))
  );
}