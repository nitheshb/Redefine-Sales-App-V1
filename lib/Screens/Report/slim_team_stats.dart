import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redefineerp/Screens/Auth/auth_controller.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/Notification/notification_pages.dart';
import 'package:redefineerp/Screens/Profile/profile_page.dart';
import 'package:redefineerp/themes/constant.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/progress_bar.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';

class SlimTeamStats extends StatefulWidget {
  var flipMode;
   var businessMode,numOfTodayTasks, myBusinessTotal ;
  SlimTeamStats(this.flipMode, this.businessMode, this.numOfTodayTasks, this.myBusinessTotal);
 
  @override
  State<SlimTeamStats> createState() => _SlimTeamStatsState();
}

class _SlimTeamStatsState extends State<SlimTeamStats> {
 
  var dayCompleted = 12;
  var dayTotal = 19;
  var weekCompleted = 38;
  var weekTotal = 57;
  var monthCompleted = 369;
  var monthTotal = 392;
  var isDay = true;
  var isWeek = false;
  var isMonth = false;
        final controller = Get.put<HomePageController>(HomePageController());
            final UserController = Get.put<AuthController>(AuthController());
   
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6,8,8),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                // colors: [
                //   Color.fromRGBO(69, 115, 201, 1),
                //   Color.fromRGBO(69, 115, 201, 1),
                // ],
        
                colors: [Color(0xffffffff), Color(0xffffffff), Color(0xffffffff),]
              ),
            ),
            child: Column(
              children: [
                
                status(),
              ],
            ),
          ),
        ),
      ],
    );
  }

Widget statusBarItems(title) {
    FirebaseAuth auth = FirebaseAuth.instance;
  return  Expanded(
              child: InkWell(
                          onTap: () =>{controller.flipMode(title)},
                child: FxContainer.bordered(
                  color: (title== "Tasks" && !controller.businessMode.value) ?  Get.theme.primaryContainer: (title== "Leads" && controller.businessMode.value) ?  Get.theme.primaryContainer: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.titleMedium(
                        title,
                        fontWeight: 700,
                      ),
                      FxSpacing.height(8),
                          StreamBuilder<QuerySnapshot>(
        stream: title== "Tasks" ? FirebaseFirestore.instance
            .collection('spark_assignedTasks')
            .where("due_date",
                isLessThanOrEqualTo: DateTime.now().microsecondsSinceEpoch)
            .where("status", isEqualTo: "InProgress")
            .where("to_uid", isEqualTo: auth.currentUser!.uid)
            .snapshots() :

            FirebaseFirestore.instance
            .collection("${UserController.currentUserObj['orgId']}_leads")
            // .where("assignedTo", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("Status", whereIn: [
          'new',
          'followup',
          'visitfixed',
          'visitdone','negotiation'
        ]).snapshots(), 
        //
//  .where("Status", isEqualTo: controller.myLeadStatusCategory.value).snapshots(),
        builder: (context, snapshot) {
        //     if (!snapshot.hasData) {
        //   return CircularProgressIndicator();
        // }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong! 😣..."),
            );
          } else if (snapshot.hasData) {

            // lets seperate between business vs personal 

      
            var TotalTasks = snapshot.data!.docs.toList();
            var personalTasks;
           
            if(title== "Tasks"){
           personalTasks= TotalTasks.where((element) => element["by_uid"] == auth.currentUser!.uid);
            }else{
             personalTasks= TotalTasks; 
            }
            // if (doc['status'] == "Done") {
            //   donecount.value = donecount.value + 1;
            //   debugPrint("DONE COUNT== ${donecount.value}");
            // } else if (doc['status'] == "InProgress") {
            //   notdone.value = notdone.value + 1;
            //   debugPrint("Not done COUNT== ${notdone.value}");
            // }
          // }
// return   Countup(
//               begin: 0,
//               end: 300,
//               duration: Duration(milliseconds: 300),
//               separator: ',',
//               style: TextStyle(
//                 fontSize: 36,
//               ),
//             );
              return FxText.titleSmall(
                         personalTasks.length.toString(),
                        fontWeight: 700,
                      );
         } else {
            return Center(
              child: Column(
                children:  [
                  Center(
                    child:   FxText.titleSmall(
                         "0",
                        fontWeight: 700,
                      )
                  ),
                  // SizedBox(height: 50),
                  // Center(
                  //   child: Text("Tasks Loading..."),
                  // )
                ],
              ),
            );
          }
        }),
                      // Obx(()=> FxText.titleSmall(
                      //   widget.numOfTodayTasks.toString(),
                      //   fontWeight: 700,
                      // )),
                      FxSpacing.height(12),
                      FxText.bodySmall(
                        'Progress',
                        fontWeight: 600,
                        muted: true,
                      ),
                      FxSpacing.height(6),
                      FxProgressBar(
                        width: 140,
                        inactiveColor: Constant.softColors.green.color,
                        activeColor: Constant.softColors.green.onColor,
                        height: 4,
                        progress: 0.4,
                      ),
                    ],
                  ),
                ),
              ),
            );

 
  }
   Widget status() {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top:2.0),
        child: Row(
          children: [
           
           statusBarItems('Tasks'),
            FxSpacing.width(16),
            statusBarItems('Leads'),
          //   Expanded(
          //     child: InkWell(
          //               onTap: () => widget.flipMode(),
          //       child: FxContainer.bordered(
          //         color: widget.businessMode ?  Get.theme.primaryContainer:  Colors.transparent,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             FxText.titleMedium(
          //               'Business',
          //               fontWeight: 700,
          //             ),
          //             FxSpacing.height(8),
          //             // FxText.titleSmall(
          //             //   (dayTotal - dayCompleted).toString(),
          //             //   fontWeight: 700,
          //             // ),
          //              Obx(()=> FxText.titleSmall(
          //               widget.myBusinessTotal.toString(),
          //               fontWeight: 700,
          //             )),
          //             FxSpacing.height(12),
          //             FxText.bodySmall(
          //               'Progress',
          //               fontWeight: 600,
          //               muted: true,
          //             ),
          //             FxSpacing.height(6),
          //             FxProgressBar(
          //               width: 140,
          //               inactiveColor: Get.theme.secondaryContainer,
          //               activeColor: Get.theme.onSecondaryContainer,
          //               height: 4,
          //               progress: 0.7,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
       ] ),
      ),
    );
  }

}
