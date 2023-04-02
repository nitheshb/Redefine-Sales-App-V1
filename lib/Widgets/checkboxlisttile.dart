import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Task/task_manager.dart';
import 'package:redefineerp/themes/constant.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';

final controller_Contacts = Get.put<ContactController>(ContactController());

Widget taskCheckBox(BuildContext context,
    {required String task,
    required String createdOn,
    required Widget participants,
    required int taskPriority,
    required String due,
    required int taskPriorityNum,
    required VoidCallback onTap,
    required bool selected,
    required String assigner}) {
  return InkWell(onTap: onTap, child: ListTaskCard(task, due, participants));
}

Widget ListTaskCard(task, due, participants) {
  return FxContainer(
    // group2Q6P (0:87)
    margin: EdgeInsets.fromLTRB(8, 0, 8, 2),
    padding: EdgeInsets.fromLTRB(16, 12, 14, 10),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FxText.bodySmall(
              task,
              fontWeight: 700,
              fontSize: 14,
            ),
//               Text(
//   // DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date'))),
//  due,
//   // Jiffy.parse(DateTime.fromMillisecondsSinceEpoch(due).fromNow(),
//   textAlign:  TextAlign.right,
//   style:  GoogleFonts.workSans (
//     fontSize:  12,
//     fontWeight:  FontWeight.w400,
//     // height:  1.1730000178,
//     letterSpacing:  -0.06,
//     color:  Color(0xff7b7b7b),
//   ),
// ),
          ],
        ),
        FxSpacing.height(4),
        Container(
          // autogroup8pgfaqR (9JUKHtyXruTzzxrxZ38PgF)
          margin: EdgeInsets.fromLTRB(0, 0, 0.22, 0),
          width: double.infinity,
          height: 28.78,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // autogroupjrfzsJj (9JUKtxoSL6UPnmppD7JRFZ)
                padding: EdgeInsets.fromLTRB(0, 4.5, 109, 5.78),
                height: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.comment_sharp,
                      size: 10,
                      color: Get.theme.btnTextCol.withOpacity(0.4),
                    ),
                    FxSpacing.width(4),
                    FxText.bodySmall(
                      "0",
                      muted: true,
                      fontWeight: 600,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.attach_file_rounded,
                      size: 10,
                      color: Get.theme.btnTextCol.withOpacity(0.4),
                    ),
                    FxSpacing.width(4),
                    FxText.bodySmall(
                      "0",
                      muted: true,
                      fontWeight: 600,
                    ),
                    FxSpacing.width(4),
                    Icon(
                      Icons.people,
                      size: 11,
                      color: Get.theme.btnTextCol.withOpacity(0.4),
                    ),
                    FxSpacing.width(4),
                    FxText.bodySmall(
                      "0",
                      muted: true,
                      fontWeight: 600,
                    ),
                    SizedBox(width: 6),
                  ],
                ),
              ),
              FxContainer(
                borderRadiusAll: Constant.containerRadius.xs,
                padding: FxSpacing.fromLTRB(8, 6, 0, 0),
                child: FxText.bodySmall(
                  due,
                  fontSize: 10,
                  fontWeight: 600,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
