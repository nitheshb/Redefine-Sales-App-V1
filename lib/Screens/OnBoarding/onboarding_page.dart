import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/themes/themes.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Easy Time Management',
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first',
                  textAlign: TextAlign.center,
                  style: Get.theme.kNormalStyle
                      .copyWith(color: Get.theme.btnTextCol.withOpacity(0.5)),
                ),
                getStartedBtn(context),
              ],
            ),
            image: SvgPicture.asset('assets/images/Page1.svg'),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              contentMargin: EdgeInsets.all(37),
              imageAlignment: Alignment.bottomCenter,
            ),
          ),
          PageViewModel(
            title: 'Increase Work Effectiveness',
            image: SvgPicture.asset('assets/images/Page2.svg'),
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Time management and the determination of more important tasks will give your job statistics better and always improve',
                  textAlign: TextAlign.center,
                  style: Get.theme.kNormalStyle
                      .copyWith(color: Get.theme.btnTextCol.withOpacity(0.5)),
                ),
                getStartedBtn(context),
              ],
            ),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              contentMargin: EdgeInsets.all(37),
              imageAlignment: Alignment.bottomCenter,
            ),
          ),
          PageViewModel(
            title: 'Reminder Notification',
            image: SvgPicture.asset('assets/images/Page3.svg'),
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'The advantage of this application is that it also provides reminders for you so you don\'t forget to keep doing your assignments well and according to the time you have set',
                  textAlign: TextAlign.center,
                  style: Get.theme.kNormalStyle
                      .copyWith(color: Get.theme.btnTextCol.withOpacity(0.5)),
                ),
                getStartedBtn(context),
              ],
            ),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              contentMargin: EdgeInsets.all(37),
              imageAlignment: Alignment.bottomCenter,
            ),
          ),
        ],
        // globalHeader: Row(
        //   children: [
        //     Container(
        //       child: TextButton(
        //         child: Text('skip'),
        //         onPressed: () {},
        //       ),
        //     ),
        //     Container(),
        //   ],
        // ),
        dotsDecorator: DotsDecorator(activeColor: Get.theme.colorPrimaryDark),
        showNextButton: false,
        showDoneButton: false,
        showSkipButton: true,
        onSkip: () => {saveOpenInfo(), Get.off(() => LoginPage())},
        skip: Text(
          "Skip",
          style: Get.theme.kNormalStyle
              .copyWith(color: Get.theme.colorPrimaryDark),
        ),
        skipOrBackFlex: 1,
        dotsFlex: 3,
        nextFlex: 1,
        controlsPosition: const Position(left: 0, right: 0, top: 5),
      ),
    );
  }

  Widget getStartedBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Get.theme.colorPrimaryDark,
              fixedSize: Size(MediaQuery.of(context).size.width, 20)),
          onPressed: () => {saveOpenInfo(), Get.off(() => LoginPage())},
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
}
