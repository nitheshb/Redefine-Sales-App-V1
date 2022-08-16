import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/themes/themes.dart';

Widget taskCheckBox(
    {required String task,
    required String createdOn,
    required int taskPriority,
    required int taskPriorityNum,
    required bool selected,
    required String assigner}) {
  return CheckboxListTile(
    contentPadding: const EdgeInsets.all(10),
    controlAffinity: ListTileControlAffinity.leading,
    checkboxShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    value: selected,
    checkColor: Get.theme.kBlueColor,
    activeColor: Get.theme.colorPrimary,
    shape: Border(
      bottom: BorderSide(
        color: Get.theme.btnTextCol.withOpacity(0.2),
        width: 2,
      ),
    ),
    secondary: Padding(
      padding: const EdgeInsets.only(top: 30, right: 10),
      child: CircleAvatar(
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
    ),
    onChanged: ((value) => {}),
    title: Text(
      task,
      style: Get.theme.kNormalStyle,
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        '$createdOn\n$assigner',
        style: Get.theme.kSubTitle
            .copyWith(color: Get.theme.btnTextCol.withOpacity(0.3)),
      ),
    ),
  );
}
