import 'package:cloud_firestore/cloud_firestore.dart';

class DbQuery {
  static DbQuery get instanace => DbQuery();

  getLoggedInUserDetails(uid) async {
    var LoggedInUserDetails = await FirebaseFirestore.instance
        .collection('users')
        .where("uid", isEqualTo: uid)
        .get();
    print("uid is $uid");
    if (LoggedInUserDetails.docs.isNotEmpty) {
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

    if (usersList.docs.isNotEmpty) {
      return usersList.docs.toList();
    } else {
      return null;
    }
  }

  getEmployees(
      {required String sortByDeptName,
      String sortEmployees = 'ZA',
      required String sortByName}) {
    print('sel dept ${sortByDeptName}');
    if (sortByName.isEmpty) {
      if (sortByDeptName == "All") {
        return FirebaseFirestore.instance
            .collection('users')
            .where('roles', isNull: false)
            // .where('orgId', isEqualTo: "maahomes")
            // .orderBy('name', descending: sortEmployees == 'AZ' ? false : true)
            // .where("department", arrayContainsAny: [deptName.toString().toLowerCase()])
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('users')
            .where("department",
                arrayContainsAny: [sortByDeptName.toString().toLowerCase()])
            .where('orgId', isEqualTo: "maahomes")
            // .orderBy('name', descending: sortEmployees == 'AZ' ? false : true)
            .snapshots();
      }
    } else {
      return FirebaseFirestore.instance
          .collection("users")
          .where('name', isGreaterThanOrEqualTo: sortByName)
          .where('name', isLessThanOrEqualTo: '$sortByName~')
          .snapshots();
    }
  }

  getTasksBySignedInUser(SignedInUserEmail) async {
    QuerySnapshot userTaskList = await FirebaseFirestore.instance
        .collection('assignedTasks')
        .where('Assigned by(email)', isEqualTo: SignedInUserEmail)
        .get();

    if (userTaskList.docs.isNotEmpty) {
      return userTaskList.docs.toList();
    } else {
      return null;
    }
  }
}
