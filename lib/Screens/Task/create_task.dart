import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contact_list_page.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/themes/themes.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({Key? key, required this.isEditTask}) : super(key: key);
  final bool isEditTask;
  @override
  Widget build(BuildContext context) {
    TaskController controller = Get.put<TaskController>(TaskController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 32,
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
            ),
            sizeBox(20, 0),
            Text(
              isEditTask ? 'Edit Task' : 'Create Task',
              style: Get.theme.kNormalStyle
                  .copyWith(color: Get.theme.colorPrimaryDark),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'To',
                      style: Get.theme.kSubTitle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(const ContactListPage()),
                    child: Obx(
                      () => userAssignChip(
                          name: controller.assignedUserName.value),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.contacts_outlined),
                  )
                ],
              ),
            ),
            TextField(
              controller: controller.taskTitle,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.colorPrimaryDark)),
                hintText: 'Title',
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Due Date',
                            textAlign: TextAlign.start,
                            style: Get.theme.kNormalStyle.copyWith(
                              color: Get.theme.btnTextCol.withOpacity(0.5),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true, onChanged: (date) {
                              print(
                                  'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                            }, onConfirm: (date) {
                              controller.dateSelected = date;
                              controller.updateSelectedDate();
                            }, currentTime: DateTime.now());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.calendar_month_rounded,
                              color: Get.theme.btnTextCol.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => Text(
                          controller.selectedDateTime.value,
                        ),
                      ),
                    )),
                  ],
                ),
                // datedone != 1
                //     ?

                // : Text(selectedDateTime.toString()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    height: 50,
                    width: 1,
                    color: Get.theme.btnTextCol.withOpacity(0.3),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    onPressed: () => {
                      bottomSheetWidget(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizeBox(20, 0),
                              Text(
                                'Set Priority',
                                style: Get.theme.kTitleStyle,
                              ),
                              sizeBox(20, 0),
                              TextButton.icon(
                                onPressed: () => {
                                  controller.taskPriority.value = 'Basic',
                                  Get.back()
                                },
                                icon: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Get.theme.successColor,
                                ),
                                label: Text(
                                  'Basic',
                                  style: Get.theme.kTitleStyle
                                      .copyWith(color: Get.theme.btnTextCol),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () => {
                                  controller.taskPriority.value = 'Medium',
                                  Get.back()
                                },
                                icon: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Get.theme.kYellowColor,
                                ),
                                label: Text(
                                  'Medium',
                                  style: Get.theme.kTitleStyle
                                      .copyWith(color: Get.theme.btnTextCol),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () => {
                                  controller.taskPriority.value = 'High',
                                  Get.back()
                                },
                                icon: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Get.theme.kRedColor,
                                ),
                                label: Text(
                                  'High',
                                  style: Get.theme.kTitleStyle
                                      .copyWith(color: Get.theme.btnTextCol),
                                ),
                              ),
                            ],
                          ),
                          initialChild: 0.5)
                    },
                    icon: Obx(
                      () => CircleAvatar(
                        radius: 10,
                        backgroundColor:
                            controller.taskPriority.value == 'Basic'
                                ? Get.theme.successColor
                                : controller.taskPriority.value == 'Medium'
                                    ? Get.theme.kYellowColor
                                    : Get.theme.kRedColor,
                      ),
                    ),
                    label: Text(
                      'Priority',
                      style: Get.theme.kNormalStyle.copyWith(
                        color: Get.theme.btnTextCol.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Get.theme.btnTextCol.withOpacity(0.3),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              controller: controller.taskDescription,
              maxLines: 8,
              validator: (value) {
                if (value!.length < 4) {
                  return 'Enter at least 20 characters';
                } else {
                  return null;
                }
              },
              scrollPhysics: const BouncingScrollPhysics(),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  contentPadding: EdgeInsets.all(15)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        color: Get.theme.kBadgeColorBg,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.attach_file_rounded, color: Get.theme.kBadgeColor),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Get.theme.colorPrimaryDark),
                onPressed: () => {controller.createNewTask()},
                child: Text('Save',
                    style: Get.theme.kSubTitle.copyWith(color: Colors.white)))
          ],
        ),
      ),
    );
  }

  Widget userAssignChip({required String name}) {
    return ActionChip(
        elevation: 0,
        side: BorderSide(color: Get.theme.btnTextCol.withOpacity(0.1)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Get.theme.kBadgeColorBg,
        label: Text(
          name,
          style: Get.theme.kSubTitle.copyWith(color: Get.theme.kBadgeColor),
        ),
        onPressed: () => {
              Get.to(() => const ContactListPage()),
            });
  }
}
