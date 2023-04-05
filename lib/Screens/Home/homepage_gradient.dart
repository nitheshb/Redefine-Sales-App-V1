import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/Contact/contact_list_dialog.dart';
import 'package:redefineerp/Screens/Contact/contact_list_page.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/Notification/notification_pages.dart';
import 'package:redefineerp/Screens/Profile/profile_page.dart';
import 'package:redefineerp/Screens/Report/report_page.dart';
import 'package:redefineerp/Screens/Report/team_stats.dart';
import 'package:redefineerp/Screens/Search/search_task.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
import 'package:redefineerp/Screens/Task/reAssginTo_controller.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Utilities/basicdialog.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Utilities/snackbar.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:redefineerp/Widgets/datewidget.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:intl/intl.dart';

class HomeGradientPage extends StatelessWidget {
  final storageReference =
      FirebaseStorage.instance.ref().child('images/image.jpg');

  ImagePicker picker = ImagePicker();

  XFile? image;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomePageController>(HomePageController());
    final controller1 = Get.put<ContactController>(ContactController());

    // TaskController controller1 = Get.put<TaskController>(TaskController());
    debugPrint("home called ${FirebaseAuth.instance.currentUser}");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // Get.to(() => const CreateTaskPage(isEditTask: false)),
          //              showModalBottomSheet(
          //                 context: context,
          //                 builder: (context) {
          //                   // return CreateTaskPage(isEditTask: false);
          //                   return Container(
          //                     width: MediaQuery.of(context).size.width,

          //                     padding: EdgeInsets.only(
          //                         bottom: MediaQuery.of(context).viewInsets.bottom),
          //                     margin: EdgeInsets.symmetric(horizontal: 16),
          //                     // child:

          //                       //   Column(
          //                       //     children: [
          //                       //       TextField(
          //                       //         decoration: InputDecoration(
          //                       //             border: InputBorder.none,
          //                       //             hintText: 'Enter task name'),
          //                       //         onSubmitted: (value) {
          //                       //           Navigator.pop(context);
          //                       //           var currentDate = DateTime.now();
          //                       //       DatePicker.showTimePicker(context,
          //                       //       showSecondsColumn: false,
          //                       //         showTitleActions: true,
          //                       //          onChanged: (date) {
          //                       // }, onConfirm: (date) {
          //                       //       if(value.isNotEmpty){
          //                       //         print('value is ${value} data is ${date}');
          //                       //       //  var task = Task.create(name: value, createdAt: date);
          //                       //       // base.dataStore.addTask(task: task);
          //                       //       }

          //                       // }, currentTime: DateTime.now());
          //                       //         },
          //                       //         autofocus: true,
          //                       //       ),
          //                       //     ],
          //                       //   ),
          //                     child: Column(
          //                       children: [
          //                             TextField(
          //                               decoration: InputDecoration(
          //                                   border: InputBorder.none,
          //                                   hintText: 'Task name'),
          //                                   style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
          //                               onSubmitted: (value) {
          //                                 Navigator.pop(context);
          //                                 var currentDate = DateTime.now();
          //                             DatePicker.showTimePicker(context,
          //                             showSecondsColumn: false,
          //                               showTitleActions: true,
          //                                onChanged: (date) {
          //                           }, onConfirm: (date) {
          //                             if(value.isNotEmpty){
          //                               print('value is ${value} data is ${date}');
          //                             //  var task = Task.create(name: value, createdAt: date);
          //                             // base.dataStore.addTask(task: task);
          //                             }

          //                           }, currentTime: DateTime.now());
          //                               },
          //                               autofocus: true,
          //                             ),
          //                              TextField(
          //                               decoration: InputDecoration(
          //                                   border: InputBorder.none,
          //                                   hintText: 'Description'),
          //                                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          //                               onSubmitted: (value) {
          //                                 Navigator.pop(context);
          //                                 var currentDate = DateTime.now();
          //                             DatePicker.showTimePicker(context,
          //                             showSecondsColumn: false,
          //                               showTitleActions: true,
          //                                onChanged: (date) {
          //                           }, onConfirm: (date) {
          //                             if(value.isNotEmpty){
          //                               print('value is ${value} data is ${date}');
          //                             //  var task = Task.create(name: value, createdAt: date);
          //                             // base.dataStore.addTask(task: task);
          //                             }

          //                           }, currentTime: DateTime.now());
          //                               },
          //                               autofocus: true,

          //                            ),
          //                           //  Container(
          //                           //   height:
          //                           //  child: null),
          //                             SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: [
          //           Container(
          //     child:  Row(
          //       children: [
          //         IconButton(
          //       onPressed: () =>
          //           {
          //             // bottomSheetWidget(FilterScreen(), transparentBg: true)
          //                                         DatePicker.showDateTimePicker(context,
          //                           showTitleActions: true, onChanged: (date) {
          //                         print(
          //                             'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
          //                       }, onConfirm: (date) {
          //                         // controller.dateSelected = date;
          //                         // controller.updateSelectedDate();
          //                       }, currentTime: DateTime.now())
          //             },
          //       icon: Icon(
          //         Icons.people_rounded,
          //         color: Get.theme.kLightGrayColor,
          //       ),
          //     ),
          //         Text(
          //             "To",
          //             style: Get.theme.kSubTitle.copyWith(
          //               color: Get.theme.kBadgeColor

          //             ),
          //         ),
          //       ],
          //     )
          //   ),
          //  Padding(
          //    padding: const EdgeInsets.all(8.0),
          //    child: Container(
          //       child:  Row(
          //          mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           IconButton(
          //         onPressed: () =>
          //             {
          //               // bottomSheetWidget(FilterScreen(), transparentBg: true)
          //                                           DatePicker.showDateTimePicker(context,
          //                             showTitleActions: true, onChanged: (date) {
          //                           print(
          //                               'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
          //                         }, onConfirm: (date) {
          //                           // controller.dateSelected = date;
          //                           // controller.updateSelectedDate();
          //                         }, currentTime: DateTime.now())
          //               },
          //         icon: Icon(
          //           Icons.calendar_month_outlined,
          //           color: Get.theme.kLightGrayColor,
          //         ),
          //       ),
          //           Text(
          //               "Today",
          //               style: Get.theme.kSubTitle.copyWith(
          //                 color: Get.theme.kBadgeColor

