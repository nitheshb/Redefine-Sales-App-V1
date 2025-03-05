import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/SuperHomePage/SuperHomePage.dart';
import 'package:redefineerp/Utilities/snackbar.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/methods/methods.dart';
import 'package:redefineerp/models/user.dart';
import 'package:redefineerp/util/auth.dart';
import 'package:redefineerp/util/state_widget.dart';
import 'package:supabase/supabase.dart';

class AuthController extends GetxController {
  //   final SupabaseClient supabaseClient;
  // AuthController(this.supabaseClient);
  // AuthController()
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var showPass = true.obs;
  RxInt activeIndex = 0.obs;
  var currentUserObj = {}.obs;

  final  currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  String? localFcmToken;

  String? loggedInFcmToken;

  var userDetails = [];
    void setOrgId(var newOrgId) {
      print('my value sis c  $newOrgId');
    currentUserObj.assignAll(newOrgId[0].data());
  }
startTimer() {
    Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        activeIndex.value++;
        if (activeIndex.value == 4) {
          activeIndex.value = 0;
        }
      },
    );
  }
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      localFcmToken = token;
      debugPrint("Local fcm token is $token");
    });
  }

  void getLoggedInUserDetails() async {
    var x = await DbQuery.instanace.getLoggedInUserDetails(currentUser?.uid);
    setOrgId(x);

   
  }

  @override
  void onInit() {
    showPass.value = false;
    getToken();
    getLoggedInUserDetails();
     startTimer();
    super.onInit();
  }

  void loginUser(BuildContext context) async {

    //   await  StateWidget.of(context).logInUser(email.text, password.text);
    // await  Get.offAll(() => SuperHomePage());
    //   return;
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      isLoading = true;
      logIn(email.text, password.text);

     /* logIn(email.text, password.text).then((user)async{

          if (user != null && localFcmToken != null) {


          isLoading = false;
          var currentUser = FirebaseAuth.instance.currentUser;
                    debugPrint("Login Sucessfull ${currentUser?.uid}");
             user = await Auth.getUserFirestore(currentUser?.uid);
//  FirebaseAuth.instance.authStateChanges().listen((user) {
//       // setOrgId(user);
//     });
print('user details are ${user}');
    // await Auth.storeUserLocal(user as Bid365User);

          FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser?.uid)
              .update({"user_fcmtoken": localFcmToken}).then((_) {
            debugPrint("success!");
          });



          Get.offAll(() => SuperHomePage());
        }
        else {
          snackBarMsg('Error: Invalid credentials');
          debugPrint("Login Failed");
          isLoading = false;
        }
      }
      );*/

     /* FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseFirestore _firestore = FirebaseFirestore.instance;


      try {
        await _auth.signInWithEmailAndPassword(email: email.text.toString(),
            password: password.text.toString());

        snackBarMsg("Logged in successfully!");

        Get.offAll(() => SuperHomePage());

      } catch (e) {
        print(e.toString());
        snackBarMsg("Login Failed: ${e.toString()}");
      }
  */

     // _auth.signInWithEmailAndPassword(email: email.text.toString(),
       //   password:password.text.toString());




    }
    else {

      debugPrint("Please fill form correctly");
    }
  }
}
