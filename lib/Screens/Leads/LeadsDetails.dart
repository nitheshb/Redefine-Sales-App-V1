
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:redefineerp/Screens/Auth/auth_controller.dart';
import 'package:redefineerp/Screens/Contact/contact_list_dialog.dart';
import 'package:redefineerp/Screens/Dashboard/dashboard_controller.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/Leads/LeadDetailsController.dart';
import 'package:redefineerp/Screens/Leads/LeadLogs.dart';
import 'package:redefineerp/Screens/projectDetails/unit_screen.dart';
import 'package:redefineerp/themes/constant.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/progress_bar.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/text_utils.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:timeago/timeago.dart' as timeago;

class LeadsDetailsScreen extends StatefulWidget {
  const LeadsDetailsScreen({required this.leadDetails, super.key});
  final leadDetails;

  @override
  State<LeadsDetailsScreen> createState() => _LeadsDetailsScreenState();
}

class _LeadsDetailsScreenState extends State<LeadsDetailsScreen>  with SingleTickerProviderStateMixin {
  TabController? _tabController;
   TabController? _tabController1;
  int _currentIndex = 0;
  DashboardController dashboardController = Get.put(DashboardController());
  LeadDetailsController controller = Get.put(LeadDetailsController());
      final controller2 = Get.put<AuthController>(AuthController());

 
 
  @override
  void initState() {

    _tabController = TabController(length: 2, vsync: this);
// _tabController1 = TabController(length: 2, vsync: this);

    _tabController!.animation!.addListener(() {
      final aniValue = _tabController!.animation!.value;
      if (aniValue - _currentIndex > 0.5) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      } else if (aniValue - _currentIndex < -0.5) {
        setState(() {
          _currentIndex = _currentIndex - 1;
        });
      }
    });
     controller.selLead.value =widget.leadDetails.data();
     controller.selLeadId.value = widget.leadDetails.id;
     print('change is ${widget.leadDetails.id} ${widget.leadDetails.data()}');
    super.initState();
  }


