import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Home/homepage.dart';
import 'package:redefineerp/Screens/OnBoarding/onboarding_page.dart';
import 'package:redefineerp/getx_bindings.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:redefineerp/themes/themes_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) =>runApp(const MyApp()) );
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 800),
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialBinding: ControllerBindings(),
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      home: const OnBoardingPage(),
    );
  }
}