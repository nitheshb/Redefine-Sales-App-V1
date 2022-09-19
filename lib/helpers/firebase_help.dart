import 'package:cloud_firestore/cloud_firestore.dart';

class DbQuery {
  static DbQuery get instanace => DbQuery();

  getLoggedInUserDetails(uid) async {
    var LoggedInUserDetails = await FirebaseFirestore.instance
        .collection('users')
        .where("uid", isEqualTo: uid)
        .get();
    print("uid is $uid");
    if (!LoggedInUserDetails.docs.isEmpty) {
      return LoggedInUserDetails.docs.toList();
    } else {
      return null;
    }
  }

  getUsersByDept(deptName) async {
    QuerySnapshot usersList = await FirebaseFirestore.instance
        .collection('users')
        .where('department', isEqualTo: deptName)
        .get();

    if (!usersList.docs.isEmpty) {
      return usersList.docs.toList();
    } else {
      return null;
    }
  }

  getEmployeesByDept(deptName, {String sortEmployees = 'ZA'}) {
    print('sel dept ${deptName}');
    if (deptName == "All") {
      return FirebaseFirestore.instance
          .collection('users')
          .where('roles', isNull: false)
          // .orderBy('name', descending: sortEmployees == 'AZ' ? false : true)
          // .where("department", arrayContainsAny: [deptName.toString().toLowerCase()])
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('users').where("department",
          arrayContainsAny: [deptName.toString().toLowerCase()])
          // .orderBy('name', descending: sortEmployees == 'AZ' ? false : true)
          .snapshots();
    }
  }

  getTasksBySignedInUser(SignedInUserEmail) async {
    QuerySnapshot userTaskList = await FirebaseFirestore.instance
        .collection('assignedTasks')
        .where('Assigned by(email)', isEqualTo: SignedInUserEmail)
        .get();

    if (!userTaskList.docs.isEmpty) {
      return userTaskList.docs.toList();
    } else {
      return null;
    }
  }
}
