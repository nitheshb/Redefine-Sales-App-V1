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
import 'package:redefineerp/Screens/Search/search_controller.dart';
import 'package:redefineerp/Screens/Search/search_task.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Screens/Task/task_manager.dart';
import 'package:redefineerp/Utilities/basicdialog.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Utilities/snackbar.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:redefineerp/Widgets/datewidget.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final storageReference =
      FirebaseStorage.instance.ref().child('images/image.jpg');

  ImagePicker picker = ImagePicker();

  // var businessMode = true;
// 
  //  flipMode() {
  //   setState(() {
  //     businessMode = !businessMode;
      
  //   });
   
  // }

  // void initState() {
  //   // time = filterTime.first;
  //   businessMode = true;
  // }

  XFile? image;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomePageController>(HomePageController());
    final controller1 = Get.put<ContactController>(ContactController());
    SearchController searchController =
        Get.put<SearchController>(SearchController());
    // TaskController controller1 = Get.put<TaskController>(TaskController());
    debugPrint("home called ${FirebaseAuth.instance.currentUser}");
    // Set the system status bar color

    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Color(0xff000032),

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 0.0,
          title: controller.expande.value == true
              ? TextField(
                  controller: controller.searchText,
                  onChanged: (v) {
                    if (v == '') {
                      searchController.searchResultsWidget.value =
                          searchController.searchResults('');
                      controller.search.value = false;
                    } else {
                      controller.search.value = true;
                    }
                    searchController.searchResultsWidget.value =
                        searchController.searchResults(v);

                    print(searchController.searchResultsWidget.value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {
                            controller.search.value = false;
                            controller.expande.value = false;
                          },
                          icon: Icon(Icons.arrow_back)),
                      hintText: 'Search'),
                )
              : titleRow(),
          actions: controller.expande.value == true
              ? []
              : [
                  IconButton(
                    icon: Icon(Icons.search,
                        color: Get.theme.btnTextCol.withOpacity(0.3)),
                    onPressed: () {
                      // Get.to(() => const SearchPage());
                      controller.expande.value = true;
                      print(controller.expande.value);
                    },
                  ),

                  IconButton(
                      onPressed: () => {Get.to(() => const NotificationPage())},
                      icon: const Icon(Icons.notifications),
                      color: Get.theme.btnTextCol.withOpacity(0.3)),
                  //  IconButton(

                  //                   onPressed: () => {Get.to(() => const ProfilePage())},
                  //                   icon: Hero(
                  //                     tag: 'profile',
                  //                     child: Material(
                  //                       type: MaterialType.transparency,
                  //                       child: CircleAvatar(
                  //                         backgroundColor: Color(0xffe6e7fd),
                  //                         radius: 30,
                  //                         child: Icon(
                  //                           Icons.person,
                  //                           color: Colors.black38,
                  //                           size: 20,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  // // PopupMenuButton(
                  //   itemBuilder: (BuildContext context) => [
                  //     PopupMenuItem(
                  //       child: Text('Settings'),
                  //     ),
                  //   ],
                  // ),
                ],
        ),

        //  IconButton(
                           
        //                   onPressed: () => {Get.to(() => const ProfilePage())},
        //                   icon: Hero(
        //                     tag: 'profile',
        //                     child: Material(
        //                       type: MaterialType.transparency,
        //                       child: CircleAvatar(
        //                         backgroundColor: Color(0xffe6e7fd),
        //                         radius: 30,
        //                         child: Icon(
        //                           Icons.person,
        //                           color: Colors.black38,
        //                           size: 20,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        // // PopupMenuButton(
        //   itemBuilder: (BuildContext context) => [
        //     PopupMenuItem(
        //       child: Text('Settings'),
        //     ),
        //   ],
        // ),
      // ],
    
    // ),
        floatingActionButton: FloatingActionButton.extended(

          onPressed: () => {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
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
                            onChanged: controller.validateTaskTitle,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Task name...'),
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                            autofocus: true,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Description'),
                            style: const TextStyle(
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
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),

                                    Padding(
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
                                              radius:
                                                  const Radius.circular(27.0),
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

                          const SizedBox(
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
                                          color: const Color(0xff707070),
                                          fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
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
                                            radius: const Radius.circular(27.0),
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
                                        color: const Color(0xff707070),
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
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
                                              radius:
                                                  const Radius.circular(27.0),
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

                                        const SizedBox(
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
                                                            style:
                                                                const TextStyle(
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
                          const SizedBox(height: 15),

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
                                                              const ContactListPage()))
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
                                          const SizedBox(
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
                                          const SizedBox(
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
                                              const SizedBox(
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
                                    const SizedBox(
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
                                  onTap: () => {
                                        controller.validationSuccess.value =
                                            false,
                                        // print(
                                        //     controller.validationSuccess.value),
                                        controller.checkTaskValidation()
                                      },

                                  // {controller.createNewTask()},
                                  child: Obx(
                                    () => CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height *
                                              0.030,
                                      backgroundColor:
                                          controller.validationSuccess.value ==
                                                  true
                                              ? Get.theme.primaryContainer
                                              : Colors.grey,
                                      child: Icon(
                                        Icons.send,
                                        color: controller
                                                    .validationSuccess.value ==
                                                true
                                            ? Colors.blue
                                            : const Color.fromARGB(
                                                255, 62, 62, 62),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    )))
          },

          backgroundColor: Color(0xffBDA1EF),
          label: Text('Add Task'),
          icon:       const Icon(
                Icons.add,
                // color: Color(0xff33264b),
              ),
          // child: Row(
          //   children: [
          //     Text('Aedd Task'),
          //     const Icon(
          //       Icons.add,
          //       color: Color(0xff33264b),
          //     ),
          //   ],
          // ),
        ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.,
      
      body: DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            
            SliverAppBar(
              backgroundColor: Color(0xffffffff),
               snap: false,
          pinned: true,
              floating: true,
              flexibleSpace: Obx(()=>FlexibleSpaceBar(background: SlimTeamStats(controller.flipMode,controller.businessMode.value, controller.numOfTodayTasks, controller.myBusinessTotal))),
              expandedHeight: 190,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48.0),
                child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child:
                Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
  if(controller.businessMode.value)...[ Padding(
                     padding: const EdgeInsets.only(left:6.0, right:4.0),
                     child: ActionChip(
                               elevation: 0,
                               padding: const EdgeInsets.fromLTRB(6,1,6,1),
                               
                               backgroundColor: 0 == 0
                                  ? Get.theme.primaryContainer
                                   : Colors.transparent,
                    
                      label: FxText.bodySmall(
                  "My Tasks",
                  fontSize: 11,
                  fontWeight: 700,
                  color: 0 == 0
                      ? Get.theme.onPrimaryContainer
                      : Get.theme.colorScheme.onBackground,
                                ),
                               onPressed: ()=> {
                                 print('hello')
                               }),
                   ),
                   

                   Visibility(
                    visible:false,
                      maintainSize: true, 
  maintainAnimation: true,
  maintainState: true,
                     child: Padding(
                       padding: const EdgeInsets.only(left:2.0, right:4.0),
                       child: ActionChip(
                                 elevation: 0,
                                 padding: const EdgeInsets.fromLTRB(6,1,6,1),
                                 
                                 backgroundColor: 0 == 0
                                    ? Get.theme.primaryContainer
                                     : Colors.transparent,
                      
                        label: FxText.bodySmall(
                                     "My Tasks adfafafaf adffafafafdas adfafafaf adfadfafafafaff",
                                     fontSize: 11,
                                     fontWeight: 700,
                                     color: 0 == 0
                        ? Get.theme.onPrimaryContainer
                        : Get.theme.colorScheme.onBackground,
                                  ),
                                 onPressed: ()=> {
                                   print('hello')
                                 }),
                     ),
                   ),
                   
                   ]
                 else...[  Obx(() => Padding(
                     padding: const EdgeInsets.only(left:8.0, right:4.0),
                     child: ActionChip(
                               elevation: 0,
                               padding: const EdgeInsets.fromLTRB(6,1,6,1),
                               
                               backgroundColor:controller.myTaskTypeCategory.value == 'allBusinessTasks'
                                  ? Get.theme.primaryContainer
                                   : Colors.transparent,
                    
                      label: FxText.bodySmall(
                  "All Tasks",
                  fontSize: 11,
                  fontWeight: 700,
                  color: controller.myTaskTypeCategory.value == 'allBusinessTasks'
                      ? Get.theme.onPrimaryContainer
                      : Get.theme.onBackground,
                                ),
                               onPressed: ()=> {
                                 controller.setTaskTypeFun('allBusinessTasks')
                               }),
                   ),),
                   Obx(() => Padding(
                     padding: const EdgeInsets.only(left:2.0, right:4.0),
                     child: InkWell(
                      onTap:()=>{
                        controller.setTaskTypeFun('assignedToMe')
                      },
                       child: ActionChip(
                                 elevation: 0,
                                 padding: const EdgeInsets.fromLTRB(6,1,6,1),
                               
                                 backgroundColor: controller.myTaskTypeCategory.value == 'assignedToMe'
                                    ? Get.theme.primaryContainer
                                     : Colors.transparent,
                                         
                        label: FxText.bodySmall(
                                       "Assigned to me",
                                       fontSize: 11,
                                       fontWeight: 700,
                                       color: controller.myTaskTypeCategory.value == 'assignedToMe'
                        ? Get.theme.onPrimaryContainer
                        : Get.theme.onBackground,
                                  ),
                                 onPressed: ()=> {
                                   print('hello ${controller.myTaskTypeCategory.value == 'assignedToMe'}'),
                        controller.setTaskTypeFun('assignedToMe')

                                 }),
                     ),
                   ),),
              Obx(() =>  Padding(
                     padding: const EdgeInsets.only(left:2.0, right:4.0),
                     child: ActionChip(
                               elevation: 0,
                               padding: const EdgeInsets.fromLTRB(6,1,6,1),
                               
                               backgroundColor: controller.myTaskTypeCategory == 'creatdByMe'
                                  ? Get.theme.primaryContainer
                                   : Colors.transparent,
                    
                      label: FxText.bodySmall(
                  "Created by me",
                  fontSize: 11,
                  fontWeight: 700,
                  color: controller.myTaskTypeCategory == 'creatdByMe'
                      ? Get.theme.onPrimaryContainer
                      : Get.theme.onBackground,
                                ),
                               onPressed: ()=> {
                                 print('hello'),
                                   controller.setTaskTypeFun('creatdByMe')
                               }),
                   ),),
            Obx(() =>  Padding(
                     padding: const EdgeInsets.only(left:2.0, right:4.0),
                     child: ActionChip(
                               elevation: 0,
                               padding: const EdgeInsets.fromLTRB(6,1,6,1),
                               
                               backgroundColor: controller.myTaskTypeCategory == 'participants'
                                  ? Get.theme.primaryContainer
                                   : Colors.transparent,
                    
                      label: FxText.bodySmall(
                  "Participants",
                  fontSize: 11,
                  fontWeight: 700,
                  color: controller.myTaskTypeCategory == 'participants'
                      ? Get.theme.onPrimaryContainer
                      : Get.theme.onBackground,
                                ),
                               onPressed: ()=> {
                                
                                 controller.setTaskTypeFun('participants'),
                                  print('hello ${controller.myTaskTypeCategory == 'participants'}'),
                               }),
                   ),),
                   ],                           
                   
                                        ],
                  ),
                ),
              ),),
          
           
            ),
          ];
        },
        // body: controller.streamToday()
        body: 
                     StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('spark_assignedTasks')
            .where("due_date",
                isLessThanOrEqualTo: DateTime.now().microsecondsSinceEpoch)
            .where("status", isEqualTo: "InProgress")
            // .where("to_uid", isEqualTo: controller.currentUser!.uid)
            //  .where("particpantsA", arrayContains: controller.currentUser!.uid)
            .where('particpantsIdA', arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        // stream: DbQuery.instanace.getStreamCombineTasks(),
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
       
             print('pub dev is ${TotalTasks}');
            if(!controller.businessMode.value){
              // business list

              
                      // controller.businessData.value= TotalTasks.where((element) => (element["by_uid"] != element["to_uid"]) && (element["by_uid"] == FirebaseAuth.instance.currentUser!.uid || element["to_uid"] == FirebaseAuth.instance.currentUser!.uid)).toList(); 
                        // controller.totalTasksStreamData.value = businessData;
                      

            }else{
            //  controller.personalData.value= TotalTasks.where((element) => element["by_uid"] == FirebaseAuth.instance.currentUser!.uid && element["to_uid"] == FirebaseAuth.instance.currentUser!.uid).toList(); 
            }

          // particpantsIdA

          // return Text('Full Data');
             return Obx(() => Column(
                  children: [
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.totalTasksStreamData.length,
                              itemBuilder: (context, index) {
                                late QueryDocumentSnapshot<Object?>? taskData =
                                    controller.totalTasksStreamData[index];
                                print("qwdqwdw ${taskData!.id}");

                                var iDa  = [taskData!['to_uid'], taskData!['by_uid']];
                                DbQuery.instanace.getAddParticipants(taskData!.id, iDa);

                                // taskController.setAssignDetails(taskData?.id, taskData!['to_uid'], taskData['to_name']);
                                // print(
                                //     "date is ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
                                // print("due date is ${taskData!.get('due data')}");
                                // return Text("hello");
                                return controller.CardSetup(context,taskData);  }),
                        ),
                      ),
                    ),
                  ],
                ));
             
            }else{
              return Text('No Data');
            }}),
               
        // body: TabBarView(
        //   children: [
        //       controller.streamToday(),
        //       controller.streamUpdates(),
        //       controller.streamCreated(),
        //     ],
        // ),

          // backgroundColor: const Color(0xffBDA1EF),
          // child: const Icon(
          //   Icons.add,
          //   color: Color(0xff33264b),
          // ),
        ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.,

      //   body: DefaultTabController(
      //     length: 3,
      //     child: NestedScrollView(
      //         headerSliverBuilder:
      //             (BuildContext context, bool innerBoxIsScrolled) {
      //           return <Widget>[
      //             Obx(
      //               () => SliverAppBar(
      //                 backgroundColor: const Color(0xffffffff),
      //                 snap: false,
      //                 pinned: true,
      //                 floating: true,
      //                 flexibleSpace: FlexibleSpaceBar(
      //                     background: controller.expande.value == true
      //                         ? controller.search.value == true
      //                             ? SizedBox()
      //                             : Wrap(
      //                                 children: [
      //                                   _filterChip(0,
      //                                       title: 'All',
      //                                       controller: searchController,
      //                                       onTap: () => {
      //                                             searchController
      //                                                 .selectedIndex.value = 0,
      //                                           }),
      //                                   _filterChip(1,
      //                                       title: 'Done',
      //                                       controller: searchController,
      //                                       onTap: () => {
      //                                             searchController
      //                                                 .selectedIndex.value = 1,
      //                                           }),
      //                                   _filterChip(2,
      //                                       title: 'Pending',
      //                                       controller: searchController,
      //                                       onTap: () => {
      //                                             searchController
      //                                                 .selectedIndex.value = 2,
      //                                           }),
      //                                   _filterChip(3,
      //                                       title: 'Created',
      //                                       controller: searchController,
      //                                       onTap: () => {
      //                                             searchController
      //                                                 .selectedIndex.value = 3,
      //                                           }),
      //                                   _filterChip(4,
      //                                       title: 'Today',
      //                                       controller: searchController,
      //                                       onTap: () => {
      //                                             searchController
      //                                                 .selectedIndex.value = 4,
      //                                           }),
      //                                 ],
      //                               )
      //                         : SlimTeamStats(() => {})),
      //                 expandedHeight: controller.search.value == true
      //                     ? 10
      //                     : controller.expande.value == true
      //                         ? 69
      //                         : 190,
      //                 bottom: PreferredSize(
      //                   preferredSize: const Size.fromHeight(48.0),
      //                   child: controller.expande.value == true
      //                       ? SizedBox()
      //                       : SingleChildScrollView(
      //                           physics: const BouncingScrollPhysics(),
      //                           scrollDirection: Axis.horizontal,
      //                           child: Row(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             mainAxisAlignment: MainAxisAlignment.start,
      //                             children: [
      //                               Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     left: 2.0, right: 4.0),
      //                                 child: ActionChip(
      //                                     elevation: 0,
      //                                     padding: const EdgeInsets.fromLTRB(
      //                                         6, 1, 6, 1),
      //                                     backgroundColor: 0 == 0
      //                                         ? Get.theme.primaryContainer
      //                                         : Colors.transparent,
      //                                     label: FxText.bodySmall(
      //                                       "All Tasks",
      //                                       fontSize: 11,
      //                                       fontWeight: 700,
      //                                       color: 0 == 0
      //                                           ? Get.theme.onPrimaryContainer
      //                                           : Get.theme.colorScheme
      //                                               .onBackground,
      //                                     ),
      //                                     onPressed: () => {print('hello')}),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     left: 2.0, right: 4.0),
      //                                 child: ActionChip(
      //                                     elevation: 0,
      //                                     padding: const EdgeInsets.fromLTRB(
      //                                         6, 1, 6, 1),
      //                                     backgroundColor: 1 == 0
      //                                         ? Get.theme.primaryContainer
      //                                         : Colors.transparent,
      //                                     label: FxText.bodySmall(
      //                                       "Personal",
      //                                       fontSize: 11,
      //                                       fontWeight: 700,
      //                                       color: 1 == 0
      //                                           ? Get.theme.onPrimaryContainer
      //                                           : Get.theme.onBackground,
      //                                     ),
      //                                     onPressed: () => {print('hello')}),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     left: 2.0, right: 4.0),
      //                                 child: ActionChip(
      //                                     elevation: 0,
      //                                     padding: const EdgeInsets.fromLTRB(
      //                                         6, 1, 6, 1),
      //                                     backgroundColor: 1 == 0
      //                                         ? Get.theme.primaryContainer
      //                                         : Colors.transparent,
      //                                     label: FxText.bodySmall(
      //                                       "Business",
      //                                       fontSize: 11,
      //                                       fontWeight: 700,
      //                                       color: 1 == 0
      //                                           ? Get.theme.onPrimaryContainer
      //                                           : Get.theme.onBackground,
      //                                     ),
      //                                     onPressed: () => {print('hello')}),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     left: 2.0, right: 4.0),
      //                                 child: ActionChip(
      //                                     elevation: 0,
      //                                     padding: const EdgeInsets.fromLTRB(
      //                                         6, 1, 6, 1),
      //                                     backgroundColor: 1 == 0
      //                                         ? Get.theme.primaryContainer
      //                                         : Colors.transparent,
      //                                     label: FxText.bodySmall(
      //                                       "Participants",
      //                                       fontSize: 11,
      //                                       fontWeight: 700,
      //                                       color: 1 == 0
      //                                           ? Get.theme.onPrimaryContainer
      //                                           : Get.theme.onBackground,
      //                                     ),
      //                                     onPressed: () => {print('hello')}),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                 ),
      //               ),
      //             )
      //           ];
      //         },
      //         body: controller.expande.value == true
      //             ? SizedBox(
      //                 height: MediaQuery.of(context).size.height * 0.89,
      //                 child:
      //                     Obx(() => searchController.searchResultsWidget.value),
      //               )
      //             : controller.streamToday()
      //         // body: TabBarView(
      //         //   children: [
      //         //       controller.streamToday(),
      //         //       controller.streamUpdates(),
      //         //       controller.streamCreated(),
      //         //     ],
      //         // ),
      //         ),
      //   ),
      ),
      )
    );
  }

  Widget _filterChip(int index,
      {required String title,
      required SearchController controller,
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


Widget titleRow() {

    return Row(
      children: [
        FxContainer(
          width: 10,
          height: 24,
          color: Get.theme.primaryContainer,
          borderRadiusAll: 2,
        ),
        FxSpacing.width(8),
        FxText.titleLarge(
          "TaskMan",
          fontWeight: 600,
          // color: Get.theme.primary,
        ),
      ],
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
}
