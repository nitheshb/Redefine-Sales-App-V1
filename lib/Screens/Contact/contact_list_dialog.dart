import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/contact_card.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/themes/themes.dart';

import '../../Widgets/minimsg.dart';

class ContactListDialogPage extends StatelessWidget {
  const ContactListDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ContactController>(ContactController());

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() => Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Container(
                    //             width: double.infinity,
                    //             height: 40,
                    //             decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.black38),
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20)),
                    //             child: Center(
                    //   child: TextField(
                    //     controller: controller.searchController,
                    //     // onChanged: (v) {
                    //     //   controller.searchResult.value = v;
                    //     // },
                    //     onSubmitted: (v) {
                    //       controller.searchResult.value = v;
                    //     },
                    //     decoration: InputDecoration(
                    //         prefix: sizeBox(20, 20),
                    //         suffixIcon: IconButton(
                    //           icon: const Icon(Icons.search_rounded),
                    //           onPressed: () {
                    //             controller.searchResult.value =
                    //                 controller.searchController.text;
                    //           },
                    //         ),
                    //         hintText: 'Search',
                    //         hintStyle: Get.theme.kNormalStyle
                    //             .copyWith(color: Get.theme.kBadgeColor),
                    //         border: InputBorder.none),
                    //   ),
                    //             ),
                    //           ),
                    // ),

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
                              if (e == 'a' ||
                                  e == 'c' ||
                                  e == 'f' ||
                                  e == 'p') {
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
                                if (controller.filterByEmployeeValue.value ==
                                    'ZA')
                                  {
                                    controller.filterByEmployeeValue.value =
                                        'AZ'
                                  }
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
                                    color:
                                        Get.theme.btnTextCol.withOpacity(0.3),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Obx(
                      () => miniMessage(
                          '${controller.participants.value.length}   participants Selected'),
                    ),

                    Container(
                        height: 2,
                        width: Get.size.width,
                        color: Get.theme.curveBG),
                    _streamUsersContacts(controller),
                  ],
                ),
              ),

              if (controller.participants.isNotEmpty)
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.020,
                  left: MediaQuery.of(context).size.height * 0.130,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.060,
                      width: MediaQuery.of(context).size.width * 0.250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      child: Center(
                        child: Text(
                          "OK",
                          style: Get.theme.kTitleStyle
                              .copyWith(color: Get.theme.kBadgeColorBg),
                        ),
                      ),
                    ),
                  ),
                )

              Container(
                  height: 2, width: Get.size.width, color: Get.theme.curveBG),
              _streamUsersContacts(controller),

            ],
          )),

      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[

      //   ])
    );
  }

  Widget _streamUsersContacts(ContactController controller) {
    var tempFollwers = [];
    var myTemp = [];

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
                  var uid = "";
                  try {
                    uid = taskData!["uid"];
                  } catch (e) {
                    uid = "";
                  }
                  return _contactCardChip(uid,
                      title: taskData!["name"],
                      role: taskData["roles"][0],
                      controller: controller,
                      onTap: () => {
                            controller.addParticipant(
                                taskData['name'], taskData["uid"]),
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

  Widget _contactCardChip(index,
      {required String title,
      required String role,
      required ContactController controller,
      required VoidCallback onTap}) {
    print(
        'myValue  ${controller.participants.any((participant) => participant['uid'] == index)}');

    return Obx(() => Padding(
            padding: index == 0
                ? const EdgeInsets.only(left: 20, right: 5, top: 8, bottom: 8)
                : const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Container(
              color: controller.participants
                      .any((participant) => participant['uid'] == index)
                  ? Get.theme.colorPrimaryDark
                  : Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Get.theme.kContactIconColor,
                  size: 32,
                ),
                title: Text(title,
                    style: Get.theme.kNormalStyle
                        .copyWith(color: Get.theme.kContactIconColor)),
                subtitle: Text(role,
                    style: Get.theme.kSubTitle.copyWith(
                        color: Get.theme.btnTextCol.withOpacity(0.2))),
                trailing: Icon(Icons.arrow_forward_ios_rounded,
                    color: Get.theme.btnTextCol.withOpacity(0.2)),
                onTap: onTap,
              ),
            ))
        // child: Obx(
        //   () => ActionChip(
        //       elevation: 0,
        //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        //       shape: index != controller.selectedIndex.value
        //           ? const StadiumBorder(side: BorderSide(color: Colors.black26))
        //           : null,
        //       backgroundColor: controller.participants.any((participant) => participant['uid'] == index)
        //           ? Get.theme.colorPrimaryDark
        //           : Colors.white,
        //       label: Text(
        //         title,
        //         style: Get.theme.kSubTitle.copyWith(
        //           color: controller.selectedIndex.value == index
        //               ? Colors.white
        //               : Get.theme.kBadgeColor,
        //         ),
        //       ),
        //       onPressed: onTap),
        // ),
        );
  }

  Widget contact_card(controller, title, jobTitle, uid, onTap) {
    return Container(
      color: (controller.participants
              .any((participant) => participant['uid'] == uid))
          ? Colors.yellow
          : Colors.white,
      child: ListTile(
        leading: Icon(
          Icons.account_circle,
          color: Get.theme.kContactIconColor,
          size: 32,
        ),
        title: Text(title,
            style: Get.theme.kNormalStyle
                .copyWith(color: Get.theme.kContactIconColor)),
        subtitle: Text(jobTitle,
            style: Get.theme.kSubTitle
                .copyWith(color: Get.theme.btnTextCol.withOpacity(0.2))),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            color: Get.theme.btnTextCol.withOpacity(0.2)),
        onTap: onTap,
      ),
    );
  }

}
