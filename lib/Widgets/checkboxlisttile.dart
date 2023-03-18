import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Task/task_manager.dart';
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
  return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 4, 16, 4),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0XFFF9F6FF),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // '$createdOn\n$assigner',
                      '$due',
                      style: Get.theme.kSubTitle.copyWith(
                          color: Get.theme.btnTextCol.withOpacity(0.3)),
                    ),
                    // Text('${taskPriority}')
                    Text(
                      'Urgent',
                      style: TextStyle(
                          color: Color.fromARGB(255, 64, 138, 68),
                          fontSize: 10),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 8),
                child: Row(
                  children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(top:3.0),
                    //       child: InkWell(
                    //           onTap: () =>
                    //               {

                    //                 },
                    //           child: Icon(
                    //             Icons.check_circle_outline_outlined,
                    //             color: Get.theme.kLightGrayColor,
                    //             size: 20,
                    //           ),
                    //         ),
                    //     ),
                    //  const SizedBox(width: 6,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      child: Text(
                        task,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: selected
                            ? Get.theme.kNormalStyle.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Get.theme.btnTextCol.withOpacity(0.3),
                              )
                            : Get.theme.kPrimaryTxtStyle,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              participants
            ],
          ),
        ),
      ),
    ),
  );

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      contentPadding: const EdgeInsets.all(0),
      tileColor: selected ? Get.theme.curveBG : null,
      shape: Border(
        bottom: BorderSide(
          color: Get.theme.btnTextCol.withOpacity(0.2),
          width: 1,
        ),
      ),
      // leading: Checkbox(
      //   value: selected,
      //   onChanged: (_) => {},
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //   checkColor: Get.theme.successColor,
      //   activeColor: Get.theme.colorPrimary,
      // ),

      // trailing: Padding(
      //   padding: const EdgeInsets.only(top: 30, right: 10),
      //   child: CircleAvatar(
      //     radius: 10,
      //     backgroundColor: taskPriority == 1
      //         ? Get.theme.kRedColor
      //         : taskPriority == 2
      //             ? Get.theme.kYellowColor
      //             : Get.theme.successColor,
      //     child: taskPriorityNum == 4
      //         ? const Icon(Icons.done_all_outlined, size: 10, color: Colors.white)
      //         : Text(
      //             '${taskPriority != 3 ? taskPriorityNum : ''}',
      //             style: GoogleFonts.inter(
      //               fontSize: 10,
      //               color: Colors.white,
      //             ),
      //           ),
      //   ),
      // ),
      onTap: onTap,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: InkWell(
              onTap: () => {},
              child: Icon(
                Icons.check_circle_outline_outlined,
                color: Get.theme.kLightGrayColor,
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            task,
            style: selected
                ? Get.theme.kNormalStyle.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: Get.theme.btnTextCol.withOpacity(0.3),
                  )
                : Get.theme.kNormalStyle,
          ),
        ],
      ),
      // subtitle: Padding(
      //   padding: const EdgeInsets.only(top: 10),
      //   child: Text(
      //     '$createdOn\n$assigner',
      //     style: Get.theme.kSubTitle
      //         .copyWith(color: Get.theme.btnTextCol.withOpacity(0.3)),
      //   ),
      // ),
    ),
  );
}