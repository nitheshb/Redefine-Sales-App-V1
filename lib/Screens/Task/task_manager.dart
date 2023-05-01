import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:confetti/confetti.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contact_list_dialog.dart';
import 'package:redefineerp/Screens/Contact/contact_list_page.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Home/Generator.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
import 'package:redefineerp/Screens/Task/reAssignTo.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:intl/intl.dart';

class TaskManager extends StatelessWidget {
  TaskManager(
      {required this.task,
      required this.createdOn,
      required this.taskPriority,
      required this.selected,
      required this.assigner,
      required this.docId,
      required this.due,
      required this.comments,
      required this.status});
  final String task;
  final String createdOn;
  final String taskPriority;
  final bool selected;
  final String assigner;
  final String docId;
  final String status;
  final String due;
  final List comments;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<TaskController>(TaskController());
    final controllerContacts = Get.put<ContactController>(ContactController());

    controller.setTaskType(status);
    controller.setTaskId(docId);
    debugPrint('DOC ID $docId');

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('spark_assignedTasks')
          .doc(docId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;

        var attachementADb = [];
        var participantsADb = [];
        var commentsADb = [];
        try {
          attachementADb = data["atttachmentsA"];
        } catch (e) {
          attachementADb = [];
        }

        try {
          participantsADb = data["particpantsA"];
        } catch (e) {
          participantsADb = [];
        }

        try {
          commentsADb = data["comments"];
        } catch (e) {
          commentsADb = [];
        }

        // return Padding(
        //   padding: const EdgeInsets.only(top:108.0),
        //   child: Column(
        //     children: [
        //       Text(data['task_title']),
        //       Text(data['task_desc']),
        //       // add more data fields here as needed
        //     ],
        //   ),
        // );

        return Scaffold(
          resizeToAvoidBottomInset: true,

          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 50),
            child: Obx(
              () => AppBar(
                elevation: 0,
                backgroundColor: controller.taskType.value != 'mark'
                    ? Get.theme.kGreenLight
                    : Colors.transparent,
                leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                    )),
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Obx(
                //       () => controller.taskType.value == 'close'
                //           ? IconButton(
                //               onPressed: () => {
                //                     Get.to(() => CreateTaskPage(isEditTask: true)),
                //                   },
                //               icon: const Icon(
                //                 Icons.edit_rounded,
                //                 color: Colors.black,
                //               ))
                //           : sizeBox(0, 0),
                //     ),
                //   ),
                // ],
              ),
            ),
          ),
          // body: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Obx(() => controller.taskType.value != 'mark'
                      //     ? miniMessage(
                      //         'Marked as done, pending for review by the assigner')
                      //     : sizeBox(0, 0)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 22, 0, 4),
                        child: Text(data['task_title'],
                            style: Get.theme.kTitleStyle),
                      ),
                      sizeBox(10, 0),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // assign to

                                    InkWell(
                                      onTap: () => {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: ReassignToList(
                                                      docId: docId,
                                                    )))
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: Material(
                                              type: MaterialType.transparency,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Get.theme.colorPrimaryDark,
                                                radius: 14,
                                                child: Text(
                                                    '${data['to_name'].substring(0, 2)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 4),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                  child: Text(
                                                    'Assigned to',
                                                    style: Get.theme.kSubTitle
                                                        .copyWith(
                                                            color: Get.theme
                                                                .kLightGrayColor,
                                                            fontSize: 10),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                  child: Text(
                                                    '${data["to_name"]}',
                                                    style: Get
                                                        .theme.kPrimaryTxtStyle
                                                        .copyWith(
                                                      color:
                                                          Get.theme.kBadgeColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          //               () => ActionChip(
                                          // elevation: 0,
                                          // side: BorderSide(color: Get.theme.btnTextCol.withOpacity(0.1)),
                                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          // backgroundColor: Get.theme.kBadgeColorBg,
                                          // label: Text(
                                          //   controller.assignedUserName.value,
                                          //   style: Get.theme.kSubTitle.copyWith(color: Get.theme.kBadgeColor),
                                          // ),
                                          // onPressed: () => {
                                          //       // Get.to(() => const ContactListPage()),
                                          //       showDialog(
                                          //               context: context,
                                          //               builder: (BuildContext context) => Dialog(
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(8),
                                          // ),
                                          // child:  ContactListPage()))
                                          //     }
                                          //     )
                                        ],
                                      ),
                                    ),

                                    // Due Date

                                    InkWell(
                                      onTap: () => {
                                        DatePicker.showDateTimePicker(context,
                                            showTitleActions: true,
                                            onChanged: (date) {
                                          print(
                                              'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                        }, onConfirm: (date) {
                                          controller.dateSelected = date;
                                          controller.updateSelectedDate();
                                          controller.updateAssignTimeDb(docId);
                                        }, currentTime: DateTime.now())
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: Material(
                                                type: MaterialType.transparency,
                                                child: DottedBorder(
                                                  borderType: BorderType.Circle,
                                                  color:
                                                      Get.theme.kLightGrayColor,
                                                  radius: Radius.circular(27.0),
                                                  dashPattern: [3, 3],
                                                  strokeWidth: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      size: 15,
                                                      color: Get.theme
                                                          .kLightGrayColor,
                                                    ),
                                                  ),
                                                )
                                                // child: CircleAvatar(
                                                //   radius: 19,
                                                //     backgroundColor: Get.theme.colorPrimaryDark,
                                                //   child: CircleAvatar(
                                                //     backgroundColor: Colors.white,
                                                //     radius: 18,
                                                //     child:   Icon(
                                                //                                                     Icons.calendar_month_outlined,
                                                //                                                     size: 18,
                                                //                                                     color: Get.theme.kLightGrayColor,
                                                //                                                   ),
                                                //   ),
                                                // ),
                                                ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 4),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                  child: Text(
                                                    'Due Date',
                                                    style: Get.theme.kSubTitle
                                                        .copyWith(
                                                            color: Get.theme
                                                                .kLightGrayColor,
                                                            fontSize: 10),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                  child: Text(
                                                      "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(data["due_date"]))}",
                                                      style: Get
                                                          .theme.kNormalStyle
                                                          .copyWith()),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(18.0, 10, 18.0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // assign to

                                    InkWell(
                                      onTap: () => {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child:
                                                        const ContactListPage()))
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: Material(
                                              type: MaterialType.transparency,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Get.theme.colorPrimaryDark,
                                                radius: 14,
                                                child: Text(
                                                    '${controller.assignedUserName.value.substring(0, 2)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 4),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                  child: Text(
                                                    'Priority',
                                                    style: Get.theme.kSubTitle
                                                        .copyWith(
                                                            color: Get.theme
                                                                .kLightGrayColor,
                                                            fontSize: 10),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                  child: Text(
                                                    taskPriority,
                                                    style: Get
                                                        .theme.kPrimaryTxtStyle
                                                        .copyWith(
                                                            color: Get.theme
                                                                .kBadgeColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          //               () => ActionChip(
                                          // elevation: 0,
                                          // side: BorderSide(color: Get.theme.btnTextCol.withOpacity(0.1)),
                                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          // backgroundColor: Get.theme.kBadgeColorBg,
                                          // label: Text(
                                          //   controller.assignedUserName.value,
                                          //   style: Get.theme.kSubTitle.copyWith(color: Get.theme.kBadgeColor),
                                          // ),
                                          // onPressed: () => {
                                          //       // Get.to(() => const ContactListPage()),
                                          //       showDialog(
                                          //               context: context,
                                          //               builder: (BuildContext context) => Dialog(
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(8),
                                          // ),
                                          // child:  ContactListPage()))
                                          //     }
                                          //     )
                                        ],
                                      ),
                                    ),

                                    // Due Date

                                    
                                   Row(
                                        children: [
                                         InkWell(
                                      onTap: () => {
                                        DatePicker.showDateTimePicker(context,
                                            showTitleActions: true,
                                            onChanged: (date) {
                                          print(
                                              'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                        }, onConfirm: (date) {
                                          controller.dateSelected = date;
                                          controller.updateSelectedDate();
                                        }, currentTime: DateTime.now())
                                      },
                                            child: SizedBox(
                                              child: Material(
                                                  type: MaterialType.transparency,
                                                  child: DottedBorder(
                                                    borderType: BorderType.Circle,
                                                    color:
                                                        Get.theme.kLightGrayColor,
                                                    radius: Radius.circular(27.0),
                                                    dashPattern: [3, 3],
                                                    strokeWidth: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 15,
                                                        color: Get.theme
                                                            .kLightGrayColor,
                                                      ),
                                                    ),
                                                  )
                                                  // child: CircleAvatar(
                                                  //   radius: 19,
                                                  //     backgroundColor: Get.theme.colorPrimaryDark,
                                                  //   child: CircleAvatar(
                                                  //     backgroundColor: Colors.white,
                                                  //     radius: 18,
                                                  //     child:   Icon(
                                                  //                                                     Icons.calendar_month_outlined,
                                                  //                                                     size: 18,
                                                  //                                                     color: Get.theme.kLightGrayColor,
                                                  //                                                   ),
                                                  //   ),
                                                  // ),
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 4),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                  child: Text(
                                                    'Created On',
                                                    style: Get.theme.kSubTitle
                                                        .copyWith(
                                                            color: Get.theme
                                                                .kLightGrayColor,
                                                            fontSize: 10),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                  child: Text(
                                                      // createdOn,
                                                      "${DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(data["created_on"]))}",
                                                      style: Get
                                                          .theme.kNormalStyle
                                                          .copyWith()),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    
                                  ],
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  // height: 20,
                                  child: Text(
                                    'Description',
                                    style: Get.theme.kSubTitle.copyWith(
                                        color: Color(0xff707070), fontSize: 16),
                                  ),
                                ),

                                SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  // height: 20,
                                  child: Text(
                                    'Add more details to the task',
                                    // data['task_desc'],
                                    style: Get.theme.kSubTitle.copyWith(
                                      color: Get.theme.kLightGrayColor,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  // height: 20,
                                  child: Text(
                                    'Attachments',
                                    style: Get.theme.kSubTitle.copyWith(
                                        color: Color(0xff707070), fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),

                                // {controller.attachmentsA.map(x=>{
                                //   return

                                // Row(
                                //   children: [
                                //     SizedBox(
                                //         // height: 20,
                                //         child: Padding(
                                //       padding: const EdgeInsets.only(left: 2.0),
                                //       child: DottedBorder(
                                //         // borderType: BorderType.Circle,
                                //         color: Get.theme.kLightGrayColor,
                                //         radius: Radius.circular(27.0),
                                //         dashPattern: [6, 8],
                                //         strokeWidth: 1.5,
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(24.0),
                                //           child: Icon(
                                //             Icons.add,
                                //             size: 22,
                                //             color: Get.theme.kLightGrayColor,
                                //           ),
                                //         ),
                                //       ),
                                //     )),
                                //     Image(
                                //       image: NetworkImage(url!),
                                //       width: 100,
                                //       height: 100,
                                //     )
                                //   ],
                                // );   })},
                                SizedBox(
                                  height: 12,
                                ),

                                SizedBox(
                                    // height: 20,
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Row(
                                    children: [
                                      DottedBorder(
                                        // borderType: BorderType.Circle,
                                        color: Get.theme.kLightGrayColor,
                                        radius: Radius.circular(27.0),
                                        dashPattern: [6, 8],
                                        strokeWidth: 1.5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Icon(
                                            Icons.add,
                                            size: 22,
                                            color: Get.theme.kLightGrayColor,
                                          ),
                                        ),
                                      ),
                                      // Expanded(

                                      //               child: ListView.builder(
                                      //                 shrinkWrap: true,
                                      //                 scrollDirection: Axis.horizontal,
                                      //                   physics: const BouncingScrollPhysics(),

                                      //                 itemCount: 15,
                                      //                 itemBuilder: (BuildContext context, int index) => Card(
                                      //                       child: Center(child: Text('Dummy Card Text')),
                                      //                     ),
                                      //               ),
                                      //             ),
                                      Container(
                                        height: 100,
                                        child: Container(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: attachementADb.length,
                                              itemBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  Card(
                                                      child: Image(
                                                    image: NetworkImage(
                                                        attachementADb[index]),
                                                    // fit: BoxFit.fill,
                                                    width: 100,
                                                    height: 100,
                                                  ))),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),

                                SizedBox(
                                  height: 14,
                                ),
                                SizedBox(
                                  // height: 20,
                                  child: Text(
                                    'Participants',
                                    style: Get.theme.kSubTitle.copyWith(
                                        color: Color(0xff707070), fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Row(
                                    children: [
                                      // Generator.buildOverlaysProfile(
                                      //     images: [
                                      //       'assets/images/icon.jpg',
                                      //       'assets/images/icon.jpg',
                                      //     ],
                                      //     enabledOverlayBorder: true,
                                      //     overlayBorderColor: Color(0xfff0f0f0),
                                      //     overlayBorderThickness: 1.7,
                                      //     leftFraction: 0.72,
                                      //     size: 26),

                                      InkWell(
                                          onTap: () => {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        const ContactListDialogPage())
                                              },
                                          child: DottedBorder(
                                            borderType: BorderType.Circle,
                                            color: Get.theme.kLightGrayColor,
                                            radius: Radius.circular(27.0),
                                            dashPattern: [3, 3],
                                            strokeWidth: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.add,
                                                size: 15,
                                                color:
                                                    Get.theme.kLightGrayColor,
                                              ),
                                            ),
                                          )),

                                      SizedBox(
                                        width: 4,
                                      ),

                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.720,
                                        child: ListView.builder(
                                          itemCount: participantsADb.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3.0),
                                              child: SizedBox(
                                                child: Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  child: CircleAvatar(
                                                    backgroundColor: Get
                                                        .theme.colorPrimaryDark,
                                                    radius: 14,
                                                    child: Text(
                                                        '${participantsADb[index]['name'].substring(0, 2)}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            color: Color(0xffF8F8F8),
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              '${assigner} created & assigned this task to ${assigner} on ${createdOn}',
                              style: Get.theme.kSubTitle
                                  .copyWith(color: Get.theme.kGreenDark),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1020,
                              height:
                                  MediaQuery.of(context).size.height * 0.104,
                              child: ListView.builder(
                                itemCount: commentsADb.length,
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: Color(0xffF8F8F8),
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        left: 20.0,
                                        right: 20,
                                        top: 8.0,
                                        bottom: 8.0),
                                    child: Text(
                                      '${commentsADb[index]["txt"]}',
                                      style: Get.theme.kSubTitle.copyWith(
                                          color: Get.theme.kGreenDark),
                                    ),
                                  );
                                },
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.106,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.isPlaying.value == false) {
                                controller.isPlaying.value = true;
                                 controller.closeTask(docId, 'text',
                                        controller.commentLine.value);
                              } else {
                                controller.isPlaying.value = false;
                                controller.reopenedOnTask(docId, 'text',
                                        controller.commentLine.value);
                              }
                              print(controller.isPlaying.value);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width *
                                          0.030),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Container(
                                      // radius: MediaQuery.of(context).size.height *
                                      //     0.030,
                                      // backgroundColor: const Color(0xffBDA1EF),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                    // shape: BoxShape.circle,
                    color: const Color(0xffBDA1EF),
                  ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical:8, horizontal:20),
                                        child: Row(
                                          children: [
                                             const Icon(
                                              Icons.close,
                                              color: Color(0xff33264b),
                                            ),
                                            SizedBox(width: 10),
                                            controller.isPlaying.value ? Text('Re-Open Task') : Text('Close Task') ,
                                           
                                          ],
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            left: 14.0,
                            right: 14.0,
                            top: 10.0),
                        child: TextField(
                          controller: controller.commentLine,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    print(
                                        "save to comment section ${controller.commentLine.value}");
                                    controller.addComments(docId, 'text',
                                        controller.commentLine.value);
                                    // save to comments section
                                    // get the list of all follwers + assigne name + creator
                                    // ignore the sender from receipnt list
                                    // send fcm notification to all followers
                                    // add the log to supabase
                                  },
                                  icon: Icon(Icons.send)),
                              border: InputBorder.none,
                              hintText: 'Comments '),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          autofocus: true,
                        ),
                      ),
                    ]),
              ),
              Obx(() => controller.isPlaying.value == true
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 0.050,
                      // left: MediaQuery.of(context).size.width * 0.50,
                      // right: MediaQuery.of(context).size.width * 0.50,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Lottie.asset('assets/images/closing.json'),
                      ))
                  : SizedBox())
            ],
          ),
          // ),
          // bottomNavigationBar:     Column(
          //    crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisSize: MainAxisSize.min,
          //   children: [
          //       TextField(
          //                               controller: controller.taskTitle,
          //                               decoration: InputDecoration(
          //                                   border: InputBorder.none,
          //                                   hintText: 'Task name...'),
          //                                   style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),

          //                               autofocus: true,
          //                             ),
          //     Row(
          //                 children: [
          //                   IconButton(
          //                       onPressed: () => {
          //                             // BasicDialog(
          //                             //     title: 'title',
          //                             //     message: 'message',
          //                             //     button1: 'button1',
          //                             //     tapFeatures: () => {}),
          //                             // Get.to(() => const SearchPage())
          //                           },
          //                       icon: Icon(Icons.search_outlined,
          //                           color: Get.theme.btnTextCol.withOpacity(0.3))),
          //                   IconButton(

          //                     onPressed: () => {
          //                                       // snackBarMsg('Task Done!', enableMsgBtn: true),
          //                                       },
          //                     icon: Icon(Icons.filter_list_rounded,
          //                         color: Get.theme.btnTextCol.withOpacity(0.3)),
          //                   ),
          //                 ],
          //               ),
          //   ],
          // ) ,
          // bottomNavigationBar: BottomAppBar(
          //   child: Padding(
          //     padding: const EdgeInsets.all(15.0),
          //     child: Obx(() => TextButton(
          //           style: TextButton.styleFrom(
          //             primary: controller.taskType.value == 'reopen'
          //                 ? Colors.black
          //                 : Get.theme.colorPrimary,
          //             backgroundColor: controller.taskType.value == 'mark'
          //                 ? Get.theme.successColor
          //                 : controller.taskType.value == 'reopen'
          //                     ? Get.theme.colorAccent
          //                     : Get.theme.colorPrimaryDark,
          //           ),
          //           onPressed: () => {
          //             if (controller.taskType.value == 'mark')
          //               {controller.taskType.value = 'reopen'}
          //             else if (controller.taskType.value == 'reopen')
          //               {controller.taskType.value = 'close'}
          //             else
          //               {controller.taskType.value = 'mark'},
          //             debugPrint("TASKTYPE: ${controller.taskType.value}")
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             // ignore: unnecessary_string_interpolations
          //             child: Text(
          //                 controller.taskType.value == 'mark'
          //                     ? 'Mark it as done'
          //                     : controller.taskType.value == 'reopen'
          //                         ? 'Re-open Task'
          //                         : 'Close Task',
          //                 style: Get.theme.kNormalStyle),
          //           ),
          //         )),
          //   ),
          // ),
        );
      },
    );
  }

 }



