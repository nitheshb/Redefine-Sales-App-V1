import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/OnBoarding/onboard_controller.dart';
import 'package:redefineerp/themes/themes.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({Key? key}) : super(key: key);

  OnboardController _onboardController = Get.put(OnboardController());

  final List<String> _images = [
    'assets/images/mood_dairy_image.png',
    'assets/images/relax_image.png',
    'assets/images/welcome.png'
  ];
  final List<String> title = [
    'Welcome',
    'Welcome',
    'Welcome',
  ];

  final List<String> caption = [
    'Work together with your Team members in Real-time.',
    'Monitor task completion, identify potential roadblocks, and make real-time adjustments.',
    'Share contracts, blueprints, and so much more.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf4eae2),
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.010,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Obx(
                      () => _onboardController.currentPage.value == 0
                          ? SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.058,
                            )
                          : IconButton(
                              onPressed: () {
                                _onboardController.pageController.previousPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInQuad);
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _onboardController.pageController,
                      onPageChanged: _onboardController.onPageChnaged,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.050,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title[index],
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.070),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                caption[index],
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.040),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              height:
                                  MediaQuery.of(context).size.height * 0.360,
                              child: Image.asset(
                                _images[index],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.44),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.030,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.020,
                              width: MediaQuery.of(context).size.width * 0.020,
                              decoration: BoxDecoration(
                                color: _onboardController.currentPage.value ==
                                        index
                                    ? Color(0xFF0e1e2d)
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.020,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Obx(
            () => _onboardController.currentPage.value == 2
                ? InkWell(
                    onTap: () =>
                        {saveOpenInfo(), Get.offAll(() => LoginPage())},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: getStartedBtn(context),

                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.060,
                        width: MediaQuery.of(context).size.width * 0.60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFF0e1e2d),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.060),
                          child: Row(
                            children: [
                              Text(
                                'Get Started',
                                style: Get.theme.kNormalStyle
                                    .copyWith(color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _onboardController.pageController.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInQuad);
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.0350,
                        backgroundColor: Color(0xFF0e1e2d),
                        child: const Center(
                          child: Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.020,
          ),
        ],
      )),
    );
  }
}

Widget getStartedBtn(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Get.theme.colorPrimaryDark,
            fixedSize: Size(MediaQuery.of(context).size.width, 20)),
        onPressed: () => {saveOpenInfo(), Get.offAll(() => LoginPage())},
        child: Text(
          'Get Started',
          style: Get.theme.kNormalStyle.copyWith(color: Colors.white),
        )),
  );
}

void saveOpenInfo() {
  if (GetStorage().read('opened') ?? true) {
    GetStorage().write('opened', false);
  }
  debugPrint('Opened value: ${GetStorage().read('opened')}');
}
