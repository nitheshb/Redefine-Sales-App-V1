import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redefineerp/Screens/Task/task_manager.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:intl/intl.dart';
import 'package:redefineerp/Widgets/datewidget.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:redefineerp/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePageController extends GetxController {
  var tabIndex = 0.obs;
  var bottomBarIndex = 0.obs;
  var dummy = true.obs;

  var donecount = 0.obs;
  var index = 0.obs;
  var notdone = 0.obs;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  var userName = ''.obs;
  var userEmail = ''.obs;

  var numOfTodayTasks = 0.obs;
  var numOfUpcomingTasks = 0.obs;
  var numOfCreatedTasks = 0.obs;

  int tempDueDate = 0;
  int dueDateIndex = 0;

  int tempCreatedDate = 0;
  int createdDateIndex = 0;
  List<int> dueDateList = [];
  List<int> createDateList = [];

  var streamTodayWidget = sizeBox(0, 0).obs;
  var streamUpcomingWidget = sizeBox(0, 0).obs;
  var streamCreatedWidget = sizeBox(0, 0).obs;

  Future<void> fetchdata() async {
    await FirebaseFirestore.instance
        .collection('spark_assignedTasks')
        .where("by_email", isEqualTo: currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        debugPrint("DOCS FOR TO_EM: $doc");
        if (doc['status'] == "Done") {
          donecount.value = donecount.value + 1;
          debugPrint("DONE COUNT== ${donecount.value}");
        } else if (doc['status'] == "InProgress") {
          notdone.value = notdone.value + 1;
          debugPrint("Not done COUNT== ${notdone.value}");
        }
      }
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      final doc = querySnapshot.docs[0];
      userName.value = doc['name'];
      userEmail.value = doc['email'];
    });
  }

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
            // numOfTodayTasks.value = snapshot.data!.docs.length;
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
                                due:
                                    "${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date')))}",
                                task: taskData["task_title"],
                                
                                createdOn:
                                    'Created:  ${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on')))}',
                                assigner: 'Assigner: ${taskData['by_name']}',
                                onTap: () => {
                                      Get.to(() => TaskManager(
                                            task: taskData["task_title"],
                                            status: taskData['status'],
                                            docId: taskData.reference.id,
                                            due:
                                                "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date')))}"
                                                    .toString(),
                                            createdOn:
                                                "${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on')))}"
                                                    .toString(),
                                            taskPriority: taskData['priority'],
                                            selected: false,
                                            assigner: taskData['by_name'],
                                          ))
                                    });
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

  Widget streamUpdates() {
    FirebaseAuth _auth = FirebaseAuth.instance;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('spark_assignedTasks')
            // .where("due_date",
            //     isEqualTo: "${DateTime.now().microsecondsSinceEpoch - } ")
            .where("by_uid", isEqualTo: _auth.currentUser!.uid)
            .orderBy("due_date")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong! 😣..."),
            );
          } else if (snapshot.hasData) {
            // numOfUpcomingTasks.value = snapshot.data!.docs.length;
            List<int> dueDates = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              late QueryDocumentSnapshot<Object?>? taskData =
                  snapshot.data!.docs[i];
              dueDates.add(taskData.get('due_date'));
            }
            dueDateList = dueDates.toSet().toList();
            tempDueDate = dueDateList[0];
            List<QueryDocumentSnapshot<Object?>>? taskData =
                snapshot.data?.docs;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      ...taskData!.map((e) => Column(
                            children: [
                              dateBoxForUpcomingSection(
                                  dateL: e.get('due_date')),
                              taskCheckBox(
                                  due:
                                      "${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(e.get('due_date')))}",
                                  taskPriority: e['priority'] == "Basic"
                                      ? 3
                                      : e['priority'] == "Medium"
                                          ? 2
                                          : e['priority'] == "High"
                                              ? 1
                                              : 4,
                                  taskPriorityNum: e['priority'] == "Basic"
                                      ? 3
                                      : e['priority'] == "Medium"
                                          ? 2
                                          : e['priority'] == "High"
                                              ? 1
                                              : 4,
                                  selected: false,
                                  task: e["task_title"],
                                  createdOn:
                                      'Created:  ${DateFormat('MMMM-dd, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(e.get('created_on')))}',
                                  assigner: 'Assigner: ${e['by_name']}',
                                  onTap: () => {
                                        Get.to(() => TaskManager(
                                              task: e["task_title"],
                                            status: e['status'],
                                            docId: e.reference.id,
                                              due:
                                                  "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(e.get('due_date')))}"
                                                      .toString(),
                                              createdOn:
                                                  "${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(e.get('created_on')))}"
                                                      .toString(),
                                              taskPriority: e['priority'],
                                              selected: false,
                                              assigner: e['by_name'],
                                            ))
                                      }),
                            ],
                          )),
                    ],
                  )),
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

  Widget dateBoxForUpcomingSection({required int dateL}) {
    if (dateL == tempDueDate) {
      if (dueDateIndex < dueDateList.length - 1) {
        dueDateIndex += 1;
        if (dueDateIndex == dueDateList.length - 1) {
          dueDateIndex = 0;
          tempDueDate = dueDateList[0];
        }
        debugPrint(
            "DATES DATA INDEX: ${dueDateIndex} DATE LENGTH: ${dueDateList.length}");
      }
      tempDueDate = dueDateList[dueDateIndex];
      return DateWidget(
          ' ${DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(dateL))}');
    } else {
      return sizeBox(0, 0);
    }
  }

  Widget streamCreated() {
    FirebaseAuth _auth = FirebaseAuth.instance;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('spark_assignedTasks')
            // .where("due_date",
            //     isEqualTo: "${DateTime.now().microsecondsSinceEpoch - } ")
            .where("by_uid", isEqualTo: _auth.currentUser!.uid)
            .orderBy("created_on")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong! 😣..."),
            );
          } else if (snapshot.hasData) {
            // numOfCreatedTasks.value = snapshot.data!.docs.length;
            List<int> createdDates = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              late QueryDocumentSnapshot<Object?>? taskData =
                  snapshot.data!.docs[i];
              createdDates.add(taskData.get('created_on'));
            }
            createDateList = createdDates.toSet().toList();
            tempCreatedDate = createDateList[0];
            List<QueryDocumentSnapshot<Object?>>? taskData =
                snapshot.data?.docs;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      reviewBanner(),
                      ...taskData!.map((e) => Column(
                            children: [
                              dateBoxForCreatedSection(
                                  dateL: e.get('created_on')),
                              taskCheckBox(
                                  due:
                                      "${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(e.get('due_date')))}",
                                  taskPriority: e['priority'] == "Basic"
                                      ? 3
                                      : e['priority'] == "Medium"
                                          ? 2
                                          : e['priority'] == "High"
                                              ? 1
                                              : 4,
                                  taskPriorityNum: e['priority'] == "Basic"
                                      ? 3
                                      : e['priority'] == "Medium"
                                          ? 2
                                          : e['priority'] == "High"
                                              ? 1
                                              : 4,
                                  selected: false,
                                  task: e["task_title"],
                                  createdOn:
                                      'Created:  ${DateFormat('MMMM-dd, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(e.get('created_on')))}',
                                  assigner: 'Assigner: ${e['by_name']}',
                                  onTap: () => {
                                        Get.to(() => TaskManager(
                                              task: e["task_title"],
                                            status: e['status'],
                                            docId: e.reference.id,
                                              due:
                                                  "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(e.get('due_date')))}"
                                                      .toString(),
                                              createdOn:
                                                  "${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(e.get('created_on')))}"
                                                      .toString(),
                                              taskPriority: e['priority'],
                                              selected: false,
                                              assigner: e['by_name'],
                                            ))
                                      }),
                            ],
                          )),
                    ],
                  )),
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

  Widget dateBoxForCreatedSection({required int dateL}) {
    if (dateL == tempCreatedDate) {
      if (createdDateIndex < createDateList.length - 1) {
        createdDateIndex += 1;
        if (createdDateIndex == createDateList.length - 1) {
          createdDateIndex = 0;
          tempCreatedDate = createDateList[0];
        }
        debugPrint(
            "DATES DATA INDEX: ${dueDateIndex} DATE LENGTH: ${createDateList.length}");
      }
      tempCreatedDate = createDateList[createdDateIndex];
      return DateWidget(
          ' ${DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(dateL))}');
    } else {
      return sizeBox(0, 0);
    }
  }

  // void initializeTabs() {
  //   streamTodayWidget.value = streamToday();
  //   streamUpcomingWidget.value = streamUpdates();
  //   streamCreatedWidget.value = streamCreated();
  // }

  Widget reviewBanner() {
    return Container(
      height: Get.size.height * 0.3,
      margin: EdgeInsets.only(bottom: 10),

      // width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('spark_assignedTasks')
              // .where("due_date",
              //     isEqualTo: "${DateTime.now().microsecondsSinceEpoch - } ")
              .where("by_uid", isEqualTo: currentUser!.uid)
              .where("status", isEqualTo: "Done")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong! 😣..."),
              );
            } else if (snapshot.hasData) {
              print('no of todo is ${snapshot.data?.docs.length}');
              return MediaQuery.removePadding(
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
                            headerBg(
                              title: taskData!['task_title'],
                              createdOn:
                                  "${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on')))}",
                              taskPriority: taskData['priority'] == "Basic"
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
                            ),
                            miniMessage('Marked as done, pending for review'),
                          ],
                        );
                      }),
                ),
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
                      child: Text("Reviewing Tasks..."),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

  @override
  void onInit() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        debugPrint('A new initialmessage event was published!');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification?.title,
          notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // ignore: unnecessary_null_comparison
      if (message != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {}
      }
    });
    getToken();
    await fetchdata();
    super.onInit();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      print('FCM TOKEN: $token');
    });
  }
}
