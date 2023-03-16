import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contact_list_dialog.dart';
import 'package:redefineerp/Screens/Contact/contact_list_page.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Home/Generator.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/themes/themes.dart';

class TaskManager extends StatelessWidget {
  TaskManager(
      {required this.task,
      required this.createdOn,
      required this.taskPriority,
      required this.selected,
      required this.assigner,
      required this.docId,
      required this.due,
      required this.status});
  final String task;
  final String createdOn;
  final String taskPriority;
  final bool selected;
  final String assigner;
  final String docId;
  final String status;
  final String due;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<TaskController>(TaskController());
    final controller_Contacts = Get.put<ContactController>(ContactController());

    controller.setTaskType(status);
    debugPrint('DOC ID $docId');
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
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => controller.taskType.value != 'mark'
                  ? miniMessage(
                      'Marked as done, pending for review by the assigner')
                  : sizeBox(0, 0)),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 22, 0, 4),
                child: Text(task, style: Get.theme.kTitleStyle),
              ),
              sizeBox(10, 0),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // assign to

                            InkWell(
                              onTap: () => {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const ContactListPage()))
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
                                            'Assigned to',
                                            style: Get.theme.kSubTitle.copyWith(
                                                color:
                                                    Get.theme.kLightGrayColor,
                                                fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 22,
                                          child: Text(
                                            assigner,
                                            style: Get.theme.kPrimaryTxtStyle
                                                .copyWith(
                                              color: Get.theme.kBadgeColor,
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
                                    showTitleActions: true, onChanged: (date) {
                                  print(
                                      'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                }, onConfirm: (date) {
                                  controller.dateSelected = date;
                                  controller.updateSelectedDate();
                                }, currentTime: DateTime.now())
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Material(
                                        type: MaterialType.transparency,
                                        child: DottedBorder(
                                          borderType: BorderType.Circle,
                                          color: Get.theme.kLightGrayColor,
                                          radius: Radius.circular(27.0),
                                          dashPattern: [3, 3],
                                          strokeWidth: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                              color: Get.theme.kLightGrayColor,
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
                                            style: Get.theme.kSubTitle.copyWith(
                                                color:
                                                    Get.theme.kLightGrayColor,
                                                fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 22,
                                          child: Text(due,
                                              style: Get.theme.kNormalStyle
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
                    padding: const EdgeInsets.fromLTRB(18.0, 10, 18.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // assign to

                            InkWell(
                              onTap: () => {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const ContactListPage()))
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
                                            style: Get.theme.kSubTitle.copyWith(
                                                color:
                                                    Get.theme.kLightGrayColor,
                                                fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 22,
                                          child: Text(
                                            taskPriority,
                                            style: Get.theme.kPrimaryTxtStyle
                                                .copyWith(
                                                    color:
                                                        Get.theme.kBadgeColor),
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
                                    showTitleActions: true, onChanged: (date) {
                                  print(
                                      'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                }, onConfirm: (date) {
                                  controller.dateSelected = date;
                                  controller.updateSelectedDate();
                                }, currentTime: DateTime.now())
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Material(
                                        type: MaterialType.transparency,
                                        child: DottedBorder(
                                          borderType: BorderType.Circle,
                                          color: Get.theme.kLightGrayColor,
                                          radius: Radius.circular(27.0),
                                          dashPattern: [3, 3],
                                          strokeWidth: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                              color: Get.theme.kLightGrayColor,
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
                                            'Created On',
                                            style: Get.theme.kSubTitle.copyWith(
                                                color:
                                                    Get.theme.kLightGrayColor,
                                                fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 22,
                                          child: Text(
                                              // createdOn,
                                              due,
                                              style: Get.theme.kNormalStyle
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
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: controller.attachmentsA.length,
                                      itemBuilder: (BuildContext context,
                                              int index) =>
                                          Card(
                                              child: Image(
                                            image: NetworkImage(
                                                controller.attachmentsA[index]),
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
                                            builder: (BuildContext context) =>
                                                const ContactListDialogPage())

                                      },
                                  child: DottedBorder(
                                    borderType: BorderType.Circle,
                                    color: Get.theme.kLightGrayColor,
                                    radius: Radius.circular(27.0),
                                    dashPattern: [3, 3],
                                    strokeWidth: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Get.theme.kLightGrayColor,
                                      ),
                                    ),
                                  )),

                              SizedBox(
                                width: 4,
                              ),

                              Obx(
                                () => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.720,
                                  child: ListView.builder(
                                    itemCount: controller_Contacts
                                        .participants.value.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left:3.0),
                                        child: SizedBox(
                                          child: Material(
                                            type: MaterialType.transparency,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Get.theme.colorPrimaryDark,
                                              radius: 14,
                                              child: Text(
                                                  '${controller_Contacts.participants[index]['name'].substring(0, 2)}',
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
                    height: MediaQuery.of(context).size.height * 0.150,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 14.0,
                    right: 14.0,
                    top: 10.0),
                child: TextField(
                  controller: controller.taskTitle,
                  decoration: InputDecoration(
                      suffixIcon:
                          IconButton(onPressed: () {
                            print("save to comment section ${controller.taskTitle.value}");
                            // save to comments section
                            // get the list of all follwers + assigne name + creator
                            // ignore the sender from receipnt list
                            // send fcm notification to all followers
                            // add the log to supabase 
                          }, icon: Icon(Icons.send)),
                      border: InputBorder.none,
                      hintText: 'Comments '),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  autofocus: true,
                ),
              ),
            ]),
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
  }
}