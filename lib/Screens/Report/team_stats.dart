import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redefineerp/Screens/Profile/profile_page.dart';
import 'package:redefineerp/themes/themes.dart';

class TeamStats extends StatefulWidget {
  VoidCallback flipAction;
  TeamStats(this.flipAction);
  @override
  State<TeamStats> createState() => _TeamStatsState();
}

class _TeamStatsState extends State<TeamStats> {
  var dayCompleted = 12;
  var dayTotal = 19;
  var weekCompleted = 38;
  var weekTotal = 57;
  var monthCompleted = 369;
  var monthTotal = 392;
  var isDay = true;
  var isWeek = false;
  var isMonth = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              // colors: [
              //   Color.fromRGBO(69, 115, 201, 1),
              //   Color.fromRGBO(69, 115, 201, 1),
              // ],

              colors: [Color(0xffefefef), Color(0xffBDFDE2), Color(0xffefefef),]
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Container(
                  height: 6,
                  width: 0,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.white),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Text(
                    '',
                    style: Get.theme.kNormalStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Row(
      
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2, top: 4),
                    child: IconButton(
                       
                      onPressed: () => {Get.to(() => const ProfilePage())},
                      icon: Hero(
                        tag: 'profile',
                        child: Material(
                          type: MaterialType.transparency,
                          child: CircleAvatar(
                            backgroundColor: Color(0xffBDFDE2),
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
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: 
                    Text(
                        'Hola, ${FirebaseAuth.instance.currentUser!.displayName}',
                        style: Get.theme.kTitleStyle
                            .copyWith(color: Get.theme.btnTextCol),
                      ),
                    
                                   ),

                                   Container()
                  
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           isDay = true;
              //           isWeek = false;
              //           isMonth = false;
              //         });
              //       },
              //       child: isDay == true
              //           ? Container(
              //               height: MediaQuery.of(context).size.height * 0.041,
              //               width: MediaQuery.of(context).size.width * 0.16,
              //               decoration: const BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(6),
              //                   bottomLeft: Radius.circular(6),
              //                 ),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   'Day',
              //                   style: Get.theme.kNormalStyle,
              //                 ),
              //               ),
              //             )
              //           : Container(
              //               height: MediaQuery.of(context).size.height * 0.041,
              //               width: MediaQuery.of(context).size.width * 0.16,
              //               decoration: const BoxDecoration(
              //                 color: Color.fromRGBO(253, 211, 211, 1),
              //                 borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(6),
              //                   bottomLeft: Radius.circular(6),
              //                 ),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   'Day',
              //                   style: Get.theme.kNormalStyle,
              //                 ),
              //               ),
              //             ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           isDay = false;
              //           isWeek = true;
              //           isMonth = false;
              //         });
              //       },
              //       child: isWeek == true
              //           ? Container(
              //               height: MediaQuery.of(context).size.height * 0.041,
              //               width: MediaQuery.of(context).size.width * 0.16,
              //               color: Colors.white,
              //               child: Center(
              //                 child: Text(
              //                   'Week',
              //                   style: Get.theme.kNormalStyle,
              //                 ),
              //               ),
              //             )
              //           : Container(
              //               height: MediaQuery.of(context).size.height * 0.041,
              //               width: MediaQuery.of(context).size.width * 0.16,
              //               color: const Color.fromRGBO(253, 211, 211, 1),
              //               child: Center(
              //                 child: Text(
              //                   'Week',
              //                   style: Get.theme.kNormalStyle,
              //                 ),
              //               ),
              //             ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           isDay = false;
              //           isWeek = false;
              //           isMonth = true;
              //         });
              //       },
              //       child: isMonth == true
              //           ? Container(
              //               height: MediaQuery.of(context).size.height * 0.041,
              //               width: MediaQuery.of(context).size.width * 0.16,
              //               decoration: const BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.only(
              //                   topRight: Radius.circular(6),
              //                   bottomRight: Radius.circular(6),
              //                 ),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   'Month',
              //                   style: Get.theme.kNormalStyle,
              //                 ),
              //               ),
              //             )
              //           : Container(
              //               height: MediaQuery.of(context).size.height * 0.041,
              //               width: MediaQuery.of(context).size.width * 0.16,
              //               decoration: const BoxDecoration(
              //                 color: Color.fromRGBO(253, 211, 211, 1),
              //                 borderRadius: BorderRadius.only(
              //                   topRight: Radius.circular(6),
              //                   bottomRight: Radius.circular(6),
              //                 ),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   'Month',
              //                   style: Get.theme.kNormalStyle,
              //                 ),
              //               ),
              //             ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.025,
              // ),

              // Row(
              //   children: [
              //     Container(
              //       width: 200,
              //       child: FAProgressBar(
              //                                         direction: Axis.horizontal,
              //                                         verticalDirection: VerticalDirection.up,
                                                     
              //                                     currentValue: 60,
              //                                     displayText: '%',
              //                                      progressColor: Color.fromARGB(255, 150, 243, 204),
              //                                     displayTextStyle: TextStyle(color:Colors.black),
              //                                   ),
              //     ),
              //   ],
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.110,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(254, 239, 239, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    (isDay)
                        ? Container(
                          child:    Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                
                          
                          //               Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.end,
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //             children: [
                          //               Text(
                          //                   dayCompleted.toString(),
                          //                   style: Get.theme.kNormalStyle.copyWith(
                          //                     fontSize: 32,
                          //                     color:
                          //                         const Color.fromRGBO(255, 117, 98, 1),
                          //                   ),
                          //                 ),
                          //                   Text(
                          //       'DONE',
                          //       style:
                          //           Get.theme.kNormalStyle.copyWith(fontSize: 12),
                          //     ),
                          //             ],
                          //           ),
                          // SizedBox(width:8),
                             
                                    FAProgressBar(
                                                direction: Axis.vertical,
                                                verticalDirection: VerticalDirection.up,
                                               
                                            currentValue: 60,
                                            displayText: '%',
                                             progressColor: Color.fromARGB(255, 150, 243, 204),
                                            displayTextStyle: TextStyle(color:Colors.black),
                                          ),
SizedBox(width:8),
                                             Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                         
                                            Text(
                                                dayCompleted.toString(),
                                                style: Get.theme.kNormalStyle.copyWith(
                                                  fontSize: 32,
                                                  color:
                                                      Color.fromARGB(255, 150, 243, 204),
                                                ),
                                              ),
                                          ],
                                        ),
                                            Text(
                                ' TODO',
                                style:
                                    Get.theme.kNormalStyle.copyWith(fontSize: 12),
                              ),
                                      ],
                                    ),
                                          
                              ],
                            ),
                          ),
                          )
                        : const SizedBox(),
                    isWeek
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0006,
                              left: MediaQuery.of(context).size.width * 0.132,
                            ),
                            child: CircularPercentIndicator(
                              radius: 26,
                              lineWidth: 6,
                              percent: (weekCompleted / weekTotal),
                              animateFromLastPercent: true,
                              progressColor:
                                  const Color.fromRGBO(51, 97, 255, 1),
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                '${((weekCompleted / weekTotal) * 100).toStringAsFixed(0)}%',
                                style: Get.theme.kNormalStyle,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    isMonth
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0006,
                              left: MediaQuery.of(context).size.width * 0.132,
                            ),
                            child: CircularPercentIndicator(
                              radius: 26,
                              lineWidth: 6,
                              percent: (monthCompleted / monthTotal),
                              animateFromLastPercent: true,
                              progressColor:
                                  const Color.fromRGBO(51, 97, 255, 1),
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                '${((monthCompleted / monthTotal) * 100).toStringAsFixed(0)}%',
                                style: Get.theme.kNormalStyle,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(
                        // top: MediaQuery.of(context).size.height * 0.017,
                        // left: MediaQuery.of(context).size.width * 0.132,
                        top: 30,
                              left: MediaQuery.of(context).size.width * 0.132,
                              // bottom: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: SizedBox(
                      
                        child: Column(
                          children: [
                           
                            isDay
                                ? Container(
                      
                            
                                 
                                )
                                : const SizedBox(),
                            isWeek
                                ? Row(
                                  children: [
                                    Text(
                                        weekCompleted.toString(),
                                        style: Get.theme.kNormalStyle.copyWith(
                                          fontSize: 32,
                                          color:
                                              const Color.fromRGBO(255, 117, 98, 1),
                                        ),
                                      ),
                                        Text(
                              'Completed',
                              style:
                                  Get.theme.kNormalStyle.copyWith(fontSize: 12),
                            ),
                                  ],
                                )
                                : const SizedBox(),
                            isMonth
                                ? Row(
                                  children: [
                                    Text(
                                        monthCompleted.toString(),
                                        style: Get.theme.kNormalStyle.copyWith(
                                          fontSize: 32,
                                          color:
                                              const Color.fromRGBO(255, 117, 98, 1),
                                        ),
                                      ),
                                        Text(
                              'Completed',
                              style:
                                  Get.theme.kNormalStyle.copyWith(fontSize: 12),
                            ),
                                  ],
                                )
                                : const SizedBox(),
                      
                               
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    color: const Color.fromRGBO(253, 211, 211, 1),
                    height: MediaQuery.of(context).size.height * 0.115,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                                children: [
                                  Text(
                                    'Total Tasks',
                                    style: Get.theme.kNormalStyle
                                        .copyWith(fontSize: 12),
                                  ),
                                  isDay
                                      ? Text(
                                          dayTotal.toString(),
                                          style:
                                              Get.theme.kNormalStyle.copyWith(
                                            fontSize: 32,
                                          ),
                                        )
                                      : const SizedBox(),
                                  isWeek
                                      ? Text(
                                          weekTotal.toString(),
                                          style:
                                              Get.theme.kNormalStyle.copyWith(
                                            fontSize: 32,
                                          ),
                                        )
                                      : const SizedBox(),
                                  isMonth
                                      ? Text(
                                          monthTotal.toString(),
                                          style:
                                              Get.theme.kNormalStyle.copyWith(
                                            fontSize: 32,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                                children: [
                                  Text(
                                    'Incomplete Tasks',
                                    style: Get.theme.kNormalStyle
                                        .copyWith(fontSize: 12),
                                  ),
                                  isDay
                                      ? Text(
                                          (dayTotal - dayCompleted).toString(),
                                          style:
                                              Get.theme.kNormalStyle.copyWith(
                                            fontSize: 32,
                                          ),
                                        )
                                      : const SizedBox(),
                                  isWeek
                                      ? Text(
                                          (weekTotal - weekCompleted)
                                              .toString(),
                                          style:
                                              Get.theme.kNormalStyle.copyWith(
                                            fontSize: 32,
                                          ),
                                        )
                                      : const SizedBox(),
                                  isMonth
                                      ? Text(
                                          (monthTotal - monthCompleted)
                                              .toString(),
                                          style:
                                              Get.theme.kNormalStyle.copyWith(
                                            fontSize: 32,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => widget.flipAction(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                child:
                                    SvgPicture.asset('assets/images/Flip.svg'),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Text(
                                'Tap to flip',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 117, 98, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromRGBO(252, 140, 123, 1),
                  Color.fromRGBO(245, 120, 146, 1),
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.12,
          ),
        )
      ],
    );
  }
}
