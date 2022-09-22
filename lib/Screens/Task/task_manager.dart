import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/themes/themes.dart';

class TaskManager extends StatelessWidget {
  TaskManager(
      {required this.task,
      required this.createdOn,
      required this.taskPriority,
      required this.selected,
      required this.assigner,
      required this.docId,
      required this.due,
      required this.status});
  final String task;
  final String createdOn;
  final String taskPriority;
  final bool selected;
  final String assigner;
  final String docId;
  final String status;
  final String due;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<TaskController>(TaskController());
    controller.setTaskType(status);
    debugPrint('DOC ID $docId');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: Obx(
          () => AppBar(
            elevation: 0,
            backgroundColor: controller.taskType.value != 'mark'
                ? Get.theme.kGreenLight
                : Colors.transparent,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => controller.taskType.value == 'close'
                      ? IconButton(
                          onPressed: () => {
                                Get.to(() => CreateTaskPage(isEditTask: true)),
                              },
                          icon: const Icon(
                            Icons.edit_rounded,
                            color: Colors.black,
                          ))
                      : sizeBox(0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(() => controller.taskType.value != 'mark'
                ? miniMessage(
                    'Marked as done, pending for review by the assigner')
                : sizeBox(0, 0)),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(task, style: Get.theme.kTitleStyle),
            ),
            sizeBox(20, 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.people_rounded,
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Assigner',
                              textAlign: TextAlign.start,
                              style: Get.theme.kSubTitle.copyWith(
                                color: Get.theme.btnTextCol.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Priority',
                              textAlign: TextAlign.start,
                              style: Get.theme.kSubTitle.copyWith(
                                color: Get.theme.btnTextCol.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Date Created',
                              textAlign: TextAlign.start,
                              style: Get.theme.kSubTitle.copyWith(
                                color: Get.theme.btnTextCol.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.event_note_outlined,
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Due Date',
                              textAlign: TextAlign.start,
                              style: Get.theme.kSubTitle.copyWith(
                                color: Get.theme.btnTextCol.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // sizeBox(0, 35),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        assigner,
                        textAlign: TextAlign.start,
                        style: Get.theme.kSubTitle,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            taskPriority,
                            textAlign: TextAlign.start,
                            style: Get.theme.kSubTitle,
                          ),
                        ),
                        sizeBox(0, 10),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: taskPriority == 'High'
                              ? Get.theme.kRedColor
                              : taskPriority == 'Medium'
                                  ? Get.theme.kYellowColor
                                  : Get.theme.successColor,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        createdOn,
                        textAlign: TextAlign.start,
                        style: Get.theme.kSubTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(
                        due,
                        textAlign: TextAlign.start,
                        style: Get.theme.kSubTitle,
                      ),
                    ),
                  ],
                ),
                sizeBox(0, 20),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(() => TextButton(
                style: TextButton.styleFrom(
                  primary: controller.taskType.value == 'reopen'
                      ? Colors.black
                      : Get.theme.colorPrimary,
                  backgroundColor: controller.taskType.value == 'mark'
                      ? Get.theme.successColor
                      : controller.taskType.value == 'reopen'
                          ? Get.theme.colorAccent
                          : Get.theme.colorPrimaryDark,
                ),
                onPressed: () => {
                  if (controller.taskType.value == 'mark')
                    {controller.taskType.value = 'reopen'}
                  else if (controller.taskType.value == 'reopen')
                    {controller.taskType.value = 'close'}
                  else
                    {controller.taskType.value = 'mark'},
                  debugPrint("TASKTYPE: ${controller.taskType.value}")
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  // ignore: unnecessary_string_interpolations
                  child: Text(
                      controller.taskType.value == 'mark'
                          ? 'Mark it as done'
                          : controller.taskType.value == 'reopen'
                              ? 'Re-open Task'
                              : 'Close Task',
                      style: Get.theme.kNormalStyle),
                ),
              )),
        ),
      ),
    );
  }
}
