import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:redefineerp/Utilities/snackbar.dart';
import 'package:redefineerp/themes/themes.dart';

import '../../helpers/supabae_help.dart';

class TaskController extends GetxController {
  var taskType = 'mark'.obs;
  DateTime dateSelected = DateTime.now();
  var selectedDateTime = ''.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var taskDocId = ''.obs;
  var assignToId = ''.obs;
  var assignToName = ''.obs;

  RxBool isPlaying = false.obs;

  // below are old ones
  var assignedUserName = 'Assign someone'.obs;
  var assignedUserDepartment = ''.obs;
  var assignedUserUid = ''.obs;
  var assignedUserEmail = ''.obs;
  var assignedUserFcmToken = ''.obs;
  var taskPriority = 'Basic'.obs;

  var participantsList = [].obs;
  var attachmentsA = [].obs;

  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController commentLine = TextEditingController();

  GlobalKey<FormState> taskKey = GlobalKey<FormState>();
  final _collection =
      FirebaseFirestore.instance.collection('spark_assignedTasks');

  String? validateTaskTitle(value) {
    if (value == '') {
      return 'Please enter task title';
    } else {
      return null;
    }
  }

  void addComments(id, type, txt) async {
    print('new vlu is ${commentLine.text}');
    await _collection.doc(id).update({
      "comments": FieldValue.arrayUnion([
        {"typ": type, "txt": commentLine.text}
      ])
    });
    commentLine.text = "";
  }

  void closeTask(id, type, txt) async {
    print('new vlu is ${commentLine.text}');
    await _collection.doc(id).update({
     "status": "Completed",
     "completedOn":  DateTime.now().millisecondsSinceEpoch,
     "comp_by" : auth.currentUser?.uid,
     "comments": FieldValue.arrayUnion([
        {"typ": type, "txt": "Task marked as completed by ${auth.currentUser?.displayName}"}
      ])
    });
    commentLine.text = "";
  }

   void reopenedOnTask(id, type, txt) async {
    await _collection.doc(id).update({
     "status": "InProgress",
     "completedOn":  0,
     "reopendOn": DateTime.now().millisecondsSinceEpoch,
     "reOpen_by" : auth.currentUser?.uid,
     "comments": FieldValue.arrayUnion([
        {"typ": type, "txt": "Task re-opened by ${auth.currentUser?.displayName}"}
      ])
    });
    commentLine.text = "";
  }

  void createNewTask() {
    // Get.reset();
    // Get.delete<TaskController>();

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
        })
        .then((value) => {
              print("Task Created ${value}"),
              Get.back(),
              snackBarMsg('Task Created!', enableMsgBtn: false),
              sendPushMessage('Task Assigned for you:', taskTitle.text,
                  assignedUserFcmToken.value),
              DbSupa.instance.saveNotification(
                  assignedUserUid.value, "Task Assigned for you", value.id),
              taskTitle.clear(),
              taskDescription.clear(),
              dateinput.clear(),
              assignedUserName = 'Assign someone'.obs,
            })
        .catchError((error) => {
              print("Failed to create task: $error"),
              snackBarMsg('Failed to create task: $error', enableMsgBtn: false),
            });
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

  @override
  void onInit() {
    updateSelectedDate();

    super.onInit();
  }

  void updateSelectedDate() {
    selectedDateTime.value =
        DateFormat('dd-MM-yyyy kk:mm').format(dateSelected);
  }

  void updateAssignTimeDb(docId) {
    _collection
        .doc(docId)
        .update({"due_date": dateSelected.millisecondsSinceEpoch});
  }

  void setTaskType(String task) {
    if (task == 'Done') {
      taskType.value = 'reopen';
    } else if (task == 'InProgress') {
      taskType.value = 'close';
    } else
      taskType.value == 'mark';
  }

  void setTaskId(task) {
    taskDocId.value = task;
  }

  void setAssignDetails(docId, uid, name) {
    print('value is docId: ${taskDocId}');
    if (taskDocId == docId) {
      assignToId.value = uid;
      assignToName.value = name;
    }
  }

  @override
  void onClose() {
    taskTitle.dispose();
    taskDescription.dispose();
    super.onClose();
  }
}
