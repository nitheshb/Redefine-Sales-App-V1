import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Task/task_manager.dart';
import 'package:redefineerp/themes/themes.dart';

Widget taskCheckBox(
    {required String task,
    required String createdOn,
    required int taskPriority,
    required String due,
    required int taskPriorityNum,
    required VoidCallback onTap,
    required bool selected,
    required String assigner}) {
  return ListTile(
    contentPadding: const EdgeInsets.all(10),
    tileColor: selected ? Get.theme.curveBG : null,
    shape: Border(
      bottom: BorderSide(
        color: Get.theme.btnTextCol.withOpacity(0.2),
        width: 2,
      ),
    ),
    leading: Checkbox(
      value: selected,
      onChanged: (_) => {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      checkColor: Get.theme.successColor,
      activeColor: Get.theme.colorPrimary,
    ),
    trailing: Padding(
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
    onTap: onTap,
    title: Text(
      task,
      style: selected
          ? Get.theme.kNormalStyle.copyWith(
              decoration: TextDecoration.lineThrough,
              color: Get.theme.btnTextCol.withOpacity(0.3),
            )
          : Get.theme.kNormalStyle,
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
