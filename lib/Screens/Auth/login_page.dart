import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Auth/auth_controller.dart';
import 'package:redefineerp/Screens/Home/homepage.dart';
import 'package:redefineerp/Screens/OnBoarding/onboarding_page.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/methods/methods.dart';
import 'package:redefineerp/themes/themes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put<AuthController>(AuthController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeBox(20, 0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Login',
                  style: Get.theme.kTabTextLg,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: TextFormField(
                    controller: controller.email,
                    validator: (value) {
                      if (!GetUtils.isEmail(value!)) {
                        return 'Please enter a valid email ID.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.check),
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Get.theme.colorPrimaryDark)),
                      border: const OutlineInputBorder(),
                      errorStyle: TextStyle(color: Get.theme.kRedColor),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(
                  () => TextField(
                    maxLines: 1,
                    obscureText: controller.showPass.value,
                    controller: controller.password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '***********',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Get.theme.colorPrimaryDark)),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.showPass.value =
                              !controller.showPass.value;
                        },
                        child: controller.showPass.value
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : Icon(
                                Icons.remove_red_eye,
                                color: Get.theme.colorPrimaryDark,
                              ),
                      ),
                    ),
                  ),
                ),
              ),

              //       Center(
              //         child: Padding(
              //           padding: const EdgeInsets.all(20.0),
              //           child: TextButton(
              //               style: TextButton.styleFrom(
              //                   primary: Colors.white,
              //                   backgroundColor: Get.theme.colorPrimaryDark,
              //                   alignment: Alignment.center,
              //                   padding: const EdgeInsets.all(15),
              //                   fixedSize: Size(Get.size.width, 50),
              //                   textStyle: Get.theme.kNormalStyle),
              //               onPressed: () => {
              //                      if (controller.emailID.text.isNotEmpty && controller.password.text.isNotEmpty) {
              //   setState(() {
              //     isLoading = true;
              //   });
              //   logIn(_email.text, _password.text).then((user) {
              //     if (user != null && localFcmToken != null) {
              //       print("Login Sucessfull");
              //       setState(() {
              //         isLoading = false;
              //       });
              //       var currentUser = FirebaseAuth.instance.currentUser;

              //       FirebaseFirestore.instance
              //           .collection('users')
              //           .doc(currentUser?.uid)
              //           .update({"user_fcmtoken": localFcmToken}).then((_) {
              //         print("success!");
              //       });
              //       Navigator.pushReplacement((context),
              //           MaterialPageRoute(builder: (context) => startUpPage()));
              //     } else {
              //       print("Login Failed");
              //       setState(() {
              //         isLoading = false;
              //       });
              //     }
              //   });
              // } else {
              //   print("Please fill form correctly")
              // }
              //                   },
              //               child: const Text('Login')),
              //         ),
              //       ),

              GestureDetector(
                onTap: () {
                  controller.loginUser();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Get.theme.colorPrimaryDark,
                      ),
                      alignment: Alignment.center,
                      child: Text("Login",
                          style: Get.theme.kNormalStyle
                              .copyWith(color: Colors.white))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