          //               ),
          //           ),
          //         ],
          //       )
          //     ),
          //  ),
          //    Padding(
          //      padding: const EdgeInsets.all(8.0),
          //      child: Container(
          //       child:  Row(
          //         children: [
          //            Icon(
          //                       Icons.flag_outlined,
          //                       color: Get.theme.btnTextCol.withOpacity(0.3),
          //                     ),
          //           Text(
          //               "Priority",
          //               style: Get.theme.kSubTitle.copyWith(
          //                 color: Get.theme.kBadgeColor

          //               ),
          //           ),
          //         ],
          //       )
          //            ),
          //    )
          //         ],
          //       ),
          //     ),

          //                       ],
          //                     ),
          //                   );
          //                 })

          //       },

          // showModalBottomSheet(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(top: Radius.circular(9.0))),
          // backgroundColor: Colors.white,
          // context: context,
          // isScrollControlled: true,
          // builder: (context) => Padding(
          //   padding: EdgeInsets.only(
          //                 bottom: MediaQuery.of(context).viewInsets.bottom,
          //                 left: 14.0,
          //                 right:14.0,
          //                 top: 10.0),
          //   child:     ContactListDialogPage())),

          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(9.0))),
              backgroundColor: Colors.white,
              context: context,
              isScrollControlled: true,
              builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 14.0,
                      right: 14.0,
                      top: 10.0),
                  child: Form(
                    key: controller.taskKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: controller.validateTaskTitle,
                          controller: controller.taskTitle,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Task name..5555.'),
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500),
                          autofocus: true,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Description'),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                          onSubmitted: (value) {
                            Navigator.pop(context);
                            var currentDate = DateTime.now();
                            DatePicker.showTimePicker(context,
                                showSecondsColumn: false,
                                showTitleActions: true,
                                onChanged: (date) {}, onConfirm: (date) {
                              if (value.isNotEmpty) {
                                print('value iss ${value} data is ${date}');
                                //  var task = Task.create(name: value, createdAt: date);
                                // base.dataStore.addTask(task: task);
                              }
                            }, currentTime: DateTime.now());
                          },
                          autofocus: true,
                        ),
                        //  Container(
                        //   height:
                        //  child: null),
                        Visibility(
                          visible: !(controller.assignedUserName.value ==
                              "Assign someone"),
                          child: Row(
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
                                          radius: 17,
                                          child: Text(
                                              '${controller.assignedUserName.value.substring(0, 2)}',
                                              style: TextStyle(
                                                  color: Colors.white)),
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
                                                          .kLightGrayColor),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 22,
                                            child: Text(
                                              controller.assignedUserName.value,
                                              style: Get.theme.kPrimaryTxtStyle
                                                  .copyWith(
                                                      color: Get
                                                          .theme.kBadgeColor),
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
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Icon(
                                                Icons.calendar_month_outlined,
                                                size: 18,
                                                color:
                                                    Get.theme.kLightGrayColor,
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
                                                          .kLightGrayColor),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 22,
                                            child: Text(
                                                controller
                                                    .selectedDateTime.value,
                                                style: Get.theme.kNormalStyle
                                                    .copyWith(
                                                        color: Get.theme
                                                            .kBadgeColor)),
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
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Visibility(
                            visible: (controller.attachmentsA.value.length > 0),
                            child: SizedBox(
                                // height: 20,
                                child: Column(
                              children: [
                                SizedBox(
                                  // height: 20,
                                  child: Text(
                                    'Attachments',
                                    style: Get.theme.kSubTitle.copyWith(
                                        color: Color(0xff707070), fontSize: 16),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          image = await picker.pickImage(
                                              source: ImageSource.gallery);
                                          storageReference
                                              .putFile(File(image!.path))
                                              .then((value) async {
                                            controller.attachmentsA.value.add(
                                                await value.ref
                                                    .getDownloadURL());
                                            print(
                                                'Image URL: ${controller.attachmentsA.value}');
                                          });
                                        },
                                        child: DottedBorder(
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
                                      ),
                                      Container(
                                        height: 100,
                                        child: Container(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: controller
                                                  .attachmentsA.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      Card(
                                                          child: Image(
                                                        image: NetworkImage(
                                                            controller
                                                                    .attachmentsA[
                                                                index]),
                                                        // fit: BoxFit.fill,
                                                        width: 100,
                                                        height: 100,
                                                      ))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))),

                        Visibility(
                          visible: (controller1.participants.value.isNotEmpty),
                          child: SizedBox(
                            // height: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Participants',
                                  style: Get.theme.kSubTitle.copyWith(
                                      color: Color(0xff707070), fontSize: 16),
                                ),
                                SizedBox(
                                  height: 8,
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
                                          itemCount: controller
                                              .participantsANew.value.length,
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
                                                        '${controller.participantsANew[index]['name'].substring(0, 2)}',
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

                                      // Obx(
                                      //   () => SizedBox(
                                      //     height:
                                      //         MediaQuery.of(context).size.height * 0.04,
                                      //     width:
                                      //         MediaQuery.of(context).size.width * 0.720,
                                      //     child: ListView.builder(
                                      //       itemCount: controller_Contacts
                                      //           .participants.value.length,
                                      //       scrollDirection: Axis.horizontal,
                                      //       itemBuilder: (context, index) {
                                      //         return Padding(
                                      //           padding: const EdgeInsets.only(left:3.0),
                                      //           child: SizedBox(
                                      //             child: Material(
                                      //               type: MaterialType.transparency,
                                      //               child: CircleAvatar(
                                      //                 backgroundColor:
                                      //                     Get.theme.colorPrimaryDark,
                                      //                 radius: 14,
                                      //                 child: Text(
                                      //                     '${controller_Contacts.participants[index]['name'].substring(0, 2)}',
                                      //                     style: TextStyle(
                                      //                         color: Colors.white,
                                      //                         fontSize: 10)),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         );
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Visibility(
                                    visible:
                                        (controller.assignedUserName.value ==
                                            "Assign someone"),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    Dialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child:
                                                            ContactListPage()))
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color:
                                                    Get.theme.kLightGrayColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        InkWell(
                                          onTap: () => {
                                            DatePicker.showDateTimePicker(
                                                context,
                                                showTitleActions: true,
                                                onChanged: (date) {
                                              print(
                                                  'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                            }, onConfirm: (date) {
                                              controller.dateSelected = date;
                                              controller.updateSelectedDate();
                                            }, currentTime: DateTime.now())
                                          },
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            color: Get.theme.kLightGrayColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        !(controller.attachmentsA.value.length >
                                            0),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                image = await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                                storageReference
                                                    .putFile(File(image!.path))
                                                    .then((value) async {
                                                  controller
                                                      .attachmentsA.value = [
                                                    await value.ref
                                                        .getDownloadURL()
                                                  ];
                                                  print(
                                                      'Image URL: ${controller.attachmentsA.value}');
                                                });
                                              },
                                              child: Icon(
                                                Icons.attach_file,
                                                color:
                                                    Get.theme.kLightGrayColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      DatePicker.showDateTimePicker(context,
                                          showTitleActions: true,
                                          onChanged: (date) {
                                        print(
                                            'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                      }, onConfirm: (date) {
                                        // controller.dateSelected = date;
                                        // controller.updateSelectedDate();
                                      }, currentTime: DateTime.now())
                                    },
                                    child: Icon(
                                      Icons.flag_outlined,
                                      color: Get.theme.kLightGrayColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Visibility(
                                    visible: (!controller1
                                        .participants.value.isNotEmpty),
                                    child: InkWell(
                                      onTap: () => {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                const ContactListDialogPage())
                                      },
                                      child: Icon(
                                        Icons.people_alt_outlined,
                                        color: Get.theme.kLightGrayColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                                onTap: () => {controller.checkTaskValidation()},

                                // {controller.createNewTask()},
                                child: Text('Create'))
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )))
        },
        backgroundColor: Color(0xff253334),
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Color(0xffefefef),
        child: Stack(
          children: [
            // HeaderWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => {Get.to(() => const ProfilePage())},
                    icon: Hero(
                      tag: 'profile',
                      child: Material(
                        type: MaterialType.transparency,
                        child: CircleAvatar(
                          backgroundColor: Get.theme.colorPrimaryDark,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: Get.theme.colorPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () => {
                        Get.to(() => const NotificationPage())
                        // basicDialog('title', 'message')
                      },
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: Get.theme.btnTextCol,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: 110),
              child: Container(
                child: Image.asset(
                  "assets/google_icon.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            TeamStats(() => {}),
            DraggableScrollableSheet(
              initialChildSize: 0.94,
              minChildSize: 0.831,
              maxChildSize: 0.94,
              builder:
                  (BuildContext context, ScrollController myScrollController) {
                return ListView.builder(
                  controller: myScrollController,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 12),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 4.0),
                                  child: ActionChip(
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 1),
                                      shape: index == 0
                                          ? const StadiumBorder(
                                              side: BorderSide(
                                                  color: Color(0xff93dfd5)))
                                          : null,
                                      backgroundColor: index == 0
                                          ? Color(0xff93dfd5)
                                          : Colors.white,
                                      label: Text(
                                        "All",
                                        style: Get.theme.kSubTitle.copyWith(
                                          color: 0 == index
                                              ? Color(0xff253334)
                                              : Get.theme.kBadgeColor,
                                        ),
                                      ),
                                      onPressed: () => {print('hello')}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 4.0),
                                  child: ActionChip(
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 1),
                                      shape: index == 0
                                          ? const StadiumBorder(
                                              side: BorderSide(
                                                  color: Colors.transparent))
                                          : null,
                                      backgroundColor: index == 0
                                          ? Color.fromARGB(255, 230, 239, 240)
                                          : Colors.white,
                                      label: Text(
                                        "Personal",
                                        style: Get.theme.kSubTitle.copyWith(
                                          color: 0 == index
                                              ? Colors.black38
                                              : Get.theme.kBadgeColor,
                                        ),
                                      ),
                                      onPressed: () => {print('hello')}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 4.0),
                                  child: ActionChip(
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 1),
                                      shape: index == 0
                                          ? const StadiumBorder(
                                              side: BorderSide(
                                                  color: Colors.transparent))
                                          : null,
                                      backgroundColor: index == 0
                                          ? Color.fromARGB(255, 230, 239, 240)
                                          : Colors.white,
                                      label: Text(
                                        "Business",
                                        style: Get.theme.kSubTitle.copyWith(
                                          color: 0 == index
                                              ? Colors.black38
                                              : Get.theme.kBadgeColor,
                                        ),
                                      ),
                                      onPressed: () => {print('hello')}),
                                ),
                                ActionChip(
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 1),
                                    shape: index == 0
                                        ? const StadiumBorder(
                                            side: BorderSide(
                                                color: Colors.transparent))
                                        : null,
                                    backgroundColor: index == 0
                                        ? Color.fromARGB(255, 230, 239, 240)
                                        : Colors.white,
                                    label: Text(
                                      "Following",
                                      style: Get.theme.kSubTitle.copyWith(
                                        color: 0 == index
                                            ? Colors.black38
                                            : Get.theme.kBadgeColor,
                                      ),
                                    ),
                                    onPressed: () => {print('hello')}),
                              ],
                            ),
                          ),

                          SizedBox(height: 6),
                          // Container(
                          //   height: 40,
                          //   child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children:  [
                          // Container(
                          //   // frequentlyvisitedcx3 (1:446)
                          //   margin:  EdgeInsets.fromLTRB(20, 0, 0, 0),
                          //   child:
                          // Text(
                          //   'Created By Me\n',
                          //   textAlign:  TextAlign.center,
                          //   style:  GoogleFonts.plusJakartaSans (
                          //     fontSize:  18,
                          //     fontWeight:  FontWeight.w700,
                          //     // height:  1.4444444444,
                          //     letterSpacing:  0.09,
                          //     color:  Color(0xff111111),
                          //   ),
                          // ),
                          // ),
                          // Container(
                          //   // slidergwu (1:447)
                          //   margin:  EdgeInsets.fromLTRB(0, 0, 20 ,18),
                          //   height:  double.infinity,
                          //   child:
                          // Row(
                          //   crossAxisAlignment:  CrossAxisAlignment.center,
                          //   children:  [
                          // Container(
                          //   // dotPbR (1:448)
                          //   width:  24,
                          //   height:  8,
                          //   decoration:  BoxDecoration (
                          //     borderRadius:  BorderRadius.circular(100),
                          //     color:  Color(0xff009b8d),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width:  8,
                          // ),
                          // Container(
                          //   // dotgqR (1:449)
                          //   width:  8,
                          //   height:  8,
                          //   decoration:  BoxDecoration (
                          //     borderRadius:  BorderRadius.circular(4),
                          //     color:  Color(0xffd1d8dd),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width:  8,
                          // ),
                          // Container(
                          //   // dot171 (1:450)
                          //   width:  8,
                          //   height:  8,
                          //   decoration:  BoxDecoration (
                          //     borderRadius:  BorderRadius.circular(4),
                          //     color:  Color(0xffd1d8dd),
                          //   ),
                          // ),
                          //   ],
                          // ),
                          // ),
                          //   ],),
                          // ),
                          Container(
                              height: 700,
                              width: double.infinity,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('spark_assignedTasks')
                                      .where("due_date",
                                          isLessThanOrEqualTo: DateTime.now()
                                              .microsecondsSinceEpoch)
                                      .where("status", isEqualTo: "InProgress")
                                      // .where("to_uid", isEqualTo: currentUser?.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const Center(
                                        child:
                                            Text("Something went wrong! 😣..."),
                                      );
                                    } else if (snapshot.hasData) {
                                      return ListView.builder(
                                        physics: const BouncingScrollPhysics(),

                                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        //   crossAxisCount: 4,
                                        // ),
                                        itemCount: snapshot.data?.docs.length,
                                        controller: myScrollController,
                                        itemBuilder: (context, i) {
                                          return Column(
                                            children: [
                                              ListTaskCard(
                                                  snapshot.data?.docs[i])
                                              // SizedBox(height: 2),
                                              // Text(
                                              //   '${snapshot.data?.docs[index]['by_name'].substring(0, 2)}',
                                              //   style: TextStyle(
                                              //     color: Colors.black54,
                                              //     fontWeight: FontWeight.w500,
                                              //   ),
                                              // ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      // Default return statement
                                      return Container();
                                    }
                                  })),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: IconButton(
                  onPressed: () => {Get.to(() => const ProfilePage())},
                  icon: Hero(
                    tag: 'profile',
                    child: Material(
                      type: MaterialType.transparency,
                      child: CircleAvatar(
                        backgroundColor: Get.theme.colorPrimaryDark,
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: Get.theme.colorPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    onPressed: () => {
                      Get.to(() => const NotificationPage())
                      // basicDialog('title', 'message')
                    },
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Get.theme.btnTextCol,
                    ),
                  ),
                )
              ],
              elevation: 0,
              backgroundColor: Colors.white,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Text(
                      'Morning, ${FirebaseAuth.instance.currentUser!.displayName}',
                      style: Get.theme.kTitleStyle
                          .copyWith(color: Get.theme.btnTextCol),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 20),
                    child: Obx(
                      () => Text(
                        '${controller.donecount.value}/${controller.notdone.value + controller.donecount.value} Tasks pending',
                        style: Get.theme.kSubTitle.copyWith(
                            color: Get.theme.colorPrimaryDark.withOpacity(0.6)),
                      ),
                    ),
                  ),
                ],
              ),
              bottom: TabBar(
                  onTap: (value) => {
                        controller.tabIndex.value = value,
                      },
                  isScrollable: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  physics: const BouncingScrollPhysics(),
                  indicatorColor: Get.theme.colorPrimaryDark,
                  labelColor: Get.theme.colorPrimaryDark,
                  labelStyle: Get.theme.kTitleStyle,
                  unselectedLabelStyle: Get.theme.kNormalStyle,
                  unselectedLabelColor: Get.theme.btnTextCol.withOpacity(0.2),
                  tabs: [
                    Tab(
                        icon: Row(
                      children: [
                        const Text(
                          'Today',
                        ),
                        Obx(
                          () => tabTaskIndicator(
                              taskNum: controller.numOfTodayTasks.value,
                              index: 0,
                              controller: controller),
                        )
                      ],
                    )),
                    Tab(
                      icon: Row(
                        children: [
                          const Text(
                            'Upcoming',
                          ),
                          Obx(
                            () => tabTaskIndicator(
                                taskNum: controller.numOfUpcomingTasks.value,
                                index: 1,
                                controller: controller),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      icon: Row(
                        children: [
                          const Text(
                            'Created',
                          ),
                          Obx(
                            () => tabTaskIndicator(
                                taskNum: controller.numOfCreatedTasks.value,
                                index: 2,
                                controller: controller),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              // Get.to(() => const CreateTaskPage(isEditTask: false)),
              //              showModalBottomSheet(
              //                 context: context,
              //                 builder: (context) {
              //                   // return CreateTaskPage(isEditTask: false);
              //                   return Container(
              //                     width: MediaQuery.of(context).size.width,

              //                     padding: EdgeInsets.only(
              //                         bottom: MediaQuery.of(context).viewInsets.bottom),
              //                     margin: EdgeInsets.symmetric(horizontal: 16),
              //                     // child:

              //                       //   Column(
              //                       //     children: [
              //                       //       TextField(
              //                       //         decoration: InputDecoration(
              //                       //             border: InputBorder.none,
              //                       //             hintText: 'Enter task name'),
              //                       //         onSubmitted: (value) {
              //                       //           Navigator.pop(context);
              //                       //           var currentDate = DateTime.now();
              //                       //       DatePicker.showTimePicker(context,
              //                       //       showSecondsColumn: false,
              //                       //         showTitleActions: true,
              //                       //          onChanged: (date) {
              //                       // }, onConfirm: (date) {
              //                       //       if(value.isNotEmpty){
              //                       //         print('value is ${value} data is ${date}');
              //                       //       //  var task = Task.create(name: value, createdAt: date);
              //                       //       // base.dataStore.addTask(task: task);
              //                       //       }

              //                       // }, currentTime: DateTime.now());
              //                       //         },
              //                       //         autofocus: true,
              //                       //       ),
              //                       //     ],
              //                       //   ),
              //                     child: Column(
              //                       children: [
              //                             TextField(
              //                               decoration: InputDecoration(
              //                                   border: InputBorder.none,
              //                                   hintText: 'Task name'),
              //                                   style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
              //                               onSubmitted: (value) {
              //                                 Navigator.pop(context);
              //                                 var currentDate = DateTime.now();
              //                             DatePicker.showTimePicker(context,
              //                             showSecondsColumn: false,
              //                               showTitleActions: true,
              //                                onChanged: (date) {
              //                           }, onConfirm: (date) {
              //                             if(value.isNotEmpty){
              //                               print('value is ${value} data is ${date}');
              //                             //  var task = Task.create(name: value, createdAt: date);
              //                             // base.dataStore.addTask(task: task);
              //                             }

              //                           }, currentTime: DateTime.now());
              //                               },
              //                               autofocus: true,
              //                             ),
              //                              TextField(
              //                               decoration: InputDecoration(
              //                                   border: InputBorder.none,
              //                                   hintText: 'Description'),
              //                                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              //                               onSubmitted: (value) {
              //                                 Navigator.pop(context);
              //                                 var currentDate = DateTime.now();
              //                             DatePicker.showTimePicker(context,
              //                             showSecondsColumn: false,
              //                               showTitleActions: true,
              //                                onChanged: (date) {
              //                           }, onConfirm: (date) {
              //                             if(value.isNotEmpty){
              //                               print('value is ${value} data is ${date}');
              //                             //  var task = Task.create(name: value, createdAt: date);
              //                             // base.dataStore.addTask(task: task);
              //                             }

              //                           }, currentTime: DateTime.now());
              //                               },
              //                               autofocus: true,

              //                            ),
              //                           //  Container(
              //                           //   height:
              //                           //  child: null),
              //                             SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: Row(
              //         children: [
              //           Container(
              //     child:  Row(
              //       children: [
              //         IconButton(
              //       onPressed: () =>
              //           {
              //             // bottomSheetWidget(FilterScreen(), transparentBg: true)
              //                                         DatePicker.showDateTimePicker(context,
              //                           showTitleActions: true, onChanged: (date) {
              //                         print(
              //                             'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
              //                       }, onConfirm: (date) {
              //                         // controller.dateSelected = date;
              //                         // controller.updateSelectedDate();
              //                       }, currentTime: DateTime.now())
              //             },
              //       icon: Icon(
              //         Icons.people_rounded,
              //         color: Get.theme.kLightGrayColor,
              //       ),
              //     ),
              //         Text(
              //             "To",
              //             style: Get.theme.kSubTitle.copyWith(
              //               color: Get.theme.kBadgeColor

              //             ),
              //         ),
              //       ],
              //     )
              //   ),
              //  Padding(
              //    padding: const EdgeInsets.all(8.0),
              //    child: Container(
              //       child:  Row(
              //          mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           IconButton(
              //         onPressed: () =>
              //             {
              //               // bottomSheetWidget(FilterScreen(), transparentBg: true)
              //                                           DatePicker.showDateTimePicker(context,
              //                             showTitleActions: true, onChanged: (date) {
              //                           print(
              //                               'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
              //                         }, onConfirm: (date) {
              //                           // controller.dateSelected = date;
              //                           // controller.updateSelectedDate();
              //                         }, currentTime: DateTime.now())
              //               },
              //         icon: Icon(
              //           Icons.calendar_month_outlined,
              //           color: Get.theme.kLightGrayColor,
              //         ),
              //       ),
              //           Text(
              //               "Today",
              //               style: Get.theme.kSubTitle.copyWith(
              //                 color: Get.theme.kBadgeColor

              //               ),
              //           ),
              //         ],
              //       )
              //     ),
              //  ),
              //    Padding(
              //      padding: const EdgeInsets.all(8.0),
              //      child: Container(
              //       child:  Row(
              //         children: [
              //            Icon(
              //                       Icons.flag_outlined,
              //                       color: Get.theme.btnTextCol.withOpacity(0.3),
              //                     ),
              //           Text(
              //               "Priority",
              //               style: Get.theme.kSubTitle.copyWith(
              //                 color: Get.theme.kBadgeColor

              //               ),
              //           ),
              //         ],
              //       )
              //            ),
              //    )
              //         ],
              //       ),
              //     ),

              //                       ],
              //                     ),
              //                   );
              //                 })

              //       },

              // showModalBottomSheet(
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.vertical(top: Radius.circular(9.0))),
              // backgroundColor: Colors.white,
              // context: context,
              // isScrollControlled: true,
              // builder: (context) => Padding(
              //   padding: EdgeInsets.only(
              //                 bottom: MediaQuery.of(context).viewInsets.bottom,
              //                 left: 14.0,
              //                 right:14.0,
              //                 top: 10.0),
              //   child:     ContactListDialogPage())),

              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(9.0))),
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 14.0,
                          right: 14.0,
                          top: 10.0),
                      child: Form(
                        key: controller.taskKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              validator: controller.validateTaskTitle,
                              controller: controller.taskTitle,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Task name...'),
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500),
                              autofocus: true,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Description'),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                              onSubmitted: (value) {
                                Navigator.pop(context);
                                var currentDate = DateTime.now();
                                DatePicker.showTimePicker(context,
                                    showSecondsColumn: false,
                                    showTitleActions: true,
                                    onChanged: (date) {}, onConfirm: (date) {
                                  if (value.isNotEmpty) {
                                    print('value iss ${value} data is ${date}');
                                    //  var task = Task.create(name: value, createdAt: date);
                                    // base.dataStore.addTask(task: task);
                                  }
                                }, currentTime: DateTime.now());
                              },
                              autofocus: true,
                            ),
                            //  Container(
                            //   height:
                            //  child: null),
                            Visibility(
                              visible: !(controller.assignedUserName.value ==
                                  "Assign someone"),
                              child: Row(
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
                                                  shape: RoundedRectangleBorder(
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
                                              radius: 17,
                                              child: Text(
                                                  '${controller.assignedUserName.value.substring(0, 2)}',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                        Obx(() => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, bottom: 4),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 16,
                                                        child: Text(
                                                          'Assigned to',
                                                          style: Get
                                                              .theme.kSubTitle
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .kLightGrayColor),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 22,
                                                        child: Text(
                                                          controller
                                                              .assignedUserName
                                                              .value,
                                                          style: Get.theme
                                                              .kPrimaryTxtStyle
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
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

                                            ),
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
                                                      const EdgeInsets.all(6.0),
                                                  child: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 18,
                                                    color: Get
                                                        .theme.kLightGrayColor,
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
                                        Obx(() => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, bottom: 4),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 16,
                                                        child: Text(
                                                          'Due Date',
                                                          style: Get
                                                              .theme.kSubTitle
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .kLightGrayColor),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 22,
                                                        child: Text(
                                                            controller
                                                                .selectedDateTime
                                                                .value,
                                                            style: Get.theme
                                                                .kNormalStyle
                                                                .copyWith(
                                                                    color: Get
                                                                        .theme
                                                                        .kBadgeColor)),
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
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Visibility(
                                visible:
                                    (controller.attachmentsA.value.length > 0),
                                child: SizedBox(
                                    // height: 20,
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      // height: 20,
                                      child: Text(
                                        'Attachments',
                                        style: Get.theme.kSubTitle.copyWith(
                                            color: Color(0xff707070),
                                            fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              image = await picker.pickImage(
                                                  source: ImageSource.gallery);
                                              storageReference
                                                  .putFile(File(image!.path))
                                                  .then((value) async {
                                                controller.attachmentsA.value
                                                    .add(await value.ref
                                                        .getDownloadURL());
                                                print(
                                                    'Image URL: ${controller.attachmentsA.value}');
                                              });
                                            },
                                            child: DottedBorder(
                                              // borderType: BorderType.Circle,
                                              color: Get.theme.kLightGrayColor,
                                              radius: Radius.circular(27.0),
                                              dashPattern: [6, 8],
                                              strokeWidth: 1.5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(24.0),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 22,
                                                  color:
                                                      Get.theme.kLightGrayColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            child: Container(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: controller
                                                      .attachmentsA.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          Card(
                                                              child: Image(
                                                            image: NetworkImage(
                                                                controller
                                                                        .attachmentsA[
                                                                    index]),
                                                            // fit: BoxFit.fill,
                                                            width: 100,
                                                            height: 100,
                                                          ))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ))),

                            Visibility(
                              visible:
                                  (controller1.participants.value.isNotEmpty),
                              child: SizedBox(
                                // height: 20,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Participants',
                                      style: Get.theme.kSubTitle.copyWith(
                                          color: Color(0xff707070),
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
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
                                                color:
                                                    Get.theme.kLightGrayColor,
                                                radius: Radius.circular(27.0),
                                                dashPattern: [3, 3],
                                                strokeWidth: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 15,
                                                    color: Get
                                                        .theme.kLightGrayColor,
                                                  ),
                                                ),
                                              )),

                                          SizedBox(
                                            width: 4,
                                          ),
                                          Obx(
                                            () => SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.720,
                                              child: ListView.builder(
                                                itemCount: controller
                                                    .participantsANew
                                                    .value
                                                    .length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                    child: SizedBox(
                                                      child: Material(
                                                        type: MaterialType
                                                            .transparency,
                                                        child: CircleAvatar(
                                                          backgroundColor: Get
                                                              .theme
                                                              .colorPrimaryDark,
                                                          radius: 14,
                                                          child: Text(
                                                              '${controller.participantsANew[index]['name'].substring(0, 2)}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      10)),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          // Obx(
                                          //   () => SizedBox(
                                          //     height:
                                          //         MediaQuery.of(context).size.height * 0.04,
                                          //     width:
                                          //         MediaQuery.of(context).size.width * 0.720,
                                          //     child: ListView.builder(
                                          //       itemCount: controller_Contacts
                                          //           .participants.value.length,
                                          //       scrollDirection: Axis.horizontal,
                                          //       itemBuilder: (context, index) {
                                          //         return Padding(
                                          //           padding: const EdgeInsets.only(left:3.0),
                                          //           child: SizedBox(
                                          //             child: Material(
                                          //               type: MaterialType.transparency,
                                          //               child: CircleAvatar(
                                          //                 backgroundColor:
                                          //                     Get.theme.colorPrimaryDark,
                                          //                 radius: 14,
                                          //                 child: Text(
                                          //                     '${controller_Contacts.participants[index]['name'].substring(0, 2)}',
                                          //                     style: TextStyle(
                                          //                         color: Colors.white,
                                          //                         fontSize: 10)),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         );
                                          //       },
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: (controller
                                                .assignedUserName.value ==
                                            "Assign someone"),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () => {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Dialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child:
                                                                ContactListPage()))
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    color: Get
                                                        .theme.kLightGrayColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            InkWell(
                                              onTap: () => {
                                                DatePicker.showDateTimePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    onChanged: (date) {
                                                  print(
                                                      'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                                }, onConfirm: (date) {
                                                  controller.dateSelected =
                                                      date;
                                                  controller
                                                      .updateSelectedDate();
                                                }, currentTime: DateTime.now())
                                              },
                                              child: Icon(
                                                Icons.calendar_month_outlined,
                                                color:
                                                    Get.theme.kLightGrayColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: !(controller
                                                .attachmentsA.value.length >
                                            0),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    image =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    storageReference
                                                        .putFile(
                                                            File(image!.path))
                                                        .then((value) async {
                                                      controller.attachmentsA
                                                          .value = [
                                                        await value.ref
                                                            .getDownloadURL()
                                                      ];
                                                      print(
                                                          'Image URL: ${controller.attachmentsA.value}');
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.attach_file,
                                                    color: Get
                                                        .theme.kLightGrayColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.0,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => {
                                          DatePicker.showDateTimePicker(context,
                                              showTitleActions: true,
                                              onChanged: (date) {
                                            print(
                                                'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                          }, onConfirm: (date) {
                                            // controller.dateSelected = date;
                                            // controller.updateSelectedDate();
                                          }, currentTime: DateTime.now())
                                        },
                                        child: Icon(
                                          Icons.flag_outlined,
                                          color: Get.theme.kLightGrayColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Visibility(
                                        visible: (!controller1
                                            .participants.value.isNotEmpty),
                                        child: InkWell(
                                          onTap: () => {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    const ContactListDialogPage())
                                          },
                                          child: Icon(
                                            Icons.people_alt_outlined,
                                            color: Get.theme.kLightGrayColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                    onTap: () =>
                                        {controller.checkTaskValidation()},

                                    // {controller.createNewTask()},
                                    child: Text('Create'))
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      )))
            },
            backgroundColor: Get.theme.colorPrimaryDark,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                controller.streamToday(),
                controller.streamUpdates(),
                controller.streamCreated(),
              ]),
          bottomNavigationBar: BottomAppBar(
            elevation: 20,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            // onTap: controller.bottomBarOnTap,
            // currentIndex: controller.bottomBarIndex.value,
            // selectedItemColor: Get.theme.colorPrimaryDark,
            // unselectedItemColor: Get.theme.btnTextCol.withOpacity(0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => {
                          bottomSheetWidget(ReportPage(), transparentBg: true),
                        },
                    icon:
                        Icon(Icons.menu_rounded, color: Get.theme.btnTextCol)),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => {
                              // BasicDialog(
                              //     title: 'title',
                              //     message: 'message',
                              //     button1: 'button1',
                              //     tapFeatures: () => {}),
                              Get.to(() => const SearchPage())
                            },
                        icon: Icon(Icons.search_outlined,
                            color: Get.theme.btnTextCol.withOpacity(0.3))),
                    IconButton(
                      onPressed: () => {
                        snackBarMsg('Task Done!', enableMsgBtn: true),
                      },
                      icon: Icon(Icons.filter_list_rounded,
                          color: Get.theme.btnTextCol.withOpacity(0.3)),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget tabTaskIndicator(
      {required int taskNum,
      required int index,
      required HomePageController controller}) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: index == controller.tabIndex.value
              ? Get.theme.colorPrimaryDark
              : null,
          borderRadius: BorderRadius.circular(12),
          border: index != controller.tabIndex.value
              ? Border.all(width: 2.0, color: Get.theme.curveBG)
              : null,
        ),
        child: Text(
          '$taskNum',
          style: Get.theme.kSubTitle.copyWith(
            color: index == controller.tabIndex.value
                ? Colors.white
                : Get.theme.btnTextCol.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

Widget firstTab() {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        // taskCheckBox(
        //     taskPriority: 1,
        //     taskPriorityNum: 2,
        //     selected: false,
        //     task:
        //         'Collect insurance documents from Mr.Rajesh Sales Plan for New Product',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // taskCheckBox(
        //     taskPriority: 2,
        //     taskPriorityNum: 2,
        //     selected: false,
        //     task: 'Sales Plan for New Product',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 0,
        //     selected: false,
        //     task: 'Check Screens for Todo',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 0,
        //     selected: false,
        //     task: 'Check Screens for Todo',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 0,
        //     selected: false,
        //     task: 'Check Screens for Todo',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 0,
        //     selected: false,
        //     task: 'Check Screens for Todo',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
      ],
    ),
  );
}

Widget secondTab() {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        DateWidget('Tommorow'),
        // taskCheckBox(
        //     taskPriority: 1,
        //     taskPriorityNum: 4,
        //     selected: true,
        //     task: 'Preparing the images that will be used in the email A',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // DateWidget('14 Aug'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 0,
        //     selected: false,
        //     task: 'Make sure the product is working',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // taskCheckBox(
        //     taskPriority: 1,
        //     taskPriorityNum: 4,
        //     selected: false,
        //     task: 'Writing a description for the blog post A',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 0,
        //     selected: false,
        //     task: 'Preparing the email structure',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // DateWidget('15 Aug'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 0,
        //     selected: false,
        //     task: 'Finding the winner of the test',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
      ],
    ),
  );
}

Widget _bottomSheet(ScrollController controller) {
  return SingleChildScrollView(
    physics: ClampingScrollPhysics(),
    controller: controller,
    child: Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          headerBg(
              title: 'Gif Design for page loading',
              createdOn: 'Created: 12 August | 11:00 PM',
              taskPriority: 1,
              taskPriorityNum: 2),
          miniMessage('Marked as done, pending for review'),
          DateWidget('Due Tommorow'),
        ],
      ),
    ),
  );
}

Widget thirdTab() {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        headerBg(
            title: 'Gif Design for page loading',
            createdOn: 'Created: 12 August | 11:00 PM',
            taskPriority: 1,
            taskPriorityNum: 2),
        miniMessage('Marked as done, pending for review'),
        DateWidget('Due Tommorow'),
        // taskCheckBox(
        //     taskPriority: 2,
        //     taskPriorityNum: 4,
        //     selected: false,
        //     task: 'Completing the post in the new product page',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assigner: Mr. Tejesh'),
        // DateWidget('14 Aug'),
        // taskCheckBox(
        //     taskPriority: 1,
        //     taskPriorityNum: 2,
        //     selected: false,
        //     task: 'Going throuh bug report list',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assignee: Mr. Anshu'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 4,
        //     selected: false,
        //     task: 'Updating & Testing the colour selection',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assignee: Mr. Tejesh'),
        // DateWidget('15 Aug'),
        // taskCheckBox(
        //     taskPriority: 3,
        //     taskPriorityNum: 0,
        //     selected: false,
        //     task: 'Presentation Regarding',
        //     createdOn: 'Created: 12 August | 11:00 PM',
        //     assigner: 'Assignee: Mr. Tejesh'),
      ],
    ),
  );
}

Widget ListTaskCard(taskData) {
  return Container(
    // group2Q6P (0:87)
    margin: EdgeInsets.fromLTRB(8, 0, 8, 2),
    padding: EdgeInsets.fromLTRB(16, 12, 14, 10),
    width: double.infinity,
    // decoration:  BoxDecoration (
    //   color:  Color(0xffffffff),
    //   borderRadius:  BorderRadius.circular(20),
    // ),

    decoration: BoxDecoration(
      // color:  Color.fromARGB(255, 185, 176, 176),
      //  color:  Color.fromARGB(255, 236, 225, 225),
      //  color:  Color.fromARGB(255, 149, 207, 211),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          // colors: [
          //   Color.fromRGBO(69, 115, 201, 1),
          //   Color.fromRGBO(69, 115, 201, 1),
          // ],
          // next best color
          //  colors: [ Color(0xffBDFDE2),Color.fromARGB(47, 161, 231, 151),  ]
          colors: [
            Color(0xffBDFDE2),
            Color.fromARGB(255, 160, 217, 221),
          ]),

      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color(0x05000000),
          offset: Offset(0, -7),
          blurRadius: 11.5,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // autogroupf9tp3v3 (9JUJhq7xoDqoL7F1yVf9tP)
          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
          width: double.infinity,
          height: 21,
          // color: Colors.black,
          child: Row(
            // crossAxisAlignment:  CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // frame9wkX (0:97)

                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // design2appscreens3oZ (0:98)
                      width: 200,

                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        taskData["task_title"],
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.workSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          // height:  1.1730000178,
                          letterSpacing: -0.09,
                          decoration: TextDecoration.lineThrough,
                          color: Color(0xff000b23),
                          decorationColor: Color(0xff000b23),
                        ),
                      ),
                    ),
// Text(
//   // cryptowalletappht7 (0:99)
//   'Crypto Wallet App',
//   textAlign:  TextAlign.left,
//   style:  GoogleFonts.workSans (

//     fontSize:  12,
//     fontWeight:  FontWeight.w400,
//     height:  1.1730000178,
//     letterSpacing:  -0.06,
//     color:  Color(0xff7b7b7b),
//   ),
// ),
                  ],
                ),
              ),
              Container(
                // mon10july20224PD (0:96)
                margin: EdgeInsets.fromLTRB(0, 1.9, 0, 0),
                child: Text(
                  // DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date'))),
                  DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date'))
                      .toString(),
                  textAlign: TextAlign.right,
                  style: GoogleFonts.workSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    // height:  1.1730000178,
                    letterSpacing: -0.06,
                    color: Color(0xff7b7b7b),
                  ),
                ),
              ),
            ],
          ),
        ),

