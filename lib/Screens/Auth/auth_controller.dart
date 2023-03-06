import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Home/homepage.dart';
import 'package:redefineerp/Utilities/snackbar.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/methods/methods.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var showPass = true.obs;

  final User? currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  String? localFcmToken;

  String? loggedInFcmToken;

  var userDetails = [];

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      localFcmToken = token;
      debugPrint("Local fcm token is $token");
    });
  }

  void getLoggedInUserDetails() async {
    var x = await DbQuery.instanace.getLoggedInUserDetails(currentUser?.uid);
  }

  @override
  void onInit() {
    showPass.value = false;
    getToken();
    getLoggedInUserDetails();
    super.onInit();
  }

  void loginUser() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      isLoading = true;
      logIn(email.text, password.text).then((user) {
        if (user != null && localFcmToken != null) {
          debugPrint("Login Sucessfull");
          isLoading = false;
          var currentUser = FirebaseAuth.instance.currentUser;

          FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser?.uid)
              .update({"user_fcmtoken": localFcmToken}).then((_) {
            debugPrint("success!");
          });
          Get.to(() => HomePage());
        } else {
          snackBarMsg('Error: Invalid credentials');
          debugPrint("Login Failed");
          isLoading = false;
        }
      });
    } else {
      debugPrint("Please fill form correctly");
    }
  }
}
