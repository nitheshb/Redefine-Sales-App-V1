import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:redefineerp/Utilities/snackbar.dart';

class TaskController extends GetxController {
  var taskType = 'mark'.obs;
  DateTime dateSelected = DateTime.now();
  var selectedDateTime = ''.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

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
  final _collection =
      FirebaseFirestore.instance.collection('spark_assignedTasks');

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
              snackBarMsg('Task Done!', enableMsgBtn: true),
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

  @override
  void onInit() {
    updateSelectedDate();
    super.onInit();
  }

  void updateSelectedDate() {
    selectedDateTime.value =
        DateFormat('dd-MM-yyyy kk:mm').format(dateSelected);
  }

  void setTaskType(String task) {
    if (task == 'Done') {
      taskType.value = 'reopen';
    } else if (task == 'InProgress') {
      taskType.value = 'close';
    } else
      taskType.value == 'mark';
  }

  @override
  void onClose() {
    taskTitle.dispose();
    taskDescription.dispose();
    super.onClose();
  }
}
