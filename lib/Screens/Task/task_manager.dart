import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/themes/themes.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<TaskController>(TaskController());
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(
                  'Collect insurance documents from Mr.Rajesh Sales Plan for New Product',
                  style: Get.theme.kTitleStyle),
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
                        'Vivek Dhillon',
                        textAlign: TextAlign.start,
                        style: Get.theme.kSubTitle,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'High',
                            textAlign: TextAlign.start,
                            style: Get.theme.kSubTitle,
                          ),
                        ),
                        sizeBox(0, 10),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Get.theme.kRedColor,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'March 1, 2022  2:30 PM',
                        textAlign: TextAlign.start,
                        style: Get.theme.kSubTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(
                        'March 18, 2022',
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