@override
void dispose() {
  _tabController1?.dispose();
  super.dispose();
}
void ShowDatePickerCard  (x)async {

  print('inside here');
  DateTime? dateTime = await showOmniDateTimePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime(1600).subtract(const Duration(days: 3652)),
                    lastDate: DateTime.now().add(
                      const Duration(days: 3652),
                    ),
                    is24HourMode: false,
                    isShowSeconds: false,
                    minutesInterval: 5,
                    secondsInterval: 1,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    constraints: const BoxConstraints(
                      maxWidth: 350,
                      maxHeight: 650,
                    ),
                    
                    transitionBuilder: (context, anim1, anim2, child) {
                      return FadeTransition(
                        opacity: anim1.drive(
                          Tween(
                            begin: 0,
                            end: 1,
                          ),
                        ),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 200),
                    barrierDismissible: true,
                    selectableDayPredicate: (dateTime) {
                      // Disable 25th Feb 2023
                      if (dateTime == DateTime(2023, 2, 25)) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                  );
// controller.selectedDateTime.value = DateFormat('dd-MM-yy HH:mm').format(dateTime!).toString();
controller.selectedDateTime.value = dateTime!.millisecondsSinceEpoch;
                 print('selected data is ${controller.selectedDateTime}  ${dateTime}');
}



_callNumber() async{
   print('res issx ');
  const number = '919489000525'; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  print('res is ${res}');
}

  Widget build(BuildContext context) {
    print('data1 ${widget.leadDetails.id}');

     return Scaffold(
      body: Padding(
        padding: FxSpacing.top(28),
        child: Column(
          children: [
            FxContainer(
              color: appLightTheme.colorPrimary,
              child: Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                     
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  FxSpacing.width(8),
                  // FxContainer.rounded(
                  //   paddingAll: 0,
                  //   child: Image(
                  //     width: 40,
                  //     height: 40,
                  //     image: AssetImage(chat.image),
                  //   ),
                  // ),
                  FxSpacing.width(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.bodyMedium(
                          widget.leadDetails['Name'],
                          fontWeight: 600,
                        ),
                        FxSpacing.height(2),
                        Row(
                          children: [
                            FxContainer.rounded(
                              paddingAll: 3,
                              color: appLightTheme.groceryPrimary,
                              child: Container(),
                            ),
                            FxSpacing.width(4),
                            FxText.bodySmall(
                              widget.leadDetails['Mobile'],
                              color: appLightTheme.onBackground,
                              xMuted: true,
                            ),
                          ],
                        ),
                        FxSpacing.height(2),

 Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FxProgressBar(
                            width: 100,
                            height: 5,
                            activeColor: appLightTheme.medicarePrimary,
                            inactiveColor:
                                appLightTheme.medicarePrimary.withAlpha(100),
                            progress: 0.6),
                        // FxSpacing.width(20),
                        // FxText.bodySmall(" 4 Stars",
                        //     fontWeight: 500, height: 1),
                      ],
                    ),
                        
                      ],
                    ),
                  ),
                  FxSpacing.width(16),
              
                  // FxContainer.rounded(
                  //     color: appLightTheme.medicarePrimary,
                  //     paddingAll: 8,
                  //     child: Icon(
                  //       Icons.videocam_rounded,
                  //       color: appLightTheme.medicareOnPrimary,
                  //       size: 16,
                  //     )),
                  // FxSpacing.width(8),
                  InkWell(
                    onTap: (){
                      _callNumber();
                    },
                    child: FxContainer.rounded(
                      color: appLightTheme.medicarePrimary,
                      paddingAll: 8,
                      child: Icon(
                        Icons.call,
                        color: appLightTheme.medicareOnPrimary,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                       Padding(
  padding: const EdgeInsets.only(left: 8.0, right: 4.0),
  child: Row(
    children: [
      for (var item in [
        {'label': 'New', 'value': 'new'},
        {'label': 'Followup', 'value': 'followup'}, 
        {'label': 'Visit Fixed', 'value': 'visitfixed'},
        {'label': 'Visit Done', 'value': 'visitdone'}, {'label': 'Not Interested', 'value': 'notinterested'},
        {'label': 'Junk', 'value': 'junk'},
        
      ])
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ActionChip(
            elevation: 0,
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
            backgroundColor: widget.leadDetails['Status'] == item['value']
                ? Get.theme.primaryContainer
                : Colors.transparent,
            label: FxText.bodySmall(
              item['label']!,
              fontSize: 11,
              fontWeight: 700,
              color: widget.leadDetails['Status'] == item['value']
                  ? Get.theme.onPrimaryContainer
                  : Get.theme.onBackground,
            ),
  onPressed: () async => {
   controller.selNewStaus(item,widget.leadDetails),
           await   showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(9.0))),
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) =>
                 Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                       ),
                        child: Form(
                          key: controller.taskKey,
                          child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                            children: [
                              TaskCreationHead(item),
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0,
                            right: 14.0,
                            top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                                    
                                      FxText.bodySmall(
            'Task Title ',
            color: Constant.softColors.green.onColor,
            fontWeight: 500,
          ),
                                    TextFormField(
                                      validator: controller.validateTaskTitle,
                                      controller: controller.taskTitle,
                                      onChanged: controller.validateTaskTitle,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Task Title...'),
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w500),
                                      autofocus: true,
                                    ),
                                  
                                    //  Container(
                                    //   height:
                                    //  child: null),
                                    Visibility(
                                      visible: (controller.assignedUserName.value ==
                                          "Assign someone"),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // assign to
                                                
                                         
                                          // Due Date
                                                   
                                                   
                                                
                                          InkWell(
                                            onTap: () {
                                              print('check');
                                              ShowDatePickerCard(controller);      
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
                                                        radius:
                                                            const Radius.circular(27.0),
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
                                                Obx(() =>  Padding(
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
                                                                       
                                                                            '${DateFormat('dd-MM-yy HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller
                                                                            .selectedDateTime
                                                                            .value))}',
                                                                        style: Get.theme
                                                                            .kNormalStyle
                                                                            .copyWith(
                                                                                color: Get
                                                                                    .theme
                                                                                    .kBadgeColor)),
                                                                  ),
                                                                
                                                              ],
                                                            ),
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
                                                      // image = await picker.pickImage(
                                                      //     source: ImageSource.gallery);
                                                      // storageReference
                                                      //     .putFile(File(image!.path))
                                                      //     .then((value) async {
                                                      //   controller.attachmentsA.value
                                                      //       .add(await value.ref
                                                      //           .getDownloadURL());
                                                      //   print(
                                                      //       'Image URL: ${controller.attachmentsA.value}');
                                                      // });
                                                    },
                                                    child: DottedBorder(
                                                      // borderType: BorderType.Circle,
                                                      color: Get.theme.kLightGrayColor,
                                                      radius:
                                                          const Radius.circular(27.0),
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
                                          (controller.participants.value.isNotEmpty),
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
                                       
                                                
                                                  InkWell(
                                                      onTap: () => {
                                                            // showDialog(
                                                            //     context: context,
                                                            //     builder: (BuildContext
                                                            //             context) =>
                                                            //         const ContactListDialogPage())
                                                          },
                                                      child: DottedBorder(
                                                        borderType: BorderType.Circle,
                                                        color:
                                                            Get.theme.kLightGrayColor,
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
                                                            color: Get
                                                                .theme.kLightGrayColor,
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
                                                                      style: const TextStyle(
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
                                                visible: (controller
                                                        .assignedUserName.value ==
                                                    "Assign someone"),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () => {
                                                        // showDialog(
                                                        //     context: context,
                                                        //     builder: (BuildContext
                                                        //             context) =>
                                                        //         Dialog(
                                                        //             shape:
                                                        //                 RoundedRectangleBorder(
                                                        //               borderRadius:
                                                        //                   BorderRadius
                                                        //                       .circular(
                                                        //                           8),
                                                        //             ),
                                                        //             child:
                                                        //                 ContactListPage()))
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
                                                    const SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    InkWell(
                                                      onTap: () => {
                                                        // FlutterDateTimePicker.DatePicker.showDateTimePicker(
                                                        //     context,
                                                        //     showTitleActions: true,
                                                        //     onChanged: (date) {
                                                        //   print(
                                                        //       'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                                        // }, onConfirm: (date) {
                                                        //   controller.dateSelected =
                                                        //       date;
                                                        //   controller
                                                        //       .updateSelectedDate();
                                                        // }, currentTime: DateTime.now())
                                                      },
                                                      child: Icon(
                                                        Icons.calendar_month_outlined,
                                                        color:
                                                            Get.theme.kLightGrayColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          
                                              InkWell(
                                                onTap: () => {
                                                  // FlutterDateTimePicker.DatePicker.showDateTimePicker(context,
                                                  //     showTitleActions: true,
                                                  //     onChanged: (date) {
                                                  //   print(
                                                  //       'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                                                  // }, onConfirm: (date) {
                                                  //   // controller.dateSelected = date;
                                                  //   // controller.updateSelectedDate();
                                                  // }, currentTime: DateTime.now())
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
                                                visible: (!controller
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
                                                backgroundColor: controller
                                                            .validationSuccess.value ==
                                                        true
                                                    ? Get.theme.primaryContainer
                                                    : Colors.grey,
                                                child: Icon(
                                                  Icons.send,
                                                  color: controller.validationSuccess
                                                              .value ==
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
                              ),
                            ],
                          ),
                        )),
                  )
            },
          ),
        ),
    ],
  ),
)
                            ],
                          
                        ),
                      ),
             

           
            overview(),
            FxSpacing.height(4),
            alert(),
              // FxSpacing.height(16),
              TabBar(
  controller: _tabController,
  tabs: [
          Tab(
                    child: FxText.titleMedium("Tasks",
                        color: _currentIndex == 0
                            ? Get.theme.onPrimaryContainer
                            : Get.theme.onBackground,
                            fontSize: 12
                        )),
                        Tab(
                    child: FxText.titleMedium("Logs",
                        color: _currentIndex == 1
                            ? Get.theme.onPrimaryContainer
                            : Get.theme.onBackground,
                            fontSize: 12
                        )),
          ],
        // or TabBarIndicatorSize.tab
  indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0), // Adjust the padding here
             labelColor: Get.theme.onPrimaryContainer,
            indicatorColor:  appLightTheme.medicarePrimary.withAlpha(100),
            unselectedLabelColor: Get.theme.onPrimaryContainer,
),

 _currentIndex == 0 ? ScheduleListData(context, controller2) :  LeadLogsScreen( leadDetails: widget.leadDetails,)
        //   TabBarView(
        //   controller: _tabController,
        //   children: <Widget>[
        //           Text('data'),
        //           ScheduleListData(context, controller2),
        //   ],
        // )
            // FxContainer(
            //   margin: FxSpacing.horizontal(40),
            //   borderRadiusAll: 8,
            //   color: appLightTheme.medicarePrimary.withAlpha(40),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(
            //         Icons.watch_later,
            //         color: appLightTheme.medicarePrimary,
            //         size: 20,
            //       ),
            //       FxSpacing.width(8),
            //       FxText.bodySmall(
            //         'Sun x, Jan 19, 08:00am - 10:00am',
            //         color: appLightTheme.medicarePrimary,
            //       ),
            //     ],
            //   ),
            // ),
            // FxSpacing.height(4),
     
              // FxContainer(
            //   marginAll: 24,
            //   paddingAll: 0,
            //   child: FxTextField(
            //     focusedBorderColor: customTheme.medicarePrimary,
            //     cursorColor: customTheme.medicarePrimary,
            //     textFieldStyle: FxTextFieldStyle.outlined,
            //     labelText: 'Type Something ...',
            //     labelStyle: FxTextStyle.bodySmall(
            //         color: theme.colorScheme.onBackground, xMuted: true),
            //     floatingLabelBehavior: FloatingLabelBehavior.never,
            //     filled: true,
            //     fillColor: customTheme.card,
            //     suffixIcon: Icon(
            //       FeatherIcons.send,
            //       color: customTheme.medicarePrimary,
            //       size: 20,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
 
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.005,
              horizontal: MediaQuery.of(context).size.width * 0.050,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios), iconSize: 16,),
                    
                  
                    const Spacer()
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.075,
                      width: MediaQuery.of(context).size.width * 0.20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/projectImage.png")),
                        borderRadius: BorderRadius.all(
                          Radius.circular(19),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.040,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.leadDetails['Name']}",
                          style: headline2,
                        ),
                      
                           RichText(
                          text: TextSpan(children: [
                          
                            TextSpan(
                                text: "${widget.leadDetails?['Mobile']}",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.8,
                                    color: Color(0xFF303437))),
                                      TextSpan(
                                text: "-${widget.leadDetails?['Name']} ",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.8,
                                    color: Color(0xFF72777A))),
                          ]),
                        ),
                        
                          ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                LinearProgressIndicator(
                  backgroundColor: const Color(0xFFE3E5E5),
                  color: appLightTheme.primaryColorDark,
                  value: 0.6,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.010,
                ),
          


                const TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
            
                    tabs: [
                      Tab(
                        text: 'Tasks',

                      ),
                      Tab(
                        text: 'Logs',
                      ),
                      Tab(
                        text: 'Quotations',
                      ),
                    ]),
                    
              ],
            ),
          ),
        )),
      ),
    );

    
  }

  Widget _buildReceiveMessage(schBody) {
                      final now = DateTime.now();
                  final difference = now.difference(
                      DateTime.fromMillisecondsSinceEpoch(
                          schBody!['schTime']));   
                          
                          final difference1 = now.millisecondsSinceEpoch - schBody!['schTime'];

                          int differenceInMinutes = difference.inMinutes;
                          int days = differenceInMinutes ~/ (60 * 24);
                          int hours = (differenceInMinutes ~/ 60) % 24;
                          int hoursX = (difference1.abs() ~/ 60) % 24;
                          int minutes = differenceInMinutes % 60;

  String delayedTextIs = differenceInMinutes >= 0  ? 'Completed by ${days > 0 ? '$days Days ' : ''}${hours > 0 ? '$hours Hours ' : ''}$minutes Min' : 'Delayed by ${days > 0 ? '$days Days ' : ''}${hours > 0 ? '$hours Hours ' : ''}$minutes Min';
    return Padding(
      padding: FxSpacing.fromLTRB(12, 6, 12, 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: FxContainer(
              color: schBody['sts'] =='pending' ? appBlueMode.medicarePrimary : appLightTheme.medicarePrimary.withAlpha(40),
              // margin: FxSpacing.right(140),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FxText.bodySmall(
                    schBody['notes']!,
                    color: schBody['sts'] =='pending' ? appBlueMode.medicareOnPrimary : appLightTheme.medicarePrimary,
                    xMuted: true,
                  ),
                      FxSpacing.height(4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(
                    Icons.watch_later,
                    color: appBlueMode.medicareOnPrimary.withAlpha(100),
                    size: 20,
                  ),
                  FxSpacing.width(8),
                        FxText.bodySmall(
                          '${DateTime.fromMillisecondsSinceEpoch(schBody!['schTime'])} ${timeago.format(now.subtract(difference)) } ',
                          fontSize: 10,
                          color:schBody['sts'] =='pending' ? appBlueMode.medicareOnPrimary : appLightTheme.medicarePrimary ,
                          xMuted: true,
                        ),
                      ],
                    ),
                  ),
                    FxText.bodySmall(
                          ' ${difference1}',
                          fontSize: 10,
                          color:schBody['sts'] =='pending' ? appBlueMode.medicareOnPrimary : appLightTheme.medicarePrimary ,
                          xMuted: true,
                        ),   FxText.bodySmall(
                          ' ${hours}',
                          fontSize: 10,
                          color:schBody['sts'] =='pending' ? appBlueMode.medicareOnPrimary : appLightTheme.medicarePrimary ,
                          xMuted: true,
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildSendMessage({String? message, String? time}) {
    return Padding(
      padding: FxSpacing.horizontal(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: FxContainer(
              color: appBlueMode.medicarePrimary,
              // margin: FxSpacing.left(140),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FxText.bodySmall(
                    message!,
                    color: appBlueMode.medicareOnPrimary,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FxText.bodySmall(
                      time!,
                      fontSize: 10,
                      color: appBlueMode.medicareOnPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget overview() {
    return Column(
      children: [
        Padding(
           padding: FxSpacing.all(2.0),
          child: Row(
              children: [
                ProjectCard( {'label': 'New', 'value': '${widget.leadDetails['Project']}'}),
                AssignedToCard( {'label': 'New', 'value': '${widget.leadDetails?['assignedToObj']?['name']}'}),
                // StatusCard( {'label': 'New', 'value': 'new'}),
              ],
            ),
        )    ],
    );
  }
 Widget timeFilter() {
    final controller = Get.put<DashboardController>(DashboardController());

    return PopupMenuButton(
      color: Get.theme.onBackground,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constant.containerRadius.small)),
      elevation: 1,
      child: FxContainer.bordered(
          paddingAll: 12,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FxText.bodySmall(
                controller.time,
              ),
              FxSpacing.width(8),
              const Icon(
                FeatherIcons.chevronDown,
                size: 14,
              )
            ],
          )),
      itemBuilder: (BuildContext context) => [
        ...controller.filterTime.map((time) => PopupMenuItem(
            onTap: () {
              controller.changeFilter(time);
            },
            padding: FxSpacing.x(16),
            height: 36,
            child: FxText.bodyMedium(time)))
      ],
    );
  }
  
    Widget ProjectCard( nutrition) {
    return Expanded(
      child: FxContainer(
        borderRadiusAll: 50,
        padding: FxSpacing.fromLTRB(8, 8, 12, 8),
        color: appBlueMode.medicarePrimary.withAlpha(40),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FxContainer.bordered(
                paddingAll: 4,
                width: 32,
                height: 32,
                borderRadiusAll: 16,
                color: appBlueMode.medicarePrimary.withAlpha(200),
                border: Border.all(color: appBlueMode.medicarePrimary, width: 1),
                child: Center(
                    child: FxText.bodySmall(
                        FxTextUtils.doubleToString(
                          0,
                        ),
                        letterSpacing: 0,
                        color: appBlueMode.medicarePrimary))),
            FxSpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodySmall(nutrition['value'], fontWeight: 600),
                FxText.bodySmall('Project',
                    fontSize: 10, xMuted: true, fontWeight: 600),
              ],
            )
          ],
        ),
      ),
    );
  }

 
 Widget AssignedToCard( nutrition) {
    return Expanded(
      child: FxContainer(
        borderRadiusAll: 50,
        padding: FxSpacing.fromLTRB(8, 8, 12, 8),
        color: appBlueMode.medicarePrimary.withAlpha(40),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FxContainer.bordered(
                paddingAll: 4,
                width: 32,
                height: 32,
                borderRadiusAll: 16,
                color: appBlueMode.medicarePrimary.withAlpha(200),
                border: Border.all(color: appBlueMode.medicarePrimary, width: 1),
                child: Center(
                    child: FxText.bodySmall(
                        FxTextUtils.doubleToString(
                         0,
                        ),
                        letterSpacing: 0,
                        color: appBlueMode.medicarePrimary))),
            FxSpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodySmall(nutrition['value'], fontWeight: 600),
                FxText.bodySmall('Executive',
                    fontSize: 10, xMuted: true, fontWeight: 600),
              ],
            )
          ],
        ),
      ),
    );
  }
