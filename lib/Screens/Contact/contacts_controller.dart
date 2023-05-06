import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';

class ContactController extends GetxController {

final homeController = Get.put<HomePageController>(HomePageController());

  var selectedIndex = 0.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final searchController = TextEditingController();
  final collection = FirebaseFirestore.instance.collection('users');

  // HomePageController homeController = Get.find();

  var deptFilterList = <String>[].obs;
  var filterValue = 'All'.obs;
  var filterByEmployeeValue = 'ZA'.obs;
  var searchResult = ''.obs;

  RxList participantsList = [].obs;

  var participants = <Map<String, dynamic>>[].obs;

  void addParticipant(String username, String userId) {
    // Check if the participant already exists in the list
    bool participantExists =
        participants.any((participant) => participant['uid'] == userId);

    print('exists ${participantExists} ${userId}');
    print(participantsList);
    if (participantExists) {
      removeParticipant(userId);
      return;
    }

    Map<String, dynamic> newParticipant = {'name': username, 'uid': userId};
    participants.add(newParticipant);
    homeController.participantsANew.value = participants;
  }

  // Remove a participant from the list by their userId
  void removeParticipant(String userId) {
    participants.removeWhere((participant) => participant['uid'] == userId);
    homeController.participantsANew.value = participants;

  }

  Future<void> getDeptFilterData() async {
    await collection
        .where('department', isNull: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        deptFilterList.add(doc['department'][0]);
      }
      deptFilterList.value = deptFilterList.toSet().toList();
      print('DPET LIST ${deptFilterList}');
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
