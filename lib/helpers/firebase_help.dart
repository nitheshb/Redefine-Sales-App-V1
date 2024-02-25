import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart' show StreamGroup, StreamZip;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

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


  getLeadbyId1(orgId, uid) async {


                  
    var LoggedInUserDetails = await FirebaseFirestore.instance
        .collection("${orgId}_leads")
        .where("uid", isEqualTo: uid)
        .get();
   
    if (LoggedInUserDetails.docs.isNotEmpty) {
      return LoggedInUserDetails.docs.toList();
    } else {
      return null;
    }
  }
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('spark_assignedTasks');
  final CollectionReference tasksTableRef =
      FirebaseFirestore.instance.collection('spark_assignedTasks');

  final currentUser = FirebaseAuth.instance.currentUser;

  Stream<List<QuerySnapshot>> getStreamCombineTasks() {
    var stream1 = usersRef
        .where("due_date",
            isLessThanOrEqualTo: DateTime.now().microsecondsSinceEpoch)
        .where("status", isEqualTo: "InProgress")
        .where("to_uid", isEqualTo: currentUser!.uid)
        .snapshots();

    // created by this user
    var stream2 = usersRef
        .where("due_date",
            isLessThanOrEqualTo: DateTime.now().microsecondsSinceEpoch)
        .where("status", isEqualTo: "InProgress")
        .where("by_uid", isEqualTo: currentUser!.uid)
        .snapshots();

    // created by this user
    var stream3 = usersRef
        .where("due_date",
            isLessThanOrEqualTo: DateTime.now().microsecondsSinceEpoch)
        .where("status", isEqualTo: "InProgress")
        .where("particpantsA", arrayContains: currentUser!.uid)
        .snapshots();
    return StreamZip([stream1, stream2, stream3]);
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

  getOverView(String currentUser, String status) {
    return FirebaseFirestore.instance
        .collection('spark_assignedTasks')
        .where("status", isEqualTo: status)
        .where("to_uid", isEqualTo: currentUser)
        .snapshots();
  }

  getEmployees(
      {required String sortByDeptName,
      String sortEmployees = 'ZA',
      required String sortByName}) {
    print('sel dept ${sortByDeptName}');

    // return; 
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
      try {
          return FirebaseFirestore.instance
            .collection('users')
            .where("department",
                arrayContainsAny: [sortByDeptName.toString().toLowerCase()])
            .where('orgId', isEqualTo: "maahomes")
            // .orderBy('name', descending: sortEmployees == 'AZ' ? false : true)
            .snapshots();
      } catch (e) {
      }
      
      }
    } else {
      try {
        return FirebaseFirestore.instance
          .collection("users")
          .where('name', isGreaterThanOrEqualTo: sortByName)
          .where('name', isLessThanOrEqualTo: '$sortByName~')
          .snapshots();
      } catch (e) {
                print('error at bad state  ${e}');

      
    }
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

  getAddParticipants(id, iDa) async {
    // particpantsA
    await tasksTableRef.doc(id).update({
      "particpantsIdA": FieldValue.arrayUnion(iDa),
      "particpantsA": FieldValue.arrayUnion([])
    });
  }
}
