
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/Widgets/buttons.dart';
import 'package:redefineerp/themes/themes.dart';



class UnitRequest extends StatelessWidget {
  const UnitRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.050,
            vertical: MediaQuery.of(context).size.height * 0.020,
          ),
          child: Column(
            children: [
              ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  initiallyExpanded: true,
                  title: Row(
                    children: [
                      Text(
                        "New Requests",
                        style: headline2,
                      ),
                      Spacer(),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.030,
                        width: MediaQuery.of(context).size.height * 0.030,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "2",
                            style: buttontext,
                          ),
                        ),
                      )
                    ],
                  ),
                  children: [
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.010,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.020,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.020,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.0200,
                            ),
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(23)),
                                color: Color(0xFFF7F9FA)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Lorem ipsum dolor",
                                      style: headline2,
                                    ),
                                    Spacer(),
                                    Icon(Icons.emoji_emotions_outlined)
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.020,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_outline),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.030,
                                    ),
                                    Text(
                                      "User20233",
                                      style: tinyRegular,
                                    ),
                                    Spacer(),
                                    Text(
                                      "Sat 03:12 PM",
                                      style: tinyRegular,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.030,
                                ),
                                Text(
                                  '''Lorem ipsum dolor sit amet, consecteturin jizzredt adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nec ullamcorper sit amet risus nullam egetklyyu. Lorem ipsum dolor sit amet, consecteturin jizzredt adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nec ullamcorper sit amet risus nullam egetklyyu.''',
                                  style: tinyRegular,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.034,
                                ),
                                Row(
                                  children: [
                                    Buttons(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.050,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        color: primaryLighther,
                                        radius: 60,
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: appLightTheme
                                                    .primaryColorDark),
                                          ),
                                        )),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.030,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _request(context);
                                      },
                                      child: Buttons(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.050,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        color: appLightTheme.primaryColor,
                                        child: Center(
                                          child: Text(
                                            "Review Request",
                                            style: buttontext,
                                          ),
                                        ),
                                        radius: 60,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
              ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  title: Text(
                    "Pending Requests",
                    style: headline2,
                  ),
                  children: [
                    ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.020,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.020,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.020,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.0200,
                            ),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(23)),
                                color: Color(0xFFF7F9FA)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Lorem ipsum dolor",
                                      style: headline2,
                                    ),
                                    Spacer(),
                                    Icon(Icons.emoji_emotions_outlined)
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.020,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_outline),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.030,
                                    ),
                                    Text(
                                      "User20233",
                                      style: tinyRegular,
                                    ),
                                    Spacer(),
                                    Text(
                                      "Sat 03:12 PM",
                                      style: tinyRegular,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.030,
                                ),
                                Text(
                                  '''Lorem ipsum dolor sit amet, consecteturin jizzredt adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nec ullamcorper sit amet risus nullam egetklyyu. Lorem ipsum dolor sit amet, consecteturin jizzredt adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nec ullamcorper sit amet risus nullam egetklyyu.''',
                                  style: tinyRegular,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.034,
                                ),
                                Row(
                                  children: [
                                    Buttons(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.050,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        color: primaryLighther,
                                        radius: 60,
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: appLightTheme
                                                    .primaryColorDark),
                                          ),
                                        )),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.030,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _request(context);
                                      },
                                      child: Buttons(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.050,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        color: appLightTheme.primaryColor,
                                        child: Center(
                                          child: Text(
                                            "Review Request",
                                            style: buttontext,
                                          ),
                                        ),
                                        radius: 60,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
              ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  title: Text(
                    "Resolve Requests",
                    style: headline2,
                  ),
                  children: [
                    ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.020,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.020,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.020,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.0200,
                            ),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(23)),
                                color: Color(0xFFF7F9FA)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Lorem ipsum dolor",
                                      style: headline2,
                                    ),
                                    Spacer(),
                                    Icon(Icons.emoji_emotions_outlined)
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.020,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_outline),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.030,
                                    ),
                                    Text(
                                      "User20233",
                                      style: tinyRegular,
                                    ),
                                    Spacer(),
                                    Text(
                                      "Sat 03:12 PM",
                                      style: tinyRegular,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.030,
                                ),
                                Text(
                                  '''Lorem ipsum dolor sit amet, consecteturin jizzredt adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nec ullamcorper sit amet risus nullam egetklyyu. Lorem ipsum dolor sit amet, consecteturin jizzredt adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nec ullamcorper sit amet risus nullam egetklyyu.''',
                                  style: tinyRegular,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.034,
                                ),
                                Row(
                                  children: [
                                    Buttons(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.050,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        color: primaryLighther,
                                        radius: 60,
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: appLightTheme
                                                    .primaryColorDark),
                                          ),
                                        )),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.030,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _request(context);
                                      },
                                      child: Buttons(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.050,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        color: appLightTheme.primaryColor,
                                        child: Center(
                                          child: Text(
                                            "Review Request",
                                            style: buttontext,
                                          ),
                                        ),
                                        radius: 60,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
            ],
          ),
        ),
      )),
    );
  }

  _request(BuildContext context) {
    Get.defaultDialog(
        title: 'Review Request',
        titleStyle: headline1,
        contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.020),
        content: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.020),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
              Center(
                child: Text(
                  '''       The Lorem ipsum dolor sit amet,        
                  consecteturin jizzredt''',
                  style: displaySmall,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Placeholder text',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: new BorderSide(color: Colors.teal)),
                  labelText: '',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
              Buttons(
                height: MediaQuery.of(context).size.height * 0.0650,
                width: MediaQuery.of(context).size.width * 1,
                color: appLightTheme.primaryColor,
                child: Center(
                  child: Text(
                    "Confirm",
                    style: buttontext,
                  ),
                ),
                radius: 60,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.030,
              ),
              Text(
                "Keep on Hold",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.4,
                    color: appLightTheme.primaryColor),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.030,
              ),
            ],
          ),
        ));
  }
}
