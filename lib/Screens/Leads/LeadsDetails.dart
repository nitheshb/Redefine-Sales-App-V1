
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Auth/auth_controller.dart';
import 'package:redefineerp/Screens/Dashboard/dashboard_controller.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
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

class _LeadsDetailsScreenState extends State<LeadsDetailsScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
      final controller2 = Get.put<AuthController>(AuthController());

 
 
  @override
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
                  FxContainer.rounded(
                    color: appLightTheme.medicarePrimary,
                    paddingAll: 8,
                    child: Icon(
                      Icons.call,
                      color: appLightTheme.medicareOnPrimary,
                      size: 16,
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
            onPressed: () {
              // Handle onPressed here
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
              FxSpacing.height(16),
            FxContainer(
              margin: FxSpacing.horizontal(40),
              borderRadiusAll: 8,
              color: appLightTheme.medicarePrimary.withAlpha(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.watch_later,
                    color: appLightTheme.medicarePrimary,
                    size: 20,
                  ),
                  FxSpacing.width(8),
                  FxText.bodySmall(
                    'Sun, Jan 19, 08:00am - 10:00am',
                    color: appLightTheme.medicarePrimary,
                  ),
                ],
              ),
            ),
            // FxSpacing.height(4),
            ScheduleListData(context, controller2),
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
                ProjectCard( {'label': 'New', 'value': '${widget.leadDetails['Status']}'}),
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
      //    return Column(
      //   children: data.entries.map((entry) {
      //     var key = entry.key;
      //     if (['staA', 'staDA','assignedTo'].contains(key)) {
      //       return Text('c');
      //     }else{
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
