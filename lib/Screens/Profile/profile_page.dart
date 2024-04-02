import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Auth/login_page.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/OnBoarding/onboarding_page.dart';
import 'package:redefineerp/Screens/Profile/profile_controller.dart';
import 'package:redefineerp/themes/FxButton.dart';
import 'package:redefineerp/themes/constant.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    final controller = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
      final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
          backgroundColor: const Color(0xff0D0D0D),  
      
      body: SingleChildScrollView(
        child: Container(
          padding: FxSpacing.fromLTRB(
                      20, FxSpacing.safeAreaTop(context) + 16, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
               titleRow(),
        FxSpacing.height(20),
               FxContainer(
          padding: FxSpacing.fromLTRB(10, 16, 20, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.titleLarge(auth.currentUser!.displayName!.toUpperCase(), fontWeight: 600),
                  Container(
                    margin: FxSpacing.top(4),
                    child: FxText.bodySmall(
                      auth.currentUser!.email!.toUpperCase(),
                    ),
                  ),
                
                  FxText.bodySmall(
                    "Sales Executive",
                  ),
                  FxText.bodySmall("See more",
                      decoration: TextDecoration.underline),
                ],
              ),
            ],
          ),
        ),
         
              

            
                    FxSpacing.height(32),
 IntrinsicHeight(
                child: Container(
                  color: Color(0xff1C1C1E),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            FxText.bodyMedium(
                              '0',
                              fontWeight: 700,
                              color: Color(0xffF7F7F7),
                            ),
                            FxSpacing.height(6),
                            FxText.bodySmall(
                              'Calls',
                              fontWeight: 600,
                              xMuted: true,
                              color: Color(0xffF7F7F7),
                            ),
                          ],
                        ),
                        VerticalDivider(),
                        Column(
                          children: [
                            FxText.bodyMedium(
                              '0',
                              fontWeight: 700,
                              color: Color(0xffF7F7F7),
                            ),
                            FxSpacing.height(6),
                            FxText.bodySmall(
                              'Leads',
                              fontWeight: 600,
                              xMuted: true,
                              color: Color(0xffF7F7F7),

                            ),
                          ],
                        ),
                        VerticalDivider(),
                        Column(
                          children: [
                            FxText.bodyMedium(
                              '0',
                              fontWeight: 700,
                              color: Color(0xffF7F7F7),
                            ),
                            FxSpacing.height(6),
                            FxText.bodySmall(
                              'Bookings',
                              fontWeight: 600,
                              xMuted: true,
                              color: Color(0xffF7F7F7),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
       
                    FxSpacing.height(32),

                    other(),
                    FxSpacing.height(40),
                    // account(),

                    Center(
                      child:     Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                          FeatherIcons.power,
                                          size: 18,
                                          color: Get.theme.primary,
                                        ),
                            FxButton.text(
                                        padding: FxSpacing.zero,
                                        onPressed: () {
                                           FirebaseAuth.instance
                            .signOut()
                            .then((value) => Get.offAll(() => LoginPage()));
                                        },
                                        child: FxText.bodyMedium(
                                          'Logout',
                                          color: Get.theme.primary,
                                          fontWeight: 600,
                                        )),
                          ],
                        ),
                      ),
                    )
              
            ],
          ),
        ),
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
        FxText.titleMedium(
          "My Profile",
          fontWeight: 600,
        ),
      ],
    );
  }

   Widget statistics() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: FxContainer(
              paddingAll: 12,
              child: Row(
                children: [
                  FxContainer(
                      paddingAll: 10,
                      color: Constant.softColors.green.color,
                      child: Icon(
                        Icons.work_outlined,
                        size: 18,
                        color: Constant.softColors.green.onColor,
                      )),
                  FxSpacing.width(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.bodySmall(
                        'Completed',
                        fontWeight: 600,
                      ),
                      FxSpacing.height(4),
                      FxText.bodyMedium(
                        '11',
                        fontWeight: 600,
                      ),
                    ],
                  )
                ],
              ),
            )),
            FxSpacing.width(16),
            Expanded(
                child: FxContainer(
              paddingAll: 10,
              child: Row(
                children: [
                  FxContainer(
                      paddingAll: 10,
                      color: Constant.softColors.blue.color,
                      child: Icon(
                        Icons.work_off_outlined,
                        size: 18,
                        color: Constant.softColors.blue.onColor,
                      )),
                  FxSpacing.width(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.bodySmall(
                        'Todo',
                        fontWeight: 600,
                      ),
                      FxSpacing.height(4),
                      FxText.bodyMedium(
                        '284',
                        fontWeight: 600,
                      ),
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
        FxSpacing.height(16),
        Row(
          children: [
            Expanded(
                child: FxContainer(
              paddingAll: 12,
              child: Row(
                children: [
                  FxContainer(
                      paddingAll: 10,
                      color: Constant.softColors.violet.color,
                      child: Icon(
                        FeatherIcons.users,
                        size: 18,
                        color: Constant.softColors.violet.onColor,
                      )),
                  FxSpacing.width(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.bodySmall(
                        'Following',
                        fontWeight: 600,
                      ),
                      FxSpacing.height(4),
                      FxText.bodyMedium(
                        '48',
                        fontWeight: 600,
                      ),
                    ],
                  )
                ],
              ),
            )),
            FxSpacing.width(16),
            Expanded(
                child: FxContainer(
              paddingAll: 10,
              child: Row(
                children: [
                  FxContainer(
                      paddingAll: 10,
                      color: Constant.softColors.pink.color,
                      child: Icon(
                        Icons.alt_route_outlined,
                        size: 18,
                        color: Constant.softColors.pink.onColor,
                      )),
                  FxSpacing.width(12),
                  Row(
                    children: [
                      FxText.bodySmall(
                        'View All',
                        fontWeight: 600,
                      ),
                      FxSpacing.width(4),
                      const Icon(
                        FeatherIcons.chevronRight,
                        size: 16,
                      )
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }



    Widget ChangeThemeColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.bodySmall(
          'Change Theme',
          fontWeight: 600,
          muted: true,
        ),
        FxSpacing.height(20),
         Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.currentTheme.value = 'green';
                            controller.changeTheme(controller.currentTheme.value);
                          },
                          child: const FxContainer(
              paddingAll: 10,
              height: 24,
              width:24,
                            color: Color(0xFF4CD471),

                          )
                          
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            controller.currentTheme.value = 'blue';
                            controller.changeTheme(controller.currentTheme.value);
                          },
                          child: const FxContainer(
              paddingAll: 10,
              height: 24,
              width:24,
                            color: Color(0xFF6EC2FB),

                          )
                          
                        ),
                        const SizedBox(width: 12),
      
                        GestureDetector(
                          onTap: () {
                            controller.currentTheme.value = 'light';
                            controller.changeTheme(controller.currentTheme.value);
                          },
                          child: const FxContainer(
              paddingAll: 10,
              height: 24,
              width:24,
                            color: Color(0xFFFF7562),

                          )
                          
                        ),
                        const SizedBox(width: 12),
      
                        // CircleAvatar(
                        //   backgroundColor: Color(0xFF303437),
                        //   radius: MediaQuery.of(context).size.width * 0.030,
                        // ),
                        const SizedBox(width: 12),
                      ],
                    ),
                   
       
        ],
    );
  }

  Widget other() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FxText.bodySmall(
        //   'Settings',
        //   fontWeight: 600,
        //   muted: true,
        //    color:Color(0xff8C8E8F)
        // ),
   FxSpacing.height(16),
        Row(
          children: [
            FxContainer(
              paddingAll: 8,
              color: Colors.transparent,
              child: Icon(
                Icons.notifications,
                size: 20,
                color: Color(0xffD9886A),
              ),
            ),
            FxSpacing.width(16),
            Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.titleSmall('Notification', fontWeight: 600, color:Color(0xff8C8E8F) ),
              FxSpacing.height(4),
              FxText.bodySmall(
                'Tasks,Calls,Reminders',
                fontWeight: 600,
                xMuted: true,
                fontSize: 10,
                 color:Color(0xff8C8E8F)
              ),
            ],
          ),),
            FxSpacing.width(16),
            Row(
              children: [
                FxContainer.rounded(
                  height: 24,
                  width: 24,
                  paddingAll: 0,
                  color: Color(0xff58423B),
                  child: Center(
                    child: FxText.bodySmall(
                      '0',
                      color: Get.theme.onPrimary,
                    
                    ),
                  ),
                ),
                FxSpacing.width(4),
                Icon(
                  FeatherIcons.chevronRight,
                  size: 18,
                  color: Color(0xffD9886A),

                )
              ],
            )
          ],
        ),
        FxSpacing.height(16),
        Row(
          children: [
            FxContainer(
              paddingAll: 8,
              color: Colors.transparent,
              child: Icon(
                Icons.delete_forever,
                size: 20,
                                color: Color(0xffD9886A),

 
              ),
            ),
            FxSpacing.width(16),
            Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.titleSmall('Delete Account', fontWeight: 600, color:Color(0xff8C8E8F) ),
              FxSpacing.height(4),
              FxText.bodySmall(
                'Removes accounts from Redefine',
                fontWeight: 600,
                xMuted: true,
                fontSize: 10,
                 color:Color(0xff8C8E8F)
              ),
            ],
          )),
            FxSpacing.width(16),
            const Icon(
              FeatherIcons.chevronRight,
              size: 20,
            )
          ],
        ),
        FxSpacing.height(16),
        Row(
          children: [
            FxContainer(
              paddingAll: 8,
              color: Colors.transparent,
              child: Icon(
                Icons.privacy_tip_outlined,
                size: 20,
                  color: Color(0xffD9886A),

              ),
            ),
            FxSpacing.width(16),
            Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.titleSmall('Privacy Policy', fontWeight: 600, color:Color(0xff8C8E8F) ),
              FxSpacing.height(4),
              FxText.bodySmall(
                'Data Policy',
                fontWeight: 600,
                xMuted: true,
                fontSize: 10,
                 color:Color(0xff8C8E8F)
              ),
            ],
          )),
            FxSpacing.width(16),
            Row(
              children: [
                FxText.bodySmall(
                  '',
                  color: Get.theme.onErrorContainer,
                  fontWeight: 600,
                ),
               
               const Icon(
              FeatherIcons.chevronRight,
              size: 20,
            )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget account() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.bodySmall(
          'My Account',
          fontWeight: 600,
          xMuted: true,
        ),
        FxSpacing.height(8),
 
        FxButton.text(
            padding: FxSpacing.zero,
            onPressed: () {
               FirebaseAuth.instance
                      .signOut()
                      .then((value) => Get.offAll(() => LoginPage()));
            },
            child: FxText.bodyMedium(
              'Logout',
              color: Get.theme.primary,
              fontWeight: 600,
            )),
     
      ],
    );
  }
}
