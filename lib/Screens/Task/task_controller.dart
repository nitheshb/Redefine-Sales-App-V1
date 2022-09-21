import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController {
  var taskType = 'mark'.obs;
  DateTime dateSelected = DateTime.now();
  var selectedDateTime = ''.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var assignedUserName = 'Assign someone'.obs;
  var assignedUserDepartment = ''.obs;
  var assignedUserUid = ''.obs;
  var assignedUserEmail = ''.obs;
  var taskPriority = 'Basic'.obs;

  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  final _collection =
      FirebaseFirestore.instance.collection('spark_assignedTasks');

  void createNewTask() {
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
          'to_email': assignedUserEmail.value,
          'dept': assignedUserDepartment.value,
          'status': "InProgress",
        })
        .then((value) => print("Task Created ${value}"))
        .catchError((error) => print("Failed to create task: $error"));
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

  @override
  void onClose() {
    taskTitle.dispose();
    taskDescription.dispose();
    super.onClose();
  }
}
