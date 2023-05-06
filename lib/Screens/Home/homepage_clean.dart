import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/Contact/contact_list_dialog.dart';
import 'package:redefineerp/Screens/Contact/contact_list_page.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Home/homepage2.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/Home/homepage_gradient.dart';
import 'package:redefineerp/Screens/Notification/notification_pages.dart';
import 'package:redefineerp/Screens/Profile/profile_page.dart';
import 'package:redefineerp/Screens/Report/report_page.dart';
import 'package:redefineerp/Screens/Report/slim_team_stats.dart';
import 'package:redefineerp/Screens/Report/team_stats.dart';
import 'package:redefineerp/Screens/Search/search_task.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
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
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
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
    // Set the system status bar color

    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Color(0xff000032),

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 0.0,
          title: FxText.titleLarge(
            "TaskMan",
            fontWeight: 600,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),

            IconButton(
              onPressed: () => {Get.to(() => const NotificationPage())},
              icon: Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () => {Get.to(() => const ProfilePage())},
              icon: Hero(
                tag: 'profile',
                child: Material(
                  type: MaterialType.transparency,
                  child: CircleAvatar(
                    backgroundColor: Color(0xffe6e7fd),
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      color: Colors.black38,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            // PopupMenuButton(
            //   itemBuilder: (BuildContext context) => [
            //     PopupMenuItem(
            //       child: Text('Settings'),
            //     ),
            //   ],
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
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
                                hintText: 'Task name...555'),
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
                                        builder: (BuildContext context) =>
                                            Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: ContactListPage()))
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
                                                    controller
                                                        .assignedUserName.value,
                                                    style: Get
                                                        .theme.kPrimaryTxtStyle
                                                        .copyWith(
                                                            color: Get.theme
                                                                .kBadgeColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
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
                                      Obx(() => Padding(
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
                                                        style: Get
                                                            .theme.kSubTitle
                                                            .copyWith(
                                                                color: Get.theme
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
                                        color: Color(0xff707070), fontSize: 16),
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
                                              scrollDirection: Axis.horizontal,
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
                                                                fontSize: 10)),
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
          backgroundColor: Color(0xffBDA1EF),
          child: const Icon(
            Icons.add,
            color: Color(0xff33264b),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0xffffffff),
                  snap: false,
                  pinned: true,
                  floating: true,
                  // flexibleSpace:
                  //     FlexibleSpaceBar(background: SlimTeamStats(() => {})),
                  expandedHeight: 190,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(48.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 4.0),
                            child: ActionChip(
                                elevation: 0,
                                padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
                                backgroundColor: 0 == 0
                                    ? Get.theme.primaryContainer
                                    : Colors.transparent,
                                label: FxText.bodySmall(
                                  "All Tasks",
                                  fontSize: 11,
                                  fontWeight: 700,
                                  color: 0 == 0
                                      ? Get.theme.onPrimaryContainer
                                      : Get.theme.colorScheme.onBackground,
                                ),
                                onPressed: () => {print('hello')}),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 4.0),
                            child: ActionChip(
                                elevation: 0,
                                padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
                                backgroundColor: 1 == 0
                                    ? Get.theme.primaryContainer
                                    : Colors.transparent,
                                label: FxText.bodySmall(
                                  "Personal",
                                  fontSize: 11,
                                  fontWeight: 700,
                                  color: 1 == 0
                                      ? Get.theme.onPrimaryContainer
                                      : Get.theme.onBackground,
                                ),
                                onPressed: () => {print('hello')}),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 4.0),
                            child: ActionChip(
                                elevation: 0,
                                padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
                                backgroundColor: 1 == 0
                                    ? Get.theme.primaryContainer
                                    : Colors.transparent,
                                label: FxText.bodySmall(
                                  "Business",
                                  fontSize: 11,
                                  fontWeight: 700,
                                  color: 1 == 0
                                      ? Get.theme.onPrimaryContainer
                                      : Get.theme.onBackground,
                                ),
                                onPressed: () => {print('hello')}),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 4.0),
                            child: ActionChip(
                                elevation: 0,
                                padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
                                backgroundColor: 1 == 0
                                    ? Get.theme.primaryContainer
                                    : Colors.transparent,
                                label: FxText.bodySmall(
                                  "Participants",
                                  fontSize: 11,
                                  fontWeight: 700,
                                  color: 1 == 0
                                      ? Get.theme.onPrimaryContainer
                                      : Get.theme.onBackground,
                                ),
                                onPressed: () => {print('hello')}),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                controller.streamToday(),
                controller.streamUpdates(),
                controller.streamCreated(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xffffffff),
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
                  icon: Icon(Icons.menu_rounded, color: Get.theme.btnTextCol)),
              Row(
                children: [
                  IconButton(
                      onPressed: () => {
                            // BasicDialog(
                            //     title: 'title',
                            //     message: 'message',
                            //     button1: 'button1',
                            //     tapFeatures: () => {}),
                            Get.to(() => HomeGradientPage())
                          },
                      icon: Icon(Icons.home,
                          color: Get.theme.btnTextCol.withOpacity(0.3))),
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
        ));
  }

  Widget tabTaskIndicator(
      {required int taskNum,
      required BuildContext context,
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
          style: TextStyle(
              color: index == controller.tabIndex.value
                  ? Colors.white
                  : Get.theme.btnTextCol.withOpacity(0.3),
              fontSize: MediaQuery.of(context).size.height * 0.017),
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
