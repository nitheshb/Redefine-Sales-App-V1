import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contact_list_page.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/themes/themes.dart';

class CreateTaskPage extends StatelessWidget {
  CreateTaskPage({Key? key, required this.isEditTask, this.scrollController})
      : super(key: key);
  final bool isEditTask;
  ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    TaskController controller=Get.put<TaskController>(TaskController());
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.sheetColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          controller: scrollController,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ActionChip(
                              elevation: 0,
                              side: BorderSide(
                                  color: Get.theme.btnTextCol.withOpacity(0.1)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Get.theme.kBadgeColorBg,
                              label: Text(
                                'Vivek Dhillon',
                                style: Get.theme.kSubTitle
                                    .copyWith(color: Get.theme.kBadgeColor),
                              ),
                              onPressed: () => {
                                    Get.to(const ContactListPage()),
                                  }),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.contacts_outlined),
                    )
                  ],
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: Get.theme.btnTextCol.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      height: 50,
                      width: 1,
                      color: Get.theme.btnTextCol.withOpacity(0.3),
                    ),
                  ),
                  Text(
                    'Priority',
                    style: Get.theme.kNormalStyle.copyWith(
                      color: Get.theme.btnTextCol.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Get.theme.kRedColor,
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Get.theme.btnTextCol.withOpacity(0.3),
              ),
              const TextField(
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
                scrollPhysics: BouncingScrollPhysics(),
                decoration: InputDecoration(
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
                  onPressed: () => {},
                  child: Text('Save',
                      style: Get.theme.kSubTitle.copyWith(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
