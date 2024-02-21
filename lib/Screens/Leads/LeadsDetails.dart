
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/projectDetails/unit_screen.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';

class LeadsDetailsScreen extends StatelessWidget {
  const LeadsDetailsScreen({required this.leadDetails, super.key});
  final leadDetails;
  @override
  Widget build(BuildContext context) {
    print('data1 ${leadDetails.data()}');

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
                          leadDetails['Name'],
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
                              leadDetails['Mobile'],
                              color: appLightTheme.onBackground,
                              xMuted: true,
                            ),
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
            FxSpacing.height(16),
            // Expanded(
            //     child: ListView(
            //   children: [
            //     _buildReceiveMessage(
            //         message: 'Yes, What help do you need?', time: '08:25'),
            //     FxSpacing.height(16),
            //     _buildSendMessage(
            //         message: 'Should I come to hospital tomorrow?',
            //         time: '08:30'),
            //     FxSpacing.height(16),
            //     _buildReceiveMessage(
            //         message: 'Yes sure, you can come after 2:00 pm',
            //         time: '08:35'),
            //     FxSpacing.height(16),
            //     _buildSendMessage(message: 'Sure, Thank you!!', time: '08:40'),
            //     FxSpacing.height(24),
            //     FxSpacing.height(16),
            //     _buildSendMessage(message: 'Sure, Thank you!!', time: '08:40'),
            //     FxSpacing.height(24),
                
            //   ],
            // )),
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
                          "${leadDetails['Name']}",
                          style: headline2,
                        ),
                      
                           RichText(
                          text: TextSpan(children: [
                          
                            TextSpan(
                                text: "${leadDetails?['Mobile']}",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.8,
                                    color: Color(0xFF303437))),
                                      TextSpan(
                                text: "-${leadDetails?['Name']} ",
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
}
