import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/themes/themes.dart';

Widget headerBg({required String title,required String createdOn,required int taskPriority,required int taskPriorityNum}) {
  return Container(
    alignment: Alignment.centerLeft,
    color: Get.theme.kGreenLight,
    padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: Get.theme.kNormalStyle.copyWith(color: Colors.black)),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(createdOn,
            style: Get.theme.kSubTitle
                .copyWith(color: Get.theme.btnTextCol.withOpacity(0.3))),
      ),
      CircleAvatar(
        radius: 10,
        backgroundColor: taskPriority == 1
            ? Get.theme.kRedColor
            : taskPriority == 2
                ? Get.theme.kYellowColor
                : Get.theme.successColor,
        child: taskPriorityNum == 4
            ? const Icon(Icons.done_all_outlined, size: 10, color: Colors.white)
            : Text(
                '${taskPriority != 3 ? taskPriorityNum : ''}',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
      ),
    ]),
  );
}
