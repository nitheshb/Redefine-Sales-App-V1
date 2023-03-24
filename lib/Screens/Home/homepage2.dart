import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/themes/themes.dart';

import '../../Utilities/snackbar.dart';
import '../Contact/contact_list_dialog.dart';
import '../Contact/contact_list_page.dart';
import '../Notification/notification_pages.dart';
import '../Profile/profile_page.dart';
import '../Search/search_task.dart';

class HomePage2 extends StatelessWidget {
  final storageReference =
      FirebaseStorage.instance.ref().child('images/image.jpg');

  ImagePicker picker = ImagePicker();

  XFile? image;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomePageController>(HomePageController());
    final controller1 = Get.put<ContactController>(ContactController());

    // TaskController controller1 = Get.put<TaskController>(TaskController());
    debugPrint("home called ${FirebaseAuth.instance.currentUser}");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: SizedBox(),
                pinned: true,
                expandedHeight: 200,
                elevation: 0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  expandedTitleScale: 1.2,
                  titlePadding: EdgeInsets.all(0),
                  centerTitle: true,
                  title: TabBar(
                      onTap: (value) => {
                            controller.tabIndex.value = value,
                          },
                      isScrollable: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      physics: const BouncingScrollPhysics(),
                      indicatorColor: Get.theme.colorPrimaryDark,
                      labelColor: Get.theme.colorPrimaryDark,
                      labelStyle: Get.theme.kTitleStyle,
                      unselectedLabelStyle: Get.theme.kNormalStyle,
                      unselectedLabelColor:
                          Get.theme.btnTextCol.withOpacity(0.2),
                      tabs: [
                        Tab(
                            icon: Row(
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.017),
                            ),
                            Obx(
                              () => tabTaskIndicator(
                                  context: context,
                                  taskNum: controller.numOfTodayTasks.value,
                                  index: 0,
                                  controller: controller),
                            )
                          ],
                        )),
                        Tab(
                          icon: Row(
                            children: [
                              Text(
                                'Upcoming',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.017),
                              ),
                              Obx(
                                () => tabTaskIndicator(
                                    context: context,
                                    taskNum:
                                        controller.numOfUpcomingTasks.value,
                                    index: 1,
                                    controller: controller),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          icon: Row(
                            children: [
                              Text(
                                'Created',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.017),
                              ),
                              Obx(
                                () => tabTaskIndicator(
                                    context: context,
                                    taskNum: controller.numOfCreatedTasks.value,
                                    index: 2,
                                    controller: controller),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  background: Container(
                    color: Colors.black,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: IconButton(
                            onPressed: () =>
                                {Get.to(() => const ProfilePage())},
                            icon: Hero(
                              tag: 'profile',
                              child: Material(
                                type: MaterialType.transparency,
                                child: CircleAvatar(
                                  backgroundColor: Get.theme.colorPrimaryDark,
                                  radius: 30,
                                  child: Icon(
                                    Icons.person,
                                    color: Get.theme.colorPrimary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.030,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: Text(
                                'Morning, ${FirebaseAuth.instance.currentUser!.displayName}',
                                style: Get.theme.kTitleStyle
                                    .copyWith(color: Get.theme.kBadgeColorBg),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 2, bottom: 20),
                              child: Obx(
                                () => Text(
                                  '${controller.donecount.value}/${controller.notdone.value + controller.donecount.value} Tasks pending',
                                  style: Get.theme.kSubTitle.copyWith(
                                      color: Get.theme.colorPrimaryDark
                                          .withOpacity(0.6)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IconButton(
                            onPressed: () => {
                              Get.to(() => const NotificationPage())
                              // basicDialog('title', 'message')
                            },
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                controller.streamToday(),
                controller.streamUpdates(),
                controller.streamCreated(),
              ]),
        ),
      ),
    );
  }

  Widget tabTaskIndicator(
      {required int taskNum,
      required BuildContext context,
      required int index,
      required HomePageController controller}) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: index == controller.tabIndex.value
              ? Get.theme.colorPrimaryDark
              : null,
          borderRadius: BorderRadius.circular(12),
          border: index != controller.tabIndex.value
              ? Border.all(width: 2.0, color: Get.theme.curveBG)
              : null,
        ),
        child: Text(
          '$taskNum',
          style: TextStyle(
              color: index == controller.tabIndex.value
                  ? Colors.white
                  : Color.fromARGB(255, 239, 243, 248),
              fontSize: MediaQuery.of(context).size.height * 0.017),
        ),
      ),
    );
  }
}
