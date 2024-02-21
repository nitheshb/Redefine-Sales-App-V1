// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as FlutterDateTimePicker;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redefineerp/Screens/Auth/auth_controller.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/Contact/contact_list_dialog.dart';
import 'package:redefineerp/Screens/Contact/contact_list_page.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Home/homepage2.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/Home/homepage_gradient.dart';
import 'package:redefineerp/Screens/Leads/LeadsDetails.dart';
import 'package:redefineerp/Screens/Notification/notification_pages.dart';
import 'package:redefineerp/Screens/Profile/profile_page.dart';
import 'package:redefineerp/Screens/Report/report_page.dart';
import 'package:redefineerp/Screens/Report/slim_team_stats.dart';
import 'package:redefineerp/Screens/Report/team_stats.dart';
import 'package:redefineerp/Screens/Search/search_controller.dart';
import 'package:redefineerp/Screens/Search/search_task.dart';
import 'package:redefineerp/Screens/Task/create_task.dart';
import 'package:redefineerp/Screens/Task/task_controller.dart';
import 'package:redefineerp/Screens/projectDetails/project_units_screen.dart';
import 'package:redefineerp/Utilities/basicdialog.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Utilities/snackbar.dart';
import 'package:redefineerp/Widgets/FxCard.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:redefineerp/Widgets/datewidget.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/customTheme.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/streams.dart';

import '../Search/search_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  late CustomTheme customTheme;
  //   late ThemeData theme;
  final storageReference =
      FirebaseStorage.instance.ref().child('images/image.jpg');

  ImagePicker picker = ImagePicker();

  XFile? image;
  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomePageController>(HomePageController());
    final controller2 = Get.put<AuthController>(AuthController());
    final controller1 = Get.put<ContactController>(ContactController());
    // MySearchController searchController =
    //     Get.put<MySearchController>(SearchController());
    // TaskController controller1 = Get.put<TaskController>(TaskController());
    debugPrint("home called ${FirebaseAuth.instance.currentUser}");
    debugPrint("home calledc ${controller2.currentUserObj}");
    // Set the system status bar color
// Create two streams for each query
    final stream1 = FirebaseFirestore.instance
        .collection('maahomes_projects')
        // .where("due_date",
        //     isLessThanOrEqualTo: DateTime.now().microsecondsSinceEpoch)
        .where("status", isEqualTo: "ongoing")
        // .where("particpantsIdA", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        // .where("to_uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where("by_uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)

        // .orWhere("by_uid", isEqualTo:  FirebaseAuth.instance.currentUser!.uid)

        .snapshots();