Widget StatusCard( nutrition) {
    return Expanded(
      child: FxContainer(
        borderRadiusAll: 50,
        padding: FxSpacing.fromLTRB(8, 8, 12, 8),
        color: appBlueMode.medicarePrimary.withAlpha(40),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FxContainer.bordered(
                paddingAll: 4,
                width: 32,
                height: 32,
                borderRadiusAll: 16,
                color: appBlueMode.medicarePrimary.withAlpha(200),
                border: Border.all(color: appBlueMode.medicarePrimary, width: 1),
                child: Center(
                    child: FxText.bodySmall(
                        FxTextUtils.doubleToString(
                          250,
                        ),
                        letterSpacing: 0,
                        color: appBlueMode.medicarePrimary))),
            FxSpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodySmall(nutrition['label'], fontWeight: 600),
                FxText.bodySmall('Status',
                    fontSize: 10, xMuted: true, fontWeight: 600),
              ],
            )
          ],
        ),
      ),
    );
  }

    Widget TaskCreationHead(item) {
    return FxContainer(
      color: Constant.softColors.green.color,
      child: Row(
        children: [
          FxText.bodySmall(
            'Hey, Plan your ',
            color: Constant.softColors.green.onColor,
            fontWeight: 700,
          ),  FxText.bodySmall(
            '${item['label']} ',
            color: Constant.softColors.green.onColor,
            fontWeight: 900,
            fontSize: 14,
          ),
           FxText.bodySmall(
            'with a task',
            color: Constant.softColors.green.onColor,
            fontWeight: 700,
          ),
          
        ],
      ),
    );
  }
   Widget alert() {
    return FxContainer(
      color: Constant.softColors.green.color,
      child: Row(
        children: [
          FxText.bodySmall(
            'Remarks: ',
            color: Constant.softColors.green.onColor,
            fontWeight: 700,
          ),
          FxText.bodySmall(
            '${widget?.leadDetails?['Remarks'] ?? 'Na'}',
            color: Constant.softColors.green.onColor,
            fontWeight: 600,
            fontSize: 11,
          )
        ],
      ),
    );
  }

   Widget ScheduleListData( context, controller2) {
             return         StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("${controller2.currentUserObj['orgId']}_leads_sch")
                  // .where("assignedTo", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  // .where("staA", arrayContainsAny: ['pending', 'overdue'])
                   .doc(widget.leadDetails.id)
                  .snapshots(),
              // stream: DbQuery.instanace.getStreamCombineTasks(),
           builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator(); // Display a loading indicator while waiting for data
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}'); // Display an error message if an error occurs
    } else if (!snapshot.hasData || !snapshot.data!.exists) {
      return Text('Document with ID ${widget.leadDetails.id} does not exist.'); // Document not found
    } else {
      // Document with the specified ID exists, display its data
      var data = snapshot.data!.data()! as Map<String, dynamic>;
      controller.selScheduleObj.value = snapshot.data!.data()! as Map<String, dynamic>;
      //    return Column(
      //   children: data.entries.map((entry) {
      //     var key = entry.key;
      //     if (['staA', 'staDA','assignedTo'].contains(key)) {
      //       return Text('c');
      //     }else{s
      //     var value = entry.value;
      //     return Text('$key');
      //   }
      //   }).toList(),
      // );
      var unitList = [];
data.entries.forEach((entry) {
  var key = entry.key;
  var value = entry.value;
  if (['staA', 'staDA', 'assignedTo'].contains(key)) {
    if (key == 'staA') {
      // setschStsA(value);
    } else if (key == 'staDA') {
      // sMapStsA = value;
    }
  } else {
    // Assuming `data` is a List<dynamic> where you store values other than 'staA' and 'staDA'
    unitList.add(value);
    print('my total fetched list is 3 ${key}: ${jsonEncode(value)}');
      Text("Document Data: $data");
  }
});

List<Widget> textWidgets = [];
for (var item in unitList) {
  // print('vals ${item['sts']}');
  // Text('val ${item}');
  textWidgets.add(Text('${item['sts']}'));
}

 return Expanded(
   child: ListView.builder(
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: unitList.length,
                  itemBuilder: (c, i) {
                  var x = unitList[i];
                    return _buildReceiveMessage(x);
                  }),
 );
// unitList.forEach((key, value) {
//   // Build a Text widget for each key-value pair
//   textWidgets.add(Text(' ${value}'));
// });
// Return the list of Text widgets
return Column(
  children: textWidgets,
);
      return Column(
        children: [
          Text("Document ID: ${snapshot.data!.id}"),
          Text("Document Data: $data"),
        ],
      );
    }
  },
              
              ) ;}

}
