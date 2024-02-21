
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/OnBoarding/onboard_controller.dart';
import 'package:redefineerp/Screens/Widgets/buttons.dart';
import 'package:redefineerp/themes/themes.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});

  final List<String> _images = [
    'assets/images/onboard.png',
    'assets/images/onboardsecond.png',
    'assets/images/onboardthrid.png'
  ];
  final List<String> title = [
    'Collaborate',
    'Track progress',
    'Share documents'
  ];

  final List<String> caption = [
    'Work together with your Team members in Real-time.',
    'Monitor task completion, identify potential roadblocks, and make real-time adjustments.',
    'Share contracts, blueprints, and so much more.'
  ];

  OnboardController _onboardController = Get.put(OnboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: appLightTheme.backgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.080,
          ),
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _onboardController.pageController,
                  onPageChanged: _onboardController.onPageChnaged,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: Stack(
                        children: [
                          Positioned(
                              child: Image.asset("assets/images/bglines.png")),
                          Positioned(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.170,
                              left: index == 2
                                  ? MediaQuery.of(context).size.width * 0.150
                                  : index == 1
                                      ? MediaQuery.of(context).size.width * 0.50
                                      : MediaQuery.of(context).size.width *
                                          -0.140,
                              child: Image.asset("assets/images/bgsquare.png")),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                title[index],
                                style: headline1,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.050,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.020),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.370,
                                  child: Image.asset(
                                    _images[index],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.10),
                                child: Text(
                                  caption[index],
                                  style: headline6,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.010,
                  left: MediaQuery.of(context).size.height * 0.220,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height * 0.030,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.020,
                                width:
                                    MediaQuery.of(context).size.width * 0.020,
                                decoration: BoxDecoration(
                                  color: _onboardController.currentPage.value ==
                                          index
                                      ? const Color(0xFF4093FF)
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.020,
                            ),
                          ],
                        );
                      },
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.030,
          ),
           GestureDetector(
            onTap: () {
              Get.to(() => LoginPage());
            },
            child: Buttons(
              height: MediaQuery.of(context).size.height * 0.070,
              width: MediaQuery.of(context).size.width * 0.430,
              radius: 60,
              color: appLightTheme.primaryColorDark,
              child: Center(
                child: Text(
                  "Sign In",
                  style: buttontext,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.020,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => LoginPage());
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Have an account ?',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.4,
                          color: Color(0xFF202325))),
                  TextSpan(
                      text: ' Log in',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.4,
                          color: appLightTheme.primaryColor))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
