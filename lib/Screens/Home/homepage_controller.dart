import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redefineerp/Screens/Home/Generator.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Screens/Task/task_manager.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Utilities/snackbar.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:intl/intl.dart';
import 'package:redefineerp/Widgets/datewidget.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:redefineerp/main.dart';
import 'package:redefineerp/themes/themes.dart';

class HomePageController extends GetxController {

  @override
  void onInit() async {
        await fetchdata();
    getToken();

    updateSelectedDate();

        FirebaseAuth.instance.authStateChanges().listen((User? user) {
       currentUser = user;
    });
      print('my user is yo yo ${currentUser}');
    super.onInit();
  }

  
  @override
  void onReady() async{
    print('yo yo');
    // Get called after widget is rendered on the screen
      await fetchdata();
    super.onReady();
  }
  
  // TaskController taskController = Get.find();
    final _collection =
      FirebaseFirestore.instance.collection('spark_assignedTasks');
  final FirebaseAuth auth = FirebaseAuth.instance;


  var tabIndex = 0.obs;
  var bottomBarIndex = 0.obs;
  var dummy = true.obs;

  var donecount = 0.obs;
  var index = 0.obs;
  var notdone = 0.obs;
  var url = "".obs;



  var userName = ''.obs;
  var userEmail = ''.obs;

  var numOfTodayTasks = 0.obs;
  var numOfUpcomingTasks = 0.obs;
  var numOfCreatedTasks = 0.obs;

  var currentUser;

  int tempDueDate = 0;
  int dueDateIndex = 0;

  int tempCreatedDate = 0;
  int createdDateIndex = 0;
  List<int> dueDateList = [];
  List<int> createDateList = [];

  var streamTodayWidget = sizeBox(0, 0).obs;
  var streamUpcomingWidget = sizeBox(0, 0).obs;
  var streamCreatedWidget = sizeBox(0, 0).obs;

  // 
    TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController commentLine = TextEditingController();

   GlobalKey<FormState> taskKey = GlobalKey<FormState>();
  var taskType = 'mark'.obs;
  DateTime dateSelected = DateTime.now();
  var selectedDateTime = ''.obs;

    var assignedUserName = 'Assign someone'.obs;
  var assignedUserDepartment = ''.obs;
  var assignedUserUid = ''.obs;
  var assignedUserEmail = ''.obs;
  var assignedUserFcmToken = ''.obs;
  var taskPriority = 'Basic'.obs;

     var participantsANew = [].obs;
     var attachmentsA = [].obs;
     
       get http => null;
  String? validateTaskTitle(value) {
    if (value == '') {
      return 'Please enter task title';
    } else {
      return null;
    }
  }
void updateSelectedDate() {
    selectedDateTime.value =
        DateFormat('dd-MM-yyyy kk:mm').format(dateSelected);
  }

