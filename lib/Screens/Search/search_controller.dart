import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Task/task_manager.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:intl/intl.dart';
import 'package:redefineerp/themes/themes.dart';

class SearchController extends GetxController {
  var selectedIndex = 0.obs;

  var searchResultsWidget = sizeBox(0, 0).obs;

  Widget searchResults(String searchTerm) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('spark_assignedTasks')
            .where('task_title', isGreaterThanOrEqualTo: searchTerm)
            .where('task_title', isLessThanOrEqualTo: searchTerm + '~')
            // .where("due_date",
            //     isEqualTo: "${DateTime.now().microsecondsSinceEpoch - } ")
            // .where("status", isEqualTo: "InProgress")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong! 😣..."),
            );
          } else if (snapshot.hasData) {
            print('no of todo is ${snapshot.data?.docs.length}');
            // numOfTodayTasks.value = snapshot.data!.docs.length;
            return Column(
              children: [
                if (snapshot.data!.docs.length == 0)
                  Column(
                    children: [
                      Center(
                          child: SvgPicture.asset('assets/images/Search.svg')),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          'Not found!',
                          style: Get.theme.kNormalStyle
                              .copyWith(color: Get.theme.kLightGrayColor),
                        ),
                      ),
                    ],
                  ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            late QueryDocumentSnapshot<Object?>? taskData =
                                snapshot.data?.docs[index];
                            print("qwdqwdw ${taskData?.id}");
                            // print(
                            //     "date is ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
                            // print("due date is ${taskData!.get('due data')}");
                            // return Text("hello");
                            return taskCheckBox(
                                taskPriority: taskData!['priority'] == "Basic"
                                    ? 3
                                    : taskData['priority'] == "Medium"
                                        ? 2
                                        : taskData['priority'] == "High"
                                            ? 1
                                            : 4,
                                due:
                                    "${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date')))}"
                                        .toString(),
                                taskPriorityNum: taskData['priority'] == "Basic"
                                    ? 3
                                    : taskData['priority'] == "Medium"
                                        ? 2
                                        : taskData['priority'] == "High"
                                            ? 1
                                            : 4,
                                selected: false,
                                task: taskData["task_title"],
                                createdOn:
                                    'Created:  ${DateFormat('dd MMMM, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on')))}',
                                assigner: 'Assigner: ${taskData['by_name']}',
                                 onTap: () => {
                                      Get.to(() => TaskManager(
                                            task: taskData["task_title"],
                                            status: taskData['status'],
                                            docId: taskData.reference.id,
                                            due:
                                                "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date')))}"
                                                    .toString(),
                                            createdOn:
                                                "${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('created_on')))}"
                                                    .toString(),
                                            taskPriority: taskData['priority'],
                                            selected: false,
                                            assigner: taskData['by_name'],
                                          ))
                                    });
                          }),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Text("Tasks Loading..."),
                  )
                ],
              ),
            );
          }
        });
  }
}
