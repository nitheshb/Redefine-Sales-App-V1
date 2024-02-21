// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Profile/profile_controller.dart';

ProfileController profileController = Get.put(ProfileController());

final ThemeData appLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF6B4EFF),
    primaryColorDark: const Color(0xFF5538EE),
    primaryColorLight: const Color(0xFF9990FF),
    backgroundColor: Color.fromARGB(255, 242, 240, 240));
extension ThemeExtension on ThemeData {


//  Color get  primary => Color(0xff1c8c8c);
   Color get  primary => Color(0xff6350A9);
   Color get        onPrimary=> Color(0xffffffff);
    Color get       primaryContainer=> Color(0xffE7DDFF);
    Color get       onPrimaryContainer=> Color(0xff025e5e);
    Color get       secondary=> Color(0xfff15f5f);
     Color get      onSecondary=> Color(0xffffffff);
     Color get      secondaryContainer=> Color(0xfff8d6d6);
     Color get      onSecondaryContainer=> Color(0xff570202);
     Color get      Background=> Color(0xffFFFBFF);

     Color get      onBackground=> Color(0xff686868);
     
     Color get      ErrorContainer=> Color(0xffFFD9D4);
     Color get      onErrorContainer=> Color.fromARGB(255, 146, 104, 104);


          
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

final TextTheme textTheme = TextTheme(
  bodyLarge: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14),
  bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
  bodyText1: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14),
  bodyText2: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13),
  caption: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12),
  headline4: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12),
  headline5: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 12),
  headlineLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 11.7),
  headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 11),
  labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 11.4),
  labelMedium: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 11.4),
  labelSmall: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 11.3),
  overline: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 11.3),
  subtitle1: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 11.3),
  subtitle2: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 11.3),
  titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 11.3),
  titleMedium: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 11),
  titleSmall: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 11.3),
);

final ThemeData appBlueMode = ThemeData(
  primaryColor: const Color(0xFF48A7F8),
  primaryColorDark: const Color(0xFF0065D0),
  primaryColorLight: const Color(0xFF6EC2FB),
);
// for primary theme
const primaryLighther = Color(0xFFC6C4FF);
const primaryLightest = Color(0xFFE7E7FF);

// for blue theme
const primaryBlueLighter = Color(0xFF9BDCFD);
const primaryBlueLightest = Color(0xFFC9F0FF);

// for ink theme
const inkDarkest = Color(0xFF090A0A);
const inkDarker = Color(0xFF202325);
const inkDark = Color(0xFF303437);
const inkBase = Color(0xFF404446);
const inkLight = Color(0xFF6C7072);
const inkLighter = Color(0xFF72777A);

ThemeData appGreenTheme = ThemeData(
    primaryColor: const Color(0xFF23C16B),
    primaryColorDark: const Color(0xFF198155),
    primaryColorLight: const Color(0xFF4CD471));

// for green theme

const primaryGreenLighter = Color(0xFF7DDE86);
const primaryGreenLightest = Color(0xFFECFCE5);

TextStyle displaySmall =
    GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16);

TextStyle displayMedium =
    GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 17);

TextStyle caption = GoogleFonts.inter(
    fontWeight: FontWeight.w500, fontSize: 16.3, color: Color(0xFF6C7072));

TextStyle button = GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 12);

TextStyle headline3 =
    GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16);

TextStyle headline2 =
    GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 18);
TextStyle displayLarge =
    GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15);

TextStyle bodySmall =
    GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 13);

TextStyle headline6 =
    GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14.6);

TextStyle headlineSmall = GoogleFonts.inter(
  fontWeight: FontWeight.w800,
  fontSize: 11.4,
);

TextStyle buttontext = GoogleFonts.inter(
    fontWeight: FontWeight.w600, fontSize: 13.4, color: Colors.white);

TextStyle headline1 =
    GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 20);

TextStyle titleNormal = GoogleFonts.inter(
    fontWeight: FontWeight.w400, fontSize: 14.3, color: Color(0xFF72777A));

TextStyle titleRegular =
    GoogleFonts.inter(fontWeight: FontWeight.w300, fontSize: 14.3);

TextStyle titleTiny =
    GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 10.8);

TextStyle titleTinyMedium =
    GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 10.8);

TextStyle titleTinyRegular =
    GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 10.8);
TextStyle titleTinyBold =
    GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 10.8);

TextStyle bodyTinyMedium =
    GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 10.8);

TextStyle bodyTinyRegular =
    GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 10.6);

TextStyle bodyTinyBold =
    GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 10.6);

TextStyle tinyMedium =
    GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 10.6);

TextStyle tinyRegular = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 12.4,
    letterSpacing: 1.0,
    height: 1.4);

