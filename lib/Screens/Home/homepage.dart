import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/Search/search_task.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
import 'package:redefineerp/Utilities/basicdialog.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Utilities/snackbar.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:redefineerp/Widgets/datewidget.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:intl/intl.dart';

class HomePage extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    onPressed: () => {
                      snackBarMsg('Task Done!', enableMsgBtn: true),
                      // basicDialog('title', 'message')
                    },
                    icon: Icon(
                      Icons.filter_list_rounded,
                      color: Get.theme.btnTextCol,
                    ),
                  ),
                )
              ],
              elevation: 0,
              backgroundColor: Colors.white,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 35),
                    child: Text(
                      'Morning, Nitesh',
                      style: Get.theme.kTitleStyle
                          .copyWith(color: Get.theme.btnTextCol),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 2, bottom: 20),
                    child: Obx(
                      () => Text(
                        '${controller.donecount.value}/${controller.notdone.value + controller.donecount.value} Tasks pending',
                        style: Get.theme.kSubTitle
                            .copyWith(color: Get.theme.colorAccent),
                      ),
                    ),
                  ),
                ],
              ),
              bottom: TabBar(
                  onTap: (value) => {
                        controller.tabIndex.value = value,
                      },
                  isScrollable: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  physics: const BouncingScrollPhysics(),
                  indicatorColor: Colors.transparent,
                  labelColor: Get.theme.colorPrimaryDark,
                  labelStyle: Get.theme.kTabTextLg,
                  unselectedLabelStyle: Get.theme.kNormalStyle,
                  unselectedLabelColor: Get.theme.btnTextCol.withOpacity(0.2),
                  tabs: [
                    Tab(
                        icon: Row(
                      children: [
                        const Text(
                          'Today',
                        ),
                        tabTaskIndicator(
                            taskNum: 10, index: 0, controller: controller),
                      ],
                    )),
                    Tab(
                      icon: Row(
                        children: [
                          const Text(
                            'Upcoming',
                          ),
                          tabTaskIndicator(
                              taskNum: 2, index: 1, controller: controller),
                        ],
                      ),
                    ),
                    Tab(
                      icon: Row(
                        children: [
                          const Text(
                            'Created',
                          ),
                          tabTaskIndicator(
                              taskNum: 2, index: 2, controller: controller),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              taskSheetWidget(initialChild: 0.8),
            },
            backgroundColor: Get.theme.colorPrimaryDark,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                streamToday(),
                streamUpdates(),
                thirdTab(),
              ]),
          bottomNavigationBar: BottomAppBar(
            elevation: 20,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            // onTap: controller.bottomBarOnTap,
            // currentIndex: controller.bottomBarIndex.value,
            // selectedItemColor: Get.theme.colorPrimaryDark,
            // unselectedItemColor: Get.theme.btnTextCol.withOpacity(0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => {},
                    icon:
                        Icon(Icons.menu_rounded, color: Get.theme.btnTextCol)),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => {
                              // BasicDialog(
                              //     title: 'title',
                              //     message: 'message',
                              //     button1: 'button1',
                              //     tapFeatures: () => {}),
                              Get.to(SearchPage())
                            },
                        icon: Icon(Icons.search_outlined,
                            color: Get.theme.btnTextCol.withOpacity(0.3))),
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.notifications_outlined,
                          color: Get.theme.btnTextCol.withOpacity(0.3)),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget tabTaskIndicator(
      {required int taskNum,
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
          style: Get.theme.kSubTitle.copyWith(
            color: index == controller.tabIndex.value
                ? Colors.white
                : Get.theme.btnTextCol.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget streamToday() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('spark_assignedTasks')
            // .where("due_date",
            //     isEqualTo: "${DateTime.now().microsecondsSinceEpoch - } ")
            // .where("status", isEqualTo: "InProgress")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong! 😣..."),
            );
          } else if (snapshot.hasData) {
            print('no of todo is ${snapshot.data?.docs.length}');
            return Column(
              children: [
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            late QueryDocumentSnapshot<Object?>? taskData =
                                snapshot.data?.docs[index];
                            print("qwdqwdw ${taskData?.id}");
                            // print(
                            //     "date is ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
                            // print("due date is ${taskData!.get('due data')}");
                            // return Text("hello");
                            return taskCheckBox(
                                taskPriority: taskData!['priority'] == "Basic"
                                    ? 3
                                    : taskData['priority'] == "Medium"
                                        ? 2
                                        : taskData['priority'] == "High"
                                            ? 1
                                            : 4,
                                taskPriorityNum: taskData['priority'] == "Basic"
                                    ? 3
                                    : taskData['priority'] == "Medium"
                                        ? 2
                                        : taskData['priority'] == "High"
                                            ? 1
                                            : 4,
                                selected: false,
                                task: taskData["task_title"],
                                createdOn:
                                    'Created:  ${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on') * 1000))}',
                                assigner: 'Assigner: ${taskData['by_name']}');
                          }),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Text("Tasks Loading..."),
                  )
                ],
              ),
            );
          }
        });
  }
}

