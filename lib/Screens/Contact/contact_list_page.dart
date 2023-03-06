import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/contact_card.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/themes/themes.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ContactController>(ContactController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: TextField(
              controller: controller.searchController,
              // onChanged: (v) {
              //   controller.searchResult.value = v;
              // },
              onSubmitted: (v) {
                controller.searchResult.value = v;
              },
              decoration: InputDecoration(
                  prefix: sizeBox(20, 20),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {
                      controller.searchResult.value =
                          controller.searchController.text;
                    },
                  ),
                  hintText: 'Search',
                  hintStyle: Get.theme.kNormalStyle
                      .copyWith(color: Get.theme.kBadgeColor),
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => Row(
                  children: [
                    _contactFilterChip(0,
                        title: 'All',
                        controller: controller,
                        onTap: () => {
                              controller.selectedIndex.value = 0,
                              controller.filterValue.value = 'All',
                            }),
                    ...controller.deptFilterList.map((e) {
                      int id = controller.deptFilterList.indexOf(e) + 1;
                      if (e == 'a' || e == 'c' || e == 'f' || e == 'p') {
                        return sizeBox(0, 0);
                      }
                      return _contactFilterChip(id,
                          title: e,
                          controller: controller,
                          onTap: () => {
                                controller.selectedIndex.value = id,
                                controller.filterValue.value = e,
                              });
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(),
                      onPressed: () => {
                        if (controller.filterByEmployeeValue.value == 'ZA')
                          {controller.filterByEmployeeValue.value = 'AZ'}
                        else
                          controller.filterByEmployeeValue.value = 'ZA',
                      },
                      icon: Icon(
                        Icons.sort_by_alpha_outlined,
                        size: 16,
                        color: Get.theme.btnTextCol.withOpacity(0.3),
                      ),
                      label: Text('Employee Name',
                          style: Get.theme.kSubTitle.copyWith(
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          )),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(),
                      onPressed: () => {},
                      icon: Icon(
                        Icons.swap_vert_rounded,
                        size: 16,
                        color: Get.theme.btnTextCol.withOpacity(0.3),
                      ),
                      label: Text('Pending Task',
                          style: Get.theme.kSubTitle.copyWith(
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 2, width: Get.size.width, color: Get.theme.curveBG),
            _streamUsersContacts(controller),
          ],
        ),
      ),
    );
  }

  Widget _streamUsersContacts(ContactController controller) {
    return Obx(() => StreamBuilder<QuerySnapshot>(
        stream: DbQuery.instanace.getEmployees(
            sortByDeptName: controller.filterValue.value,
            sortEmployees: controller.filterByEmployeeValue.value,
            sortByName: controller.searchResult.value),
        builder: (con, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong! 😣..."),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                primary: false,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (c, i) {
                  QueryDocumentSnapshot<Object?>? taskData =
                      snapshot.data?.docs[i];
                  return ContactCard(
                      title: '${taskData!["name"]}',
                      jobTitle: '${taskData["roles"][0]}',
                      onTap: () => {
                            controller.taskController.assignedUserName.value =
                                taskData["name"],
                            controller.taskController.assignedUserDepartment
                                .value = taskData["department"][0],
                            controller.taskController.assignedUserEmail.value =
                                taskData["email"],
                            controller.taskController.assignedUserUid.value =
                                taskData["uid"],
                            controller.taskController.assignedUserFcmToken
                                .value = taskData["user_fcmtoken"],
                            Get.back()
                          });
                });
          } else {
            return Center(
              child: Column(
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Text("Users Loading..."),
                  )
                ],
              ),
            );
          }
        }));
  }

  Widget _contactFilterChip(int index,
      {required String title,
      required ContactController controller,
      required VoidCallback onTap}) {
    return Padding(
      padding: index == 0
          ? const EdgeInsets.only(left: 20, right: 5, top: 8, bottom: 8)
          : const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Obx(
        () => ActionChip(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            shape: index != controller.selectedIndex.value
                ? const StadiumBorder(side: BorderSide(color: Colors.black26))
                : null,
            backgroundColor: index == controller.selectedIndex.value
                ? Get.theme.colorPrimaryDark
                : Colors.white,
            label: Text(
              title,
              style: Get.theme.kSubTitle.copyWith(
                color: controller.selectedIndex.value == index
                    ? Colors.white
                    : Get.theme.kBadgeColor,
              ),
            ),
            onPressed: onTap),
      ),
    );
  }
}