// Container(
//   // line2fyM (0:100)
//   margin:  EdgeInsets.fromLTRB(0, 0, 0, 4),
//   width:  double.infinity,
//   height:  1,
//   decoration:  BoxDecoration (
//     color:  Color(0xffdfdfdf),
//   ),
// ),
        Container(
          // autogroup8pgfaqR (9JUKHtyXruTzzxrxZ38PgF)
          margin: EdgeInsets.fromLTRB(0, 0, 0.22, 0),
          width: double.infinity,
          height: 28.78,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // autogroupjrfzsJj (9JUKtxoSL6UPnmppD7JRFZ)
                padding: EdgeInsets.fromLTRB(0, 4.5, 109, 5.78),
                height: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.comment_sharp,
                      size: 9,
                      color: Get.theme.btnTextCol.withOpacity(0.3),
                    ),
                    Text(
                      " 0 ",
                      style: Get.theme.kPrimaryTxtStyle.copyWith(
                          color:
                              Color.fromARGB(255, 27, 27, 27).withOpacity(0.62),
                          fontSize: 12),
                    ),

                    SizedBox(width: 4),

                    Icon(
                      Icons.attach_file_rounded,
                      size: 9,
                      color: Get.theme.btnTextCol.withOpacity(0.3),
                    ),
                    Text(
                      "0",
                      style: Get.theme.kPrimaryTxtStyle.copyWith(
                          color:
                              Color.fromARGB(255, 27, 27, 27).withOpacity(0.62),
                          fontSize: 12),
                    ),
                    SizedBox(width: 6),

                    Container(
                      // autogroup8zg38P5 (9JUKcPSirn3YiciPVq8zg3)
                      width: 89.78,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            // ellipse12FCo (0:90)
                            left: 4,
                            top: 1,
                            child: Align(
                              child: SizedBox(
                                width: 14.78,
                                height: 14.78,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(14.3912858963),
                                    color: Color(0xffd9d9d9),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://cdn3d.iconscout.com/3d/premium/thumb/boy-avatar-6299533-5187865.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

// Container(
//   // curvedcalendarNFV (0:94)
//   margin:  EdgeInsets.fromLTRB(0, 0, 9.5, 0),
//   width:  17,
//   height:  18.5,
//   child:
// Image.network(
//   "https://cdn3d.iconscout.com/3d/premium/thumb/boy-avatar-6299533-5187865.png",
//   width:  17,
//   height:  18.5,
// ),
// ),
                  ],
                ),
              ),
