
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/projectDetails/unit_statusController.dart';
import 'package:redefineerp/themes/themes.dart';

class StatusScreen extends StatelessWidget {
  StatusScreen({super.key});

  UnitController unitController = Get.put(UnitController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.050,
                vertical: MediaQuery.of(context).size.height * 0.020,
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://imgs.search.brave.com/4CSQcgpx-dnGtoEF7-eZZMy9AEKaXfY4pLChJl5aBf4/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzJiLzM5/LzM3LzJiMzkzN2M1/NDU3M2U2NDY2ZjM3/YTRmYWU2NmI4YjJm/LmpwZw")),
                        borderRadius: BorderRadius.all(Radius.circular(21))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  Row(
                    children: [
                      Text(
                        "60% Complete",
                        style: headline2,
                      ),
                      Spacer(),
                      Text(
                        "2 days left",
                        style: titleNormal,
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.010,
                  ),
                  LinearProgressIndicator(
                    backgroundColor: const Color(0xFFE3E5E5),
                    color: appLightTheme.primaryColorDark,
                    value: 0.6,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.010,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Color(0xFF979C9E),
                        size: MediaQuery.of(context).size.width * 0.050,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.010,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Start: ",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.8,
                                  color: Color(0xFF72777A))),
                          TextSpan(
                              text: "Aug 21",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.8,
                                  color: Color(0xFF303437)))
                        ]),
                      ),
                      Spacer(),
                      ImageIcon(AssetImage("assets/images/check.png")),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.010,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "End: ",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.8,
                                  color: Color(0xFF72777A))),
                          TextSpan(
                              text: "Mar 02",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.8,
                                  color: Color(0xFF303437)))
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.all(0),
                    title: Row(
                      children: [
                        Text(
                          "Initial Planning",
                          style: headline6,
                        ),
                        Spacer(),
                        Icon(
                          Icons.check_circle,
                          color: appGreenTheme.primaryColor,
                          size: MediaQuery.of(context).size.height * 0.030,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.010,
                        ),
                        Text(
                          "3 Tasks",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.8,
                              color: Color(0xFF72777A)),
                        )
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: unitController.foundation.value,
                                        onChanged:
                                            unitController.onFoundChange),
                                    title: Text("Foundation"),
                                    trailing: SizedBox()),
                              ),
                              SizedBox()
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: false, onChanged: (value) {}),
                                    title: Text("Slab"),
                                    trailing: SizedBox()),
                              ),
                              SizedBox()
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: false, onChanged: (value) {}),
                                    title: Text("Pillars"),
                                    trailing: SizedBox()),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.040,
                                width: MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFEFD7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13))),
                                child: Center(
                                  child: Text(
                                    "In Progress ",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xFFA05E03)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.all(0),
                    title: Row(
                      children: [
                        Text(
                          "Preliminary Concepts",
                          style: headline6,
                        ),
                        Spacer(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.020,
                          width: MediaQuery.of(context).size.width * 0.040,
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xFFE3E5E5),
                            value: 0.6,
                            color: appGreenTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.020,
                        ),
                        Text(
                          "3 Tasks",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.8,
                              color: Color(0xFF72777A)),
                        )
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: unitController.foundation.value,
                                        onChanged:
                                            unitController.onFoundChange),
                                    title: Text("Foundation"),
                                    trailing: SizedBox()),
                              ),
                              SizedBox()
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: false, onChanged: (value) {}),
                                    title: Text("Slab"),
                                    trailing: SizedBox()),
                              ),
                              SizedBox()
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: false, onChanged: (value) {}),
                                    title: Text("Pillars"),
                                    trailing: SizedBox()),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.040,
                                width: MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFEFD7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13))),
                                child: Center(
                                  child: Text(
                                    "In Progress ",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xFFA05E03)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.all(0),
                    title: Row(
                      children: [
                        Text(
                          "Refining Concepts",
                          style: headline6,
                        ),
                        Spacer(),
                        DottedBorder(
                          borderType: BorderType.Circle,
                          radius: Radius.circular(27.0),
                          dashPattern: [3, 3],
                          strokeWidth: 1,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.020,
                            width: MediaQuery.of(context).size.width * 0.040,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.015,
                        ),
                        Text(
                          "3 Tasks",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.8,
                              color: Color(0xFF72777A)),
                        )
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: unitController.foundation.value,
                                        onChanged:
                                            unitController.onFoundChange),
                                    title: Text("Foundation"),
                                    trailing: SizedBox()),
                              ),
                              SizedBox()
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: false, onChanged: (value) {}),
                                    title: Text("Slab"),
                                    trailing: SizedBox()),
                              ),
                              SizedBox()
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: ListTile(
                                    leading: Checkbox(
                                        value: false, onChanged: (value) {}),
                                    title: Text("Pillars"),
                                    trailing: SizedBox()),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.040,
                                width: MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFEFD7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13))),
                                child: Center(
                                  child: Text(
                                    "In Progress ",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xFFA05E03)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
