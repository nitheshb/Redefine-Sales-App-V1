import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:redefineerp/Screens/Home/homepage.dart';
import 'package:redefineerp/Screens/OnBoarding/onboarding_page.dart';
import 'package:redefineerp/getx_bindings.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:redefineerp/themes/themes_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

import 'package:gotrue/src/types/user.dart' as GoTrue;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Handling a background message ${message.messageId}');
}
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   channel = const AndroidNotificationChannel(
      'redefine_channel',
      'Redefine notifications',
      description: 'Redefine ERP tasks notifications',
      enableLights: true,
      ledColor: Colors.green,
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
     await Supabase.initialize(
    url: 'https://cezgydfbprzqgxkfcepq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlemd5ZGZicHJ6cWd4a2ZjZXBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDU0NTA4NTQsImV4cCI6MTk2MTAyNjg1NH0.UDAQvbY_GqEdLLrZG6MFnhDWXonAbcYnrHGHDD6-hYU',
  );
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final fireAuth.User? currentUser = fireAuth.FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      defaultTransition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 800),
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialBinding: ControllerBindings(),
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      home: currentUser == null ? const OnBoardingPage() : HomePage(),
    );
  }
}
