import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart' show StreamGroup, StreamZip;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redefineerp/helpers/supabae_help.dart';
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

  // stream lead logs schedule by leadID
  strLeadSchedule(orgId,leadId)async{
      await  FirebaseFirestore.instance
          .collection("${orgId}_leads_sch")
          // .where("assignedTo", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          // .where("staA", arrayContainsAny: ['pending', 'overdue'])
          .doc(leadId)
          .snapshots();
  }
 //closeAllPerviousTasks
addTaskCommentDB(orgId,
  leadDocId,
  kId,
  newStat,
  schStsA,
  oldSch) async{
        final schTime = oldSch['schTime'];
  final comments = oldSch['comments'];
 
  print('comments are ${comments}');
 await FirebaseFirestore.instance.collection('${orgId}_leads_sch').doc(leadDocId).update({
    '$kId.comments': comments,
    '$kId.schTime': schTime,
  });
  // await updateDoc(doc(db, `${orgId}_leads_sch`, uid), {
  //   [x]: comments,
  //   [y]: schTime,
  // })
  if (comments.length > 0) {
    final c = comments[0]['c'];
    await FirebaseFirestore.instance.collection('${orgId}_leads').doc(leadDocId).update({
      'Remarks': c,
    });
  }
}
// 
rescheduleTaskCommentDB(orgId,
  leadDocId,
  kId,
  newStat,
  schStsA,
  oldSch) async{


        final schTime = oldSch['schTime'];

 await FirebaseFirestore.instance.collection('${orgId}_leads_sch').doc(leadDocId).update({
 
    '$kId.schTime': schTime,
  });

}
// updates Lead task  status array, specific task status & completedTime
completeLeadTaskScheduleLog(orgId,
  leadDocId,
  kId,
  newTaskStatus,
  schStsA,
  ) async{

 await FirebaseFirestore.instance.collection('${orgId}_leads_sch').doc(leadDocId).update({
    'staA': schStsA,
     '$kId.sts': newTaskStatus,
    '$kId.schTime':DateTime.now().millisecondsSinceEpoch,
  });

}

//add new Lead task 
    addLeadScheduler  (
      orgId,
      did,
      data,
      schStsA,
      assignedTo
    )async {

      // make sure data contains below 
    //    const data = {
    //   stsType: tempLeadStatus || 'none',
    //   assTo: user?.displayName || user?.email,
    //   assToId: user.uid,
    //   by: user?.displayName || user?.email,
    //   cby: user.uid,
    //   type: 'schedule',
    //   pri: selected?.name,
    //   notes: y === '' ? `Negotiate with customer` : y,
    //   sts: 'pending',
    //   schTime:
    //     tempLeadStatus === 'booked'
    //       ? Timestamp.now().toMillis() + 10800000
    //       : startDate.getTime(),
    //   ct: Timestamp.now().toMillis(),
    // }
         final xo = data['ct'];
  final yo = {
    'staA': schStsA,
    'staDA': [xo],
    xo: data,
  };

  try {
    final washingtonRef = FirebaseFirestore.instance.collection('${orgId}_leads_sch').doc(did);
    print('check add LeadLog ${washingtonRef.id}');

    await washingtonRef.update({...yo});
  } catch (error) {
    final y1 = {...yo};
    yo['assignedTo'] = assignedTo ?? '';
    print('new log set $yo');
    
    await FirebaseFirestore.instance.collection('${orgId}_leads_sch').doc(did).set({...yo});
  } 
    }
    updateVisitFixedStatus(orgId,leadDocId, data) async {
    // particpantsA
    await  FirebaseFirestore.instance.collection('${orgId}_leads')
    .doc(leadDocId).update({
     ...data
    });
    await DbSupa.instance.leadStatusLog(orgId,leadDocId, data);
    // 
  }
}
