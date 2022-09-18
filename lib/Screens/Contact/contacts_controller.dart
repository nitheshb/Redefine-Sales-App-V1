import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';

class ContactController extends GetxController {
  var selectedIndex = 0.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final collection = FirebaseFirestore.instance.collection('users');

  TaskController taskController = Get.find();
}
