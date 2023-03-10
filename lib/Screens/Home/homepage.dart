import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/Notification/notification_pages.dart';
import 'package:redefineerp/Screens/Profile/profile_page.dart';
import 'package:redefineerp/Screens/Report/report_page.dart';
import 'package:redefineerp/Screens/Search/search_task.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
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

class HomePage extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
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
                      snackBarMsg('Task Done!', enableMsgBtn: true),
                      // basicDialog('title', 'message')
                    },
                    icon: Icon(
                      Icons.filter_list_rounded,
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
                    child: Obx(
                      () => Text(
                        'Morning, ${controller.userName}',
                        style: Get.theme.kTitleStyle
                            .copyWith(color: Get.theme.btnTextCol),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 20),
                    child: Obx(
                      () => Text(
                        '${controller.donecount.value}/${controller.notdone.value + controller.donecount.value} Tasks pending',
                        style: Get.theme.kSubTitle
                            .copyWith(color: Get.theme.colorAccent),
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
                  indicatorColor: Colors.transparent,
                  labelColor: Get.theme.colorPrimaryDark,
                  labelStyle: Get.theme.kTabTextLg,
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

      showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(1.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 12.0,
                        right:12.0),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                            children: [
                                  TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Task name'),
                                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                                    onSubmitted: (value) {
                                      Navigator.pop(context);
                                      var currentDate = DateTime.now();
                                  DatePicker.showTimePicker(context,
                                  showSecondsColumn: false,
                                    showTitleActions: true,
                                     onChanged: (date) {
                                }, onConfirm: (date) {
                                  if(value.isNotEmpty){
                                    print('value is ${value} data is ${date}');
                                  //  var task = Task.create(name: value, createdAt: date);
                                  // base.dataStore.addTask(task: task);
                                  }
                                  
                                }, currentTime: DateTime.now());
                                    },
                                    autofocus: true,
                                  ),
                                   TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Description'),
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                    onSubmitted: (value) {
                                      Navigator.pop(context);
                                      var currentDate = DateTime.now();
                                  DatePicker.showTimePicker(context,
                                  showSecondsColumn: false,
                                    showTitleActions: true,
                                     onChanged: (date) {
                                }, onConfirm: (date) {
                                  if(value.isNotEmpty){
                                    print('value is ${value} data is ${date}');
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
                                  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
          child:  Row(
            children: [
              IconButton(
            onPressed: () =>
                {
                  // bottomSheetWidget(FilterScreen(), transparentBg: true)
                                              DatePicker.showDateTimePicker(context,
                                showTitleActions: true, onChanged: (date) {
                              print(
                                  'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                            }, onConfirm: (date) {
                              // controller.dateSelected = date;
                              // controller.updateSelectedDate();
                            }, currentTime: DateTime.now())
                  },
            icon: Icon(
              Icons.people_rounded,
              color: Get.theme.kLightGrayColor,
            ),
          ),
              Text(
                  "To",
                  style: Get.theme.kSubTitle.copyWith(
                    color: Get.theme.kBadgeColor
                     
                  ),
              ),
            ],
          )
        ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Container(
            child:  Row(
               mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
              onPressed: () =>
                  {
                    // bottomSheetWidget(FilterScreen(), transparentBg: true)
                                                DatePicker.showDateTimePicker(context,
                                  showTitleActions: true, onChanged: (date) {
                                print(
                                    'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                              }, onConfirm: (date) {
                                // controller.dateSelected = date;
                                // controller.updateSelectedDate();
                              }, currentTime: DateTime.now())
                    },
              icon: Icon(
                Icons.calendar_month_outlined,
                color: Get.theme.kLightGrayColor,
              ),
            ),
                Text(
                    "Today",
                    style: Get.theme.kSubTitle.copyWith(
                      color: Get.theme.kBadgeColor
                       
                    ),
                ),
              ],
            )
          ),
       ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
            child:  Row(
              children: [
                 Icon(
                            Icons.flag_outlined,
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          ),
                Text(
                    "Priority",
                    style: Get.theme.kSubTitle.copyWith(
                      color: Get.theme.kBadgeColor
                       
                    ),
                ),
              ],
            )
                 ),
         )
              ],
            ),
          ),


                            ],
                          )
        ))
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
                      onPressed: () => {Get.to(() => const NotificationPage())},
                      icon: Icon(Icons.notifications_outlined,
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
