import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/themes/themes.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            sizeBox(20, 0),
            Text(
              'Create Task',
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
                  Row(
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
                          onPressed: () => {}),
                    ],
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
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  contentPadding: EdgeInsets.all(15)),
            ),
          ],
        ),
      ],
    );
  }
}

Widget taskFooter() {
  return Container(
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
  );
}