Widget streamUpdates() {
  FirebaseAuth _auth = FirebaseAuth.instance;

  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('spark_assignedTasks')
          // .where("due_date",
          //     isEqualTo: "${DateTime.now().microsecondsSinceEpoch - } ")
          .where("by_uid", isEqualTo: _auth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong! 😣..."),
          );
        } else if (snapshot.hasData) {
          // List<String>? dueDates;
          // for (int i = 0; i <= snapshot.data!.docs.length; i++) {
          //   late QueryDocumentSnapshot<Object?>? taskData =
          //       snapshot.data!.docs[i];
          //   dueDates?.add(DateFormat('yyyy-MM-dd')
          //       .format(DateTime.fromMillisecondsSinceEpoch(
          //           taskData.get('due_date') * 1000))
          //       .toString());
          //   debugPrint("DATES EXPIRY: ${dueDates?[i]}");
          // }
          // dueDates.sort(
          //   (a, b) {
          //     return DateTime.parse(a).compareTo(DateTime.parse(b));
          //   },
          // );
          // print('dueDates ${dueDates}');
          return Column(
            children: [
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          late QueryDocumentSnapshot<Object?>? taskData =
                              snapshot.data?.docs[index];
                          print("qwdqwdw ${taskData?.id}");

                          // print(
                          //     "date is ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
                          // print("due date is ${taskData!.get('due data')}");
                          // return Text("hello");
                          return Column(
                            children: [
                              DateWidget(
                                  ' ${DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(taskData!.get('due_date') * 1000))}'),
                              taskCheckBox(
                                  taskPriority: taskData!['priority'] == "Basic"
                                      ? 3
                                      : taskData['priority'] == "Medium"
                                          ? 2
                                          : taskData['priority'] == "High"
                                              ? 1
                                              : 4,
                                  taskPriorityNum:
                                      taskData['priority'] == "Basic"
                                          ? 3
                                          : taskData['priority'] == "Medium"
                                              ? 2
                                              : taskData['priority'] == "High"
                                                  ? 1
                                                  : 4,
                                  selected: false,
                                  task: taskData["task_title"],
                                  createdOn:
                                      'Created:  ${DateFormat('MMMM-dd, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on') * 1000))}',
                                  assigner: 'Assigner: ${taskData['by_name']}'),
                            ],
                          );
                        }),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              children: const [
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(height: 50),
                Center(
                  child: Text("Tasks Loading..."),
                )
              ],
            ),
          );
        }
      });
}

Widget firstTab() {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        taskCheckBox(
            taskPriority: 1,
            taskPriorityNum: 2,
            selected: false,
            task:
                'Collect insurance documents from Mr.Rajesh Sales Plan for New Product',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        taskCheckBox(
            taskPriority: 2,
            taskPriorityNum: 2,
            selected: false,
            task: 'Sales Plan for New Product',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 0,
            selected: false,
            task: 'Check Screens for Todo',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 0,
            selected: false,
            task: 'Check Screens for Todo',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 0,
            selected: false,
            task: 'Check Screens for Todo',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 0,
            selected: false,
            task: 'Check Screens for Todo',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
      ],
    ),
  );
}

Widget secondTab() {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        DateWidget('Tommorow'),
        taskCheckBox(
            taskPriority: 1,
            taskPriorityNum: 4,
            selected: true,
            task: 'Preparing the images that will be used in the email A',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        DateWidget('14 Aug'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 0,
            selected: false,
            task: 'Make sure the product is working',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        taskCheckBox(
            taskPriority: 1,
            taskPriorityNum: 4,
            selected: false,
            task: 'Writing a description for the blog post A',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 0,
            selected: false,
            task: 'Preparing the email structure',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        DateWidget('15 Aug'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 0,
            selected: false,
            task: 'Finding the winner of the test',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
      ],
    ),
  );
}

Widget thirdTab() {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        headerBg(
            title: 'Gif Design for page loading',
            createdOn: 'Created: 12 August | 11:00 PM',
            taskPriority: 1,
            taskPriorityNum: 2),
        miniMessage('Marked as done, pending for review'),
        DateWidget('Due Tommorow'),
        taskCheckBox(
            taskPriority: 2,
            taskPriorityNum: 4,
            selected: false,
            task: 'Completing the post in the new product page',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assigner: Mr. Tejesh'),
        DateWidget('14 Aug'),
        taskCheckBox(
            taskPriority: 1,
            taskPriorityNum: 2,
            selected: false,
            task: 'Going throuh bug report list',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assignee: Mr. Anshu'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 4,
            selected: false,
            task: 'Updating & Testing the colour selection',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assignee: Mr. Tejesh'),
        DateWidget('15 Aug'),
        taskCheckBox(
            taskPriority: 3,
            taskPriorityNum: 0,
            selected: false,
            task: 'Presentation Regarding',
            createdOn: 'Created: 12 August | 11:00 PM',
            assigner: 'Assignee: Mr. Tejesh'),
      ],
    ),
  );
}