// Container(
//   // mon10july20224PD (0:96)
//   margin:  EdgeInsets.fromLTRB(0, 0.5, 0, 0),
//   child:
// Text(
//   DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(taskData.get('due_date'))),
//   textAlign:  TextAlign.right,
//   style:  GoogleFonts.workSans (
//     fontSize:  12,
//     fontWeight:  FontWeight.w400,
//     height:  1.1730000178,
//     letterSpacing:  -0.06,
//     color:  Color(0xff7b7b7b),
//   ),
// ),
// ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _contactFilterChip(int index,
    {required String title,
    required ReAssignController controller,
    required VoidCallback onTap}) {
  return Padding(
    padding: index == 0
        ? const EdgeInsets.only(left: 20, right: 5, top: 8, bottom: 8)
        : const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
    child: Obx(
      () => ActionChip(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          shape: index != controller.selectedIndex.value
              ? const StadiumBorder(side: BorderSide(color: Colors.black26))
              : null,
          backgroundColor: index == controller.selectedIndex.value
              ? Get.theme.colorPrimaryDark
              : Colors.white,
          label: Text(
            title,
            style: Get.theme.kSubTitle.copyWith(
              color: controller.selectedIndex.value == index
                  ? Colors.white
                  : Get.theme.kBadgeColor,
            ),
          ),
          onPressed: onTap),
    ),
  );
}
