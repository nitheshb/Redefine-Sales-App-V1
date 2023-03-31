// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Auth/auth_controller.dart';
import 'package:redefineerp/Screens/Home/homepage.dart';
import 'package:redefineerp/Screens/OnBoarding/onboarding_page.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/methods/methods.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  List<String> images = [
    'https://img.freepik.com/free-vector/sign-concept-illustration_114360-5267.jpg?w=740&t=st=1678967076~exp=1678967676~hmac=6bc4343ab731f79203f94d96c3474e55f0ac5d43707a2a1af5f23f06b3873fe0',
    'https://img.freepik.com/free-vector/sign-concept-illustration_114360-125.jpg?w=740&t=st=1678965558~exp=1678966158~hmac=4ed96c65c8618562138c6cbc311d2ccd46f856aa8cfe0f0aa2b94282ffcbc53c',
    'https://img.freepik.com/free-vector/social-media-is-killing-frienship-concept_23-2148315417.jpg?w=740&t=st=1678965602~exp=1678966202~hmac=f27129b457f9a6ef314fb82977e27093a3aad2731530b0a629da5d78bc1158ae',
    'https://img.freepik.com/free-vector/sign-concept-illustration_114360-5267.jpg?w=740&t=st=1678967076~exp=1678967676~hmac=6bc4343ab731f79203f94d96c3474e55f0ac5d43707a2a1af5f23f06b3873fe0'
  ];

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put<AuthController>(AuthController());
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.400,
                  child: Stack(
                    children: images.asMap().entries.map((e) {
                      return Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Obx(() => AnimatedOpacity(
                              child: Image.network(
                                e.value,
                                height:
                                    MediaQuery.of(context).size.height * 0.300,
                              ),
                              opacity:
                                  controller.activeIndex.value == e.key ? 1 : 0,
                              duration: Duration(seconds: 1))));
                    }).toList(),
                  ),
                ),
                sizeBox(20, 0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FxText.titleLarge(
          "Login",
          fontWeight: 700,
          // color: Get.theme.primary,

        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: controller.formKey,
                    child: TextFormField(
                      controller: controller.email,
                      autocorrect: false,
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
                                BorderSide(color: Get.theme.primary)),
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
                                  color:  Get.theme.primary,
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
                          color: Get.theme.primary,
                        ),
                        alignment: Alignment.center,
                        child: Text("Login",
                            style: Get.theme.kNormalStyle
                                .copyWith(color: Get.theme.onPrimary))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isDoublePress = false;
  Future<bool> onWillPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(false);
  }
}