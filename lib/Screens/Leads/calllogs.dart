// import 'package:flutter/material.dart';
// import 'package:redefineerp/Screens/Widgets/ShimmerCard.dart';
// import 'package:redefineerp/helpers/supabae_help.dart';
// import 'package:redefineerp/themes/container.dart';
// import 'package:redefineerp/themes/spacing.dart';
// import 'package:redefineerp/themes/textFile.dart';
// import 'package:redefineerp/themes/themes.dart';

// class CallLogScreen extends StatefulWidget {
//   const CallLogScreen({required this.leadDetails, super.key});
//   final leadDetails;
//   @override
//   _CallLogScreenState createState() => _CallLogScreenState();
// }

// class TextIconItem {
//   String text;
//   IconData iconData;

//   TextIconItem(this.text, this.iconData);
// }

// class _CallLogScreenState extends State<CallLogScreen> {
//   int _currentStep = 3;

//   @override
//   void initState() {
//     super.initState();
//   }

//   final List<TextIconItem> _textIconChoice = [
//     TextIconItem("Receipt", Icons.receipt),
//     TextIconItem("Cancel", Icons.cancel)
//   ];

//   @override
//   dispose() {
//     super.dispose();
//   }

//   List<Step> buildSteps(List<Map<String, dynamic>> stepsData) {
//     return stepsData.map((stepData) {
//       return Step(
//         title: Text(stepData['subtype'] ?? ''),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Type: ${stepData['type'] ?? ''}'),
//             Text('By: ${stepData['by'] ?? ''}'),
//             Text('From: ${stepData['from'] ?? ''}'),
//             Text('To: ${stepData['to'] ?? ''}'),
//           ],
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView(
//         physics: ClampingScrollPhysics(),
//         padding: EdgeInsets.all(0),
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(children: children),
//           ),
//           // Container(
//           //   margin: EdgeInsets.only(top: 16),
//           //   height: 200,
//           //   child: PageView(
//           //     pageSnapping: true,
//           //     physics: ClampingScrollPhysics(),
//           //     controller: PageController(
//           //       initialPage: 0,
//           //       viewportFraction: 0.80,
//           //     ),
//           //     onPageChanged: (int page) {
//           //       setState(() {});
//           //     },
//           //     children: <Widget>[
//           //       FxContainer.bordered(
//           //         margin: EdgeInsets.only(
//           //             bottom: 8, right:0, top: 8),
//           //         padding: EdgeInsets.only(left: 16),
//           //         child: Container(
//           //           padding:
//           //               EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 8),
//           //           child: Column(
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             mainAxisAlignment: MainAxisAlignment.spaceAround,
//           //             children: <Widget>[
//           //               Row(
//           //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //                 crossAxisAlignment: CrossAxisAlignment.start,
//           //                 children: <Widget>[
//           //                   Column(
//           //                     crossAxisAlignment: CrossAxisAlignment.start,
//           //                     children: <Widget>[
//           //                       FxText.titleMedium("Order No: 381478",
//           //                           fontWeight: 600),
//           //                       FxText.bodySmall("Placed on april, 14,2020",
//           //                           fontWeight: 400),
//           //                     ],
//           //                   ),
//           //                   PopupMenuButton(
//           //                     itemBuilder: (BuildContext context) {
//           //                       return _textIconChoice
//           //                           .map((TextIconItem choice) {
//           //                         return PopupMenuItem(
//           //                           value: choice,
//           //                           child: Row(
//           //                             children: <Widget>[
//           //                               Icon(choice.iconData,
//           //                                   size: 18,
//           //                                   color:
//           //                                        appLightTheme.medicarePrimary),
//           //                               Padding(
//           //                                 padding: EdgeInsets.only(left: 8),
//           //                                 child: FxText.bodyMedium(
//           //                                   choice.text,
//           //                                 ),
//           //                               )
//           //                             ],
//           //                           ),
//           //                         );
//           //                       }).toList();
//           //                     },
//           //                     icon: Icon(
//           //                       Icons.more_vert,
//           //                       color:  appLightTheme.medicarePrimary,
//           //                     ),
//           //                     color: appLightTheme.medicareOnPrimary,
//           //                   )
//           //                 ],
//           //               ),

//           //             ],
//           //           ),
//           //         ),
//           //       ),
//           //       FxContainer.bordered(
//           //         margin: EdgeInsets.only(bottom: 8, right: 12, left: 12, top: 8),
//           //         padding: EdgeInsets.only(left: 16),
//           //         child: Container(
//           //           padding:
//           //               EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 8),
//           //           child: Column(
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             mainAxisAlignment: MainAxisAlignment.spaceAround,
//           //             children: <Widget>[
//           //               Row(
//           //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //                 crossAxisAlignment: CrossAxisAlignment.start,
//           //                 children: <Widget>[
//           //                   Column(
//           //                     crossAxisAlignment: CrossAxisAlignment.start,
//           //                     children: <Widget>[
//           //                       FxText.titleMedium("Order No: 47856521",
//           //                           fontWeight: 600),
//           //                       FxText.bodySmall("Placed on feb, 14,2020",
//           //                           fontWeight: 400),
//           //                     ],
//           //                   ),
//           //                   PopupMenuButton(
//           //                     itemBuilder: (BuildContext context) {
//           //                       return _textIconChoice
//           //                           .map((TextIconItem choice) {
//           //                         return PopupMenuItem(
//           //                           value: choice,
//           //                           child: Row(
//           //                             children: <Widget>[
//           //                               Icon(choice.iconData,
//           //                                   size: 18,
//           //                                   color:
//           //                                        appLightTheme.medicarePrimary),
//           //                               Padding(
//           //                                 padding: EdgeInsets.only(left: 8),
//           //                                 child: FxText.bodyMedium(
//           //                                   choice.text,
//           //                                 ),
//           //                               )
//           //                             ],
//           //                           ),
//           //                         );
//           //                       }).toList();
//           //                     },
//           //                     icon: Icon(
//           //                       Icons.more_vert,
//           //                       color:  appLightTheme.medicarePrimary,
//           //                     ),
//           //                     color: appLightTheme.medicareOnPrimary,
//           //                   )
//           //                 ],
//           //               ),
//           //               FxText.titleSmall("Cash on Delivery", fontWeight: 600),
//           //               Row(
//           //                 crossAxisAlignment: CrossAxisAlignment.start,
//           //                 children: <Widget>[
//           //                   FxText.titleSmall("Status : ", fontWeight: 500),
//           //                   FxText.titleMedium("Delivered", fontWeight: 600),
//           //                 ],
//           //               )
//           //             ],
//           //           ),
//           //         ),
//           //       ),
//           //       FxContainer.bordered(
//           //         margin: EdgeInsets.only(
//           //             top: 8, bottom: 8, left:12),
//           //         child: Center(
//           //           child: FxText.titleMedium("VIEW ALL",
//           //               fontWeight: 600,
//           //               letterSpacing: 0.5,
//           //               color:  appLightTheme.medicarePrimary.withAlpha(200)),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           // Container(
//           //   margin: FxSpacing.nBottom(20),
//           //   child: FxText.titleSmall("STATUS",
//           //       fontWeight: 700,
//           //       color:  appLightTheme.medicarePrimary.withAlpha(200)),
//           // ),
//           StreamBuilder<List<Map<String, dynamic>>?>(
//             stream: DbSupa.instance
//                 .streamLeadActivityLog('${widget.leadDetails.id}')
//                 .asStream(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return SkeletonCard();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Text('No lead activity logs found.');
//               } else {
//                 List<Map<String, dynamic>> stepsData = snapshot.data!;
//                 return Stepper(
//                   physics: ClampingScrollPhysics(),
//                   controlsBuilder:
//                       (BuildContext context, ControlsDetails details) {
//                     return Container();
//                   },
//                   currentStep: _currentStep < buildSteps(stepsData).length
//                       ? _currentStep
//                       : 0,
//                   onStepTapped: (pos) {
//                     setState(() {
//                       _currentStep = pos;
//                     });
//                   },
//                   steps: buildSteps(stepsData),
//                 );
//                 return ListView.builder(
//                     primary: false,
//                     physics: const BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (c, i) {
//                       return Text('No lead activity logs found. ${i}');
//                     });
//                 return Text(
//                     'No lead activity logs found. ${snapshot.data!.length}');
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final log = snapshot.data![index];
//                       // Customize the list item UI according to your data structure
//                       return ListTile(
//                         title: Text(log['type'] ?? ''),
//                         subtitle: Text(log['subtype'] ?? ''),
//                         // Add more widgets to display other log data
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           ),
//           Stepper(
//             physics: ClampingScrollPhysics(),
//             controlsBuilder: (BuildContext context, ControlsDetails details) {
//               return Container();
//             },
//             currentStep: _currentStep,
//             onStepTapped: (pos) {
//               setState(() {
//                 _currentStep = pos;
//               });
//             },
//             steps: <Step>[
//               Step(
//                 isActive: true,
//                 state: StepState.complete,
//                 title: FxText.bodyLarge('Order placed - 14 April',
//                     fontWeight: 600),
//                 content: FxText.titleSmall("Order was received by seller",
//                     fontWeight: 500),
//               ),
//               Step(
//                 isActive: true,
//                 state: StepState.complete,
//                 title: FxText.bodyLarge('Payment confirmed - 14 april',
//                     fontWeight: 600),
//                 content: SizedBox(
//                   child:
//                       FxText.titleSmall("Pay via debit card", fontWeight: 600),
//                 ),
//               ),
//               Step(
//                 isActive: true,
//                 state: StepState.complete,
//                 title:
//                     FxText.bodyLarge('Processing - 16 April', fontWeight: 600),
//                 content: SizedBox(
//                   child: FxText.titleSmall(
//                       "It may be take longer time than expected",
//                       fontWeight: 500),
//                 ),
//               ),
//               Step(
//                 isActive: true,
//                 state: StepState.indexed,
//                 title: FxText.bodyLarge('On the way', fontWeight: 600),
//                 content: SizedBox(
//                   child: FxText.titleSmall(
//                       "Jenifer picked your order, you can contact her anytime",
//                       fontWeight: 500),
//                 ),
//               ),
//               Step(
//                 state: StepState.indexed,
//                 title: FxText.bodyLarge('Deliver', fontWeight: 600),
//                 content: SizedBox(
//                   child: FxText.titleSmall(
//                       "Today at 2:30 PM order has been deliver",
//                       fontWeight: 500),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
