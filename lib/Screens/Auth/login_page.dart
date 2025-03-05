// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Auth/auth_controller.dart';
import 'package:redefineerp/Screens/Home/homepage.dart';
import 'package:redefineerp/Screens/OnBoarding/onboarding_page.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/ButtonCom.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/methods/methods.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  List<String> images = [
    'assets/images/mood_dairy_image.png',
    'assets/images/relax_image.png',
    'assets/images/welcome.png',
    'assets/images/mood_dairy_image.png'
  ];

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put<AuthController>(AuthController());
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
        
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                 color:  Color(0xFF0D0D0D),
                  child: SizedBox(
                     width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.400,
                                 child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Text(
                                "SALES TEAM ONLY",
                            
                                 style: TextStyle(
                            fontFamily: 'SpaceGrotesk', // Use the font family you declared
                               fontSize: 10, // Set font size to 24
                                  fontWeight: FontWeight.w700, // Set font weight to 700 (bold)
                                  color: Colors.white,
                                  letterSpacing: 0.956,
                          ),
                                
                              ),
                        Text(
                                "Tell us your login\ndetails.",
                            
                                 style: TextStyle(
                            fontFamily: 'SpaceGrotesk', // Use the font family you declared
                               fontSize: 24, // Set font size to 24
                                  fontWeight: FontWeight.w700, // Set font weight to 700 (bold)
                                  color: Colors.white,
                                  letterSpacing: 0.006,
                          ),
                                
                              ),
                      ],
                    ),
                  ),
                    // child: Stack(
                    //   children: images.asMap().entries.map((e) {
                    //     return Positioned(
                    //         top: 10,
                    //         bottom: 0,
                    //         left: 0,
                    //         right: 0,
                    //         child: Obx(() => AnimatedOpacity(
                    //             child: Image.asset(
                    //               e.value,
                    //               height:
                    //                   MediaQuery.of(context).size.height * 0.300,
                    //             ),
                    //             opacity:
                    //                 controller.activeIndex.value == e.key ? 1 : 0,
                    //             duration: Duration(seconds: 1))));
                    //   }).toList(),
                    // ),
                  ),
                ),
                sizeBox(20, 0),
          
                Container(
                     padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
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
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top:20, bottom:20),
                    child: Obx(
                      () => TextField(
                        maxLines: 1,
                        obscureText: controller.showPass.value,
                        controller: controller.password,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: '***********',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Get.theme.primary)),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
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
                                    color: Get.theme.primary,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                      SizedBox(height: 10),
                         Padding(
                           padding: const EdgeInsets.only(left:0.0),
                           child: Row(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               children: [
                                                Checkbox(
                            value: true,
                            onChanged: (value) {
                              // loginController.checkBox.value = value!;
                            },
                                                   ),
                                                 
                                                 Flexible(
                                                   child: Text(
                            "Allow to capture call & other activity logs ",
                            style: Theme.of(context).textTheme.labelMedium,
                                                   ),
                                                 ),
                                               ],
                                             ),
                         ),
                   SizedBox(height: 40),
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
          
                     Row(
                    children: [
                      ButtonCom(
                        text: "Agree & Continue",
                        icon: Icons.arrow_forward,
                        ontap: () {
                           controller.loginUser(context);
                        },
                      ),
                    ],
                  ),
                    ],
                  ),
                ),
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
