import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Notification/notification_controller.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<NotificatonController>(NotificatonController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        title: Text('Notifications',
            style: Get.theme.kTitleStyle.copyWith(color: Get.theme.btnTextCol)),
        actions: [
          TextButton(
              onPressed: () => {},
              child: Text(
                'Mark all as read',
                style: Get.theme.kSubTitle
                    .copyWith(color: Get.theme.btnTextCol.withOpacity(0.3)),
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              'Today',
              style: Get.theme.kNormalStyle
                  .copyWith(color: Get.theme.btnTextCol.withOpacity(0.6)),
            ),
          ),
          Container(
            width: Get.size.width,
            height: 2,
            color: Get.theme.btnTextCol.withOpacity(0.2),
          ),
          Expanded(child: streamNotifications()),
          // notificationCard(
          //     title: 'Mahendra Mangal',
          //     messageType: 'Completed: ',
          //     message:
          //         "Collect insurance documents from Mr.Rajesh Sales Plan for New Product",
          //     time: "5 Min ago."),
          // notificationCard(
          //     title: 'Vivek Dhillon',
          //     messageType: 'Assigned: ',
          //     message:
          //         "Collect insurance documents from Mr.Rajesh Sales Plan for New Product",
          //     time: "1 Hour ago."),
          // notificationCard(
          //     title: 'Mahendra Mangal',
          //     messageType: 'Commented on: ',
          //     message: "Check Screen for Todo",
          //     mentionText: '@nitesh Please make sure that you’re collecting ',
          //     time: "5 Min ago."),
          // notificationCard(
          //     title: 'Overdue!',
          //     messageType: 'Alert: ',
          //     warning: true,
          //     message:
          //         "Collect insurance documents from Mr.Rajesh Sales Plan for New Product",
          //     time: "Yesterday"),
        ],
      ),
    );
  }

  Widget streamNotifications() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('spark_assignedTasks')
            .where("to_email",
                isEqualTo: FirebaseAuth.instance.currentUser?.email)
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
            print('no of notifi is ${snapshot.data?.docs.length}');
            // numOfTodayTasks.value = snapshot.data!.docs.length;
            return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  late QueryDocumentSnapshot<Object?>? taskData =
                      snapshot.data?.docs[index];
                  final now = DateTime.now();
                  final difference = now.difference(
                      DateTime.fromMillisecondsSinceEpoch(
                          taskData!['created_on']));
                  if (snapshot.data!.docs == 0) {
                    return const Center(
                      child: Text("Notifications Loading..."),
                    );
                  } else {
                    return notificationCard(
                        title: taskData['by_name'],
                        messageType: taskData['status'] == 'Done'
                            ? 'Completed: '
                            : 'Assigned: ',
                        message: taskData['task_desc'],
                        time: timeago.format(now.subtract(difference)));
                  }
                });
          } else {
            return Center(
              child: Column(
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Text("Notifications Loading..."),
                  )
                ],
              ),
            );
          }
        });
  }

  Widget notificationCard(
      {required String title,
      required String messageType,
      required String message,
      required String time,
      String? mentionText,
      bool warning = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Get.theme.kNormalStyle,
          ),
          Text(
            time,
            style: Get.theme.kSubTitle
                .copyWith(color: Get.theme.btnTextCol.withOpacity(0.4)),
          ),
        ],
      ),
      shape: Border(
        bottom: BorderSide(
          color: Get.theme.btnTextCol.withOpacity(0.2),
          width: 1,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RichText(
                text: TextSpan(
                    text: messageType,
                    style: Get.theme.kSubTitle
                        .copyWith(color: Get.theme.btnTextCol),
                    children: [
                  TextSpan(
                    text: message,
                    style: Get.theme.kSubTitle
                        .copyWith(color: warning ? Colors.red : Colors.blue),
                  ),
                ])),
          ),
          if (mentionText != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Get.theme.curveBG,
              ),
              child: Text(mentionText,
                  style: Get.theme.kSubTitle
                      .copyWith(color: Get.theme.btnTextCol)),
            )
        ],
      ),
    );
  }
}
