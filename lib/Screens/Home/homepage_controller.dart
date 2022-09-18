import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  int tempDate = 0;
  int dateIndex = 0;
  List<int> dueDateList = [];

  Future<void> fetchdata() async {
    await FirebaseFirestore.instance
        .collection('spark_assignedTasks')
        .where("to_email", isEqualTo: currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['status'] == "Done") {
          donecount.value = donecount.value + 1;
        } else if (doc['status'] == "InProgress") {
          notdone.value = notdone.value + 1;
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

  @override
  void onInit() async {
    await fetchdata();
    super.onInit();
  }
}