// Combine the two streams using the RxCombineLatestStream from the rxdart package
// final combinedStream = RxCombineLatestStream<QuerySnapshot>([stream1, stream2]);
// final combinedStream = rxdart.CombineLatestStream( [stream1, stream2]);

    return Obx(() => Scaffold(
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
                        // MySearchController.searchResultsWidget.value =
                        //     MySearchController.searchResults('');
                        controller.search.value = false;
                      } else {
                        controller.search.value = true;
                      }
                      // MySearchController.searchResultsWidget.value =
                      //     MySearchController.searchResults(v);

                      // print(MySearchController.searchResultsWidget.value);
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
                        onPressed: () =>
                            {Get.to(() => const NotificationPage())},
                        icon: const Icon(Icons.notifications),
                        color: Get.theme.btnTextCol.withOpacity(0.3)),
        
                  ],
          ),


        

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
                    flexibleSpace: Obx(() => FlexibleSpaceBar(
                        background: SlimTeamStats(
                            controller.flipMode,
                            controller.businessMode.value,
                            controller.numOfTodayTasks,
                            controller.myBusinessTotal))),
                    expandedHeight: 190,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(48.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (!controller.businessMode.value) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 4.0),
                                  child: ActionChip(
                                      elevation: 0,
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 1, 6, 1),
                                      backgroundColor: 0 == 0
                                          ? Get.theme.primaryContainer
                                          : Colors.transparent,
                                      label: FxText.bodySmall(
                                        "My Tasks",
                                        fontSize: 11,
                                        fontWeight: 700,
                                        color: 0 == 0
                                            ? Get.theme.onPrimaryContainer
                                            : Get
                                                .theme.colorScheme.onBackground,
                                      ),
                                      onPressed: () => {print('hello')}),
                                ),
                                Visibility(
                                  visible: false,
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2.0, right: 4.0),
                                    child: ActionChip(
                                        elevation: 0,
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 1, 6, 1),
                                        backgroundColor: 0 == 0
                                            ? Get.theme.primaryContainer
                                            : Colors.transparent,
                                        label: FxText.bodySmall(
                                          "My Tasks adfafafaf adffafafafdas adfafafaf adfadfafafafaff",
                                          fontSize: 11,
                                          fontWeight: 700,
                                          color: 0 == 0
                                              ? Get.theme.onPrimaryContainer
                                              : Get.theme.colorScheme
                                                  .onBackground,
                                        ),
                                        onPressed: () => {print('hello')}),
                                  ),
                                ),
                              ] else ...[
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 4.0),
                                    child: ActionChip(
                                        elevation: 0,
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 1, 6, 1),
                                        backgroundColor: controller
                                                    .myTaskTypeCategory.value ==
                                                'allBusinessTasks'
                                            ? Get.theme.primaryContainer
                                            : Colors.transparent,
                                        label: FxText.bodySmall(
                                          "My Taks",
                                          fontSize: 11,
                                          fontWeight: 700,
                                          color: controller.myTaskTypeCategory
                                                      .value ==
                                                  'allBusinessTasks'
                                              ? Get.theme.onPrimaryContainer
                                              : Get.theme.onBackground,
                                        ),
                                        onPressed: () => {
                                              controller.setTaskTypeFun(
                                                  'allBusinessTasks')
                                            }),
                                  ),
                                ),
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2.0, right: 4.0),
                                    child: InkWell(
                                      onTap: () => {
                                        controller
                                            .setTaskTypeFun('assignedToMe')
                                      },
                                      child: ActionChip(
                                          elevation: 0,
                                          padding: const EdgeInsets.fromLTRB(
                                              6, 1, 6, 1),
                                          backgroundColor: controller
                                                      .myTaskTypeCategory
                                                      .value ==
                                                  'myLeads'
                                              ? Get.theme.primaryContainer
                                              : Colors.transparent,
                                          label: FxText.bodySmall(
                                            "My Leads ",
                                            fontSize: 11,
                                            fontWeight: 700,
                                            color: controller.myTaskTypeCategory
                                                        .value ==
                                                    'myLeads'
                                                ? Get.theme.onPrimaryContainer
                                                : Get.theme.onBackground,
                                          ),
                                          onPressed: () => {
                                                print(
                                                    'hello ${controller.myTaskTypeCategory.value == 'assignedToMe'}'),
                                                controller.setTaskTypeFun(
                                                    'myLeads')
                                              }),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2.0, right: 4.0),
                                    child: ActionChip(
                                        elevation: 0,
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 1, 6, 1),
                                        backgroundColor:
                                            controller.myTaskTypeCategory ==
                                                    'projects'
                                                ? Get.theme.primaryContainer
                                                : Colors.transparent,
                                        label: FxText.bodySmall(
                                          "Projects",
                                          fontSize: 11,
                                          fontWeight: 700,
                                          color:
                                              controller.myTaskTypeCategory ==
                                                      'projects'
                                                  ? Get.theme.onPrimaryContainer
                                                  : Get.theme.onBackground,
                                        ),
                                        onPressed: () => {
                                              print('hello'),
                                              controller
                                                  .setTaskTypeFun('projects'),
                                              print(controller
                                                  .showingLists.length)
                                            }),
                                  ),
                                ),
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2.0, right: 4.0),
                                    child: ActionChip(
                                        elevation: 0,
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 1, 6, 1),
                                        backgroundColor:
                                            controller.myTaskTypeCategory ==
                                                    'participants'
                                                ? Get.theme.primaryContainer
                                                : Colors.transparent,
                                        label: FxText.bodySmall(
                                          "Participants ",
                                          fontSize: 11,
                                          fontWeight: 700,
                                          color:
                                              controller.myTaskTypeCategory ==
                                                      'participants'
                                                  ? Get.theme.onPrimaryContainer
                                                  : Get.theme.onBackground,
                                        ),
                                        onPressed: () => {
                                              controller.setTaskTypeFun(
                                                  'participants'),
                                              print(
                                                  'hello ${controller.myTaskTypeCategory == 'participants'}'),
                                            }),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              // body: controller.streamToday()
               body: Center(
           child: () {
          switch (controller.myTaskTypeCategory.value) {
            case 'allBusinessTasks':
              return Text('Tasks');
            case 'myLeads':
              return _LeadsList(context, controller2);
            case 'projects':
              return _projectsBody(context,controller2);
            default:
              return Text('Invalid selection');
          }
        }()),
     
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
            //                                       controller: MySearchController,
            //                                       onTap: () => {
            //                                             MySearchController
            //                                                 .selectedIndex.value = 0,
            //                                           }),
            //                                   _filterChip(1,
            //                                       title: 'Done',
            //                                       controller: MySearchController,
            //                                       onTap: () => {
            //                                             MySearchController
            //                                                 .selectedIndex.value = 1,
            //                                           }),
            //                                   _filterChip(2,
            //                                       title: 'Pending',
            //                                       controller: MySearchController,
            //                                       onTap: () => {
            //                                             MySearchController
            //                                                 .selectedIndex.value = 2,
            //                                           }),
            //                                   _filterChip(3,
            //                                       title: 'Created',
            //                                       controller: MySearchController,
            //                                       onTap: () => {
            //                                             MySearchController
            //                                                 .selectedIndex.value = 3,
            //                                           }),
            //                                   _filterChip(4,
            //                                       title: 'Today',
            //                                       controller: MySearchController,
            //                                       onTap: () => {
            //                                             MySearchController
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
            //                     Obx(() => MySearchController.searchResultsWidget.value),
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
        ));
  }

 Widget _projectsBody( context, controller2) {
             return         StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("${controller2.currentUserObj['orgId']}_projects")
                  // .where("status", isEqualTo: "ongoing")
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
                   print('pub dev isx ${controller2.currentUserObj['orgId']}');
    

                // particpantsIdA

                // return Text('Full Data');
                   return Column(
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
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, i) {

var projData =
                      snapshot.data?.docs[i];
                      var unitCounts;
                      try {
                           unitCounts = projData?['totalUnitCount'] ?? 0;      
                      } catch (e) {
                             unitCounts = 'NA';
                      }
             
                                  
return _buildSingleHouse(context, projData);
 
                                      
                                      }),
                              ),
                            ),
                          ),
                        ],
                      );

                  }else{
                    return Text('No Data');
                  }});

 }

  Widget _buildSingleHouse( context, projData) {

    String totalUnitCount = projData?.data()?.containsKey('totalUnitCount') == true
    ? projData['totalUnitCount'].toString()
    : '0';
     String soldUnitCount = projData?.data()?.containsKey('soldUnitCount') == true
    ? projData!['soldUnitCount'].toString()
    : '0';
    return FxCard(
      onTap: () {
                      Get.to(() => ProjectUnitScreen(projectDetails: projData ));
      },
      margin: FxSpacing.nTop(24),
      paddingAll: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadiusAll: 16,
      child: Column(
        children: [
          // Image(
          //   image: AssetImage("assets/images/room.png"),
          //   fit: BoxFit.fitWidth,
          // ),
          FxContainer(
            paddingAll: 16,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.bodyMedium(
                      projData?['projectName'],
                      fontWeight: 700,
                    ),
                    FxText.bodyMedium(
                      projData!['projectType']?['name'],
                      fontWeight: 600,
                      color: appGreenTheme.secondary,
                    ),
                  ],
                ),
                FxSpacing.height(4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey.withAlpha(180),
                    ),
                    FxSpacing.width(4),
                    FxText.bodySmall(
                      projData!['location'],
                      xMuted: true,
                    ),
                  ],
                ),
                FxSpacing.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.king_bed,
                            size: 16,
                            color:
                                Colors.grey.withAlpha(180),
                          ),
                          FxSpacing.width(4),
                          FxText.bodySmall(
                            totalUnitCount,
                            xMuted: true,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bathtub,
                            size: 16,
                            color:
                                Colors.grey.withAlpha(180),
                          ),
                          FxSpacing.width(4),
                          FxText.bodySmall(
                            '${projData!['area']}',
                            xMuted: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FxSpacing.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.square_foot,
                            size: 16,
                            color:
                                Colors.grey.withAlpha(180),
                          ),
                          FxSpacing.width(4),
                          FxText.bodySmall(
                            soldUnitCount,
                            xMuted: true,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.aspect_ratio,
                            size: 16,
                            color:
                                Colors.grey.withAlpha(180),
                          ),
                          FxSpacing.width(4),
                          FxText.bodySmall(
                            '${projData!['area']}',
                            xMuted: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _LeadsList( context, controller2) {
             return         StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("${controller2.currentUserObj['orgId']}_leads")
                  // .where("assignedTo", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where("Status", isEqualTo: 'followup')
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

                   return Column(
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
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, i) {

var projData =
                      snapshot.data?.docs[i];
                
          
                                  
return _buildLeadsCard(context, projData);
 
                                      
                                      }),
                              ),
                            ),
                          ),
                        ],
                      );

                  }else{
                    return Text('No Data');
                  }});

 }

   Widget _buildLeadsCard( context,     _list) {

      String lead_Remarks = _list?.data()?.containsKey('Remarks') == true
    ? _list!['Remarks']
    : 'NA';

    return Container(
      margin: FxSpacing.top(16),
      child: InkWell(
        onTap: () {
          //_showBottomSheet(context);
       
                      Get.to(() => LeadsDetailsScreen(leadDetails: _list ));
    
        },
        child: Row(
          children: <Widget>[
            // ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(24)),
            //   child: Image(
            //     image: AssetImage('./assets/images/profile/avatar_2.jpg'),
            //     height: 48,
            //     width: 48,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Expanded(
              child: Container(
                margin: FxSpacing.left(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FxText.bodyMedium(_list['Name'],
                        letterSpacing: 0,
                     
                        fontWeight: 600),
                    FxText.bodySmall(
                      lead_Remarks,
                   
                      letterSpacing: 0,
                      xMuted: true,
                      fontWeight: 600,
                      fontSize: 12,
                    ),
                    FxText.bodySmall(
                      _list['Status'],
                      fontSize: 12,
                      muted: true,
                      letterSpacing: 0,
                      fontWeight: 500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  // _list[index] = !_list[index];
                });
              },
              child: FxContainer(
                 margin: FxSpacing.right(16),
                padding: FxSpacing.fromLTRB(16, 8, 16, 8),
                bordered: false,
                borderRadiusAll: 4,
                border: Border.all(color: Colors.grey, width: 1),
                color:false
                    ? Colors.transparent
                    : appLightTheme.primaryColor,
                child: FxText.bodySmall("Call",
                    color:false
                        ? appLightTheme.colorScheme.onBackground
                        : appLightTheme.colorScheme.onPrimary,
                    fontWeight: 600,
                    letterSpacing: 0.3),
              ),
            ),
          ],
        ),
      ),
    );
  
      }

  Widget _filterChip(int index,
      {required String title,
      required MySearchController controller,
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
          "Sales💥",
          fontWeight: 600,
          // color: Get.theme.primary,
        ),
      ],
    );
  }

  Widget _bottomSheet(ScrollController controller) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
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
