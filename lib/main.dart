// ignore_for_file: unrelated_type_equality_checks

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:redefineerp/Screens/Home/homepage.dart';
import 'package:redefineerp/Screens/OnBoarding/onboarding_page.dart';
import 'package:redefineerp/Screens/SuperHomePage/SuperHomePage.dart';
import 'package:redefineerp/getx_bindings.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:redefineerp/themes/themes_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase/supabase.dart';
import 'Screens/Profile/profile_controller.dart';
import 'firebase_options.dart';

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

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // Create a new instance of the SupabaseClient class

  GetIt getIt = GetIt.instance;

  getIt.registerSingleton<SupabaseClient>(SupabaseClient('https://cezgydfbprzqgxkfcepq.supabase.co','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlemd5ZGZicHJ6cWd4a2ZjZXBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDU0NTA4NTQsImV4cCI6MTk2MTAyNjg1NH0.UDAQvbY_GqEdLLrZG6MFnhDWXonAbcYnrHGHDD6-hYU'));
  // final supabaseClient = SupabaseClient(
  //   'https://cezgydfbprzqgxkfcepq.supabase.co',
  //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlemd5ZGZicHJ6cWd4a2ZjZXBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDU0NTA4NTQsImV4cCI6MTk2MTAyNjg1NH0.UDAQvbY_GqEdLLrZG6MFnhDWXonAbcYnrHGHDD6-hYU',
  // );
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((_) => runApp( MyApp()));
}

class MyApp extends StatelessWidget {
  //  final SupabaseClient supabaseClient;
  // const MyApp({Key? key, this.supabaseClient}) : super(key: key);
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final  currentUser = FirebaseAuth.instance.currentUser;
    final controller = Get.put<ProfileController>(ProfileController());
    return GetMaterialApp(
      defaultTransition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 800),
      darkTheme: Themes.dark,
      initialBinding: ControllerBindings(),
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      home: currentUser == null ? OnBoardingPage() : SuperHomePage(),
    );
  }
}
