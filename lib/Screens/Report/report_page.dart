import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Report/team_stats.dart';
import 'package:redefineerp/Screens/Report/my_stats.dart';
import 'package:redefineerp/Utilities/basicdialog.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:flutter_svg/svg.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  var isTeamstats = true;

  flipAction() {
    setState(() {
      isTeamstats = !isTeamstats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isTeamstats ? TeamStats(flipAction) : MyStasts(flipAction),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
        ),
        Row(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      color: Color.fromRGBO(0, 0, 0, 0.33),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Log out',
                      style: Get.theme.kNormalStyle.copyWith(
                        color: const Color.fromRGBO(0, 0, 0, 0.33),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.34,
            ),
            GestureDetector(
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset('assets/images/privacy_policy.svg'),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    'Privacy Policy',
                    style: Get.theme.kNormalStyle.copyWith(
                      color: const Color.fromRGBO(0, 0, 0, 0.33),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Center(
          child: Text(
            'App Version 0.0.0.0',
            style: Get.theme.kNormalStyle.copyWith(
              color: const Color.fromRGBO(0, 0, 0, 0.33),
            ),
          ),
        ),
      ],
    );
  }
}
