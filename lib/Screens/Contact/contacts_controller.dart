import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';

class ContactController extends GetxController {
  var selectedIndex = 0.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final searchController = TextEditingController();
  final collection = FirebaseFirestore.instance.collection('users');

  TaskController taskController = Get.find();

  var deptFilterList = <String>[].obs;
  var filterValue = 'All'.obs;
  var filterByEmployeeValue = 'ZA'.obs;
  var searchResult = ''.obs;

  Future<void> getDeptFilterData() async {
    await collection
        .where('department', isNull: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        deptFilterList.add(doc['department'][0]);
      }
      deptFilterList.value = deptFilterList.toSet().toList();
      debugPrint('DPET LIST ${deptFilterList}');
    });
  }

  @override
  void onInit() {
    getDeptFilterData();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