   checkTaskValidation() {
    final validator = taskKey.currentState!.validate();

    if (!validator) {
      return;
    } else {
      if (assignedUserName == 'Assign someone') {
        Get.snackbar(
            colorText: Get.theme.colorPrimaryDark,
            backgroundColor: Get.theme.overlayColor,
            margin: const EdgeInsets.all(10),
            duration: Duration(seconds: 3),
            "",
            "Please Assign task to someone",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        createNewTask();
        print(assignedUserName);
      }
    }
  }

  
  void createNewTask() {
  
    // Get.reset();
    // Get.delete<TaskController>();
    print('hello ${participantsANew}');

   

    _collection
        .add({
          'task_title': taskTitle.text,
          'task_desc': taskDescription.text,
          'created_on': DateTime.now().millisecondsSinceEpoch,
          'due_date': dateSelected.millisecondsSinceEpoch,
          'by_email': auth.currentUser?.email,
          'by_name': auth.currentUser?.displayName,
          'by_uid': auth.currentUser?.uid,
          'to_name': assignedUserName.value,
          'to_uid': assignedUserUid.value,
          'priority': taskPriority.value,
          'atttachmentsA': attachmentsA.value,
          'to_email': assignedUserEmail.value,
          'dept': assignedUserDepartment.value,
          'status': "InProgress",
          'particpantsA' : participantsANew.value,
        })
        .then((value) => {
              print("Task Created ${value}"),
              
              Get.back(),
              snackBarMsg('Task Created!', enableMsgBtn: false),
               sendPushMessage('Task Assigned for you:', taskTitle.text,
                  assignedUserFcmToken.value),
                taskTitle.clear(),
                taskDescription.clear(),
                dateinput.clear(),
                assignedUserName = 'Assign someone'.obs,
              
             
            })
        .catchError((error) =>{
          print("Failed to create task: $error"),
          snackBarMsg('Failed to create task: $error', enableMsgBtn: false),
        });
  }
    void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAu40SEOU:APA91bGOizFLorP1WdQSJSDotrKCpdCOPsJNa_N350JSpc07MeBdhl7vM8XJqBnX2lU0paRww1jILVxaArXjEyjDBpqbX--oR9Mo7NZwJY7TxaUy6OdWtrPHc0DO0EdEXBp3fCX4boZB',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'TASK_ASSIGN_NOTIF',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }
  Future<void> fetchdata() async {

    print('am i here ${currentUser?.email}');
    await FirebaseFirestore.instance
        .collection('spark_assignedTasks')
           .where("due_date",
                isLessThanOrEqualTo: DateTime.now().microsecondsSinceEpoch)
            .where("status", isEqualTo: "InProgress")
            .where("to_uid", isEqualTo: currentUser?.uid)
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
      print('check it ${doc.data()}');
      userName.value = doc['name'];
      userEmail.value = doc['email'];
    });
  }

  Widget streamToday() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('spark_assignedTasks')
            .where("due_date",
                isLessThanOrEqualTo: DateTime.now().microsecondsSinceEpoch)
            .where("status", isEqualTo: "InProgress")
            .where("to_uid", isEqualTo: currentUser?.uid)
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

                            // taskController.setAssignDetails(taskData?.id, taskData!['to_uid'], taskData['to_name']);
                            // print(
                            //     "date is ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
                            // print("due date is ${taskData!.get('due data')}");
                            // return Text("hello");
                            return taskCheckBox(context,
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
                                    '${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on')))}',
                                assigner: 'Assigner: ${taskData['by_name']}',
                                participants: Row(
                                  children: [
                                    // Generator.buildOverlaysProfile(
                                    //     images: [
                                    //       'assets/images/icon.jpg',
                                    //       'assets/images/icon.jpg',
                                    //     ],
                                    //     enabledOverlayBorder: true,
                                    //     overlayBorderColor: Color(0xfff0f0f0),
                                    //     overlayBorderThickness: 1.7,
                                    //     leftFraction: 0.72,
                                    //     size: 26),

                                    
                                    SizedBox(
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Get.theme.colorPrimaryDark,
                                          radius: 14,
                                          child: Text(
                                              '${taskData['by_name'].substring(0, 2)}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      " 0 comments",
                                      style: Get.theme.kPrimaryTxtStyle,
                                    ),
                                    Text(
                                      " . 0 Files",
                                      style: Get.theme.kPrimaryTxtStyle,
                                    )
                                  ],
                                ), onTap: () {
                              var comments = [];
                              try {
                                comments = taskData['comments'];
                              } catch (e) {
                                comments = [];
                              }
                              ;
                              Get.to(() => TaskManager(
                                    task: taskData["task_title"],
                                    status: taskData['status'],
                                    docId: taskData.reference.id,
                                    comments: comments,
                                    // url: taskData['url'],
                                    due:
                                        "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date')))}"
                                            .toString(),
                                    createdOn:
                                        "${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on')))}"
                                            .toString(),
                                    taskPriority: taskData['priority'],
                                    selected: false,
                                    assigner: taskData['by_name'],
                                  ));
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
            .where("status", isEqualTo: "InProgress")
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
                              taskCheckBox(context,
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
                                  participants: Row(
                                    children: [
                                      Generator.buildOverlaysProfile(
                                          images: [
                                            'assets/images/icon.jpg',
                                            'assets/images/icon.jpg',
                                          ],
                                          enabledOverlayBorder: true,
                                          overlayBorderColor: Color(0xfff0f0f0),
                                          overlayBorderThickness: 1.7,
                                          leftFraction: 0.72,
                                          size: 26),
                                      SizedBox(
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Get.theme.colorPrimaryDark,
                                            radius: 14,
                                            child: Text(
                                                '${e.get('by_name').substring(0, 2)}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        " 0 comments",
                                        style: Get.theme.kPrimaryTxtStyle,
                                      ),
                                      Text(
                                        " . 0 Files",
                                        style: Get.theme.kPrimaryTxtStyle,
                                      )
                                    ],
                                  ), onTap: () {
                                var comments = [];
                                try {
                                  comments = e['comments'];
                                } catch (e) {
                                  comments = [];
                                }
                                ;
                                Get.to(() => TaskManager(
                                      task: e["task_title"],
                                      status: e['status'],
                                      docId: e.reference.id,
                                      comments: comments,
                                      due:
                                          "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(e.get('due_date')))}"
                                              .toString(),
                                      createdOn:
                                          "${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(e.get('created_on')))}"
                                              .toString(),
                                      taskPriority: e['priority'],
                                      selected: false,
                                      assigner: e['by_name'],
                                    ));
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
                              taskCheckBox(context,
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
                                  participants: Row(
                                    children: [
                                      Generator.buildOverlaysProfile(
                                          images: [
                                            'assets/images/icon.jpg',
                                            'assets/images/icon.jpg',
                                          ],
                                          enabledOverlayBorder: true,
                                          overlayBorderColor: Color(0xfff0f0f0),
                                          overlayBorderThickness: 1.7,
                                          leftFraction: 0.72,
                                          size: 26),
                                      SizedBox(
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Get.theme.colorPrimaryDark,
                                            radius: 14,
                                            child: Text(
                                                '${e['by_name'].substring(0, 2)}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        " 0 comments",
                                        style: Get.theme.kPrimaryTxtStyle,
                                      ),
                                      Text(
                                        " . 0 Files",
                                        style: Get.theme.kPrimaryTxtStyle,
                                      )
                                    ],
                                  ), onTap: () {
                                var comments = [];
                                try {
                                  comments = e['comments'];
                                } catch (e) {
                                  comments = [];
                                }
                                ;
                                Get.to(() => TaskManager(
                                      task: e["task_title"],
                                      status: e['status'],
                                      docId: e.reference.id,
                                      comments: comments,
                                      due:
                                          "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(e.get('due_date')))}"
                                              .toString(),
                                      createdOn:
                                          "${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(e.get('created_on')))}"
                                              .toString(),
                                      taskPriority: e['priority'],
                                      selected: false,
                                      assigner: e['by_name'],
                                    ));
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
  void onClose() {
    debugPrint("on close called - home");
    super.onClose();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      print('FCM TOKEN: $token');
    });
  }
}
