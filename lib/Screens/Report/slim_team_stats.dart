import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redefineerp/Screens/Notification/notification_pages.dart';
import 'package:redefineerp/Screens/Profile/profile_page.dart';
import 'package:redefineerp/themes/constant.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/progress_bar.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';

class SlimTeamStats extends StatefulWidget {
  VoidCallback flipAction;
  SlimTeamStats(this.flipAction);
  @override
  State<SlimTeamStats> createState() => _SlimTeamStatsState();
}

class _SlimTeamStatsState extends State<SlimTeamStats> {
  var dayCompleted = 12;
  var dayTotal = 19;
  var weekCompleted = 38;
  var weekTotal = 57;
  var monthCompleted = 369;
  var monthTotal = 392;
  var isDay = true;
  var isWeek = false;
  var isMonth = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6,8,8),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                // colors: [
                //   Color.fromRGBO(69, 115, 201, 1),
                //   Color.fromRGBO(69, 115, 201, 1),
                // ],
        
                colors: [Color(0xffffffff), Color(0xffffffff), Color(0xffffffff),]
              ),
            ),
            child: Column(
              children: [
                
                status(),
              ],
            ),
          ),
        ),
      ],
    );
  }


   Widget status() {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top:2.0),
        child: Row(
          children: [
            Expanded(
              child: FxContainer.bordered(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.titleMedium(
                      'Todo',
                      fontWeight: 700,
                    ),
                    FxSpacing.height(8),
                    FxText.titleSmall(
                      dayTotal.toString(),
                      fontWeight: 700,
                    ),
                    FxSpacing.height(12),
                    FxText.bodySmall(
                      'Progress',
                      fontWeight: 600,
                      muted: true,
                    ),
                    FxSpacing.height(6),
                    FxProgressBar(
                      width: 140,
                      inactiveColor: Constant.softColors.green.color,
                      activeColor: Constant.softColors.green.onColor,
                      height: 4,
                      progress: 0.4,
                    ),
                  ],
                ),
              ),
            ),
           
            FxSpacing.width(16),
            Expanded(
              child: FxContainer.bordered(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.titleMedium(
                      'Created by me',
                      fontWeight: 700,
                    ),
                    FxSpacing.height(8),
                    FxText.titleSmall(
                      (dayTotal - dayCompleted).toString(),
                      fontWeight: 700,
                    ),
                    FxSpacing.height(12),
                    FxText.bodySmall(
                      'Progress',
                      fontWeight: 600,
                      muted: true,
                    ),
                    FxSpacing.height(6),
                    FxProgressBar(
                      width: 140,
                      inactiveColor: Get.theme.secondaryContainer,
                      activeColor: Get.theme.onSecondaryContainer,
                      height: 4,
                      progress: 0.7,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
