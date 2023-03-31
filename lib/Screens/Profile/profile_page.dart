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
              paddingAll: 10,
              child: Row(
              children: [
                Hero(
                  tag: 'profile',
                  child: Material(
                    type: MaterialType.transparency,
                    child:   FxContainer(
                        paddingAll: 10,
              color: Constant.softColors.violet.color,
              child: Icon(
                Icons.person,
                size: 18,
                color: Constant.softColors.violet.onColor,
              ),
                      
                    ),
                  ),
                ),
            
                FxSpacing.width(10),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                          FxText.bodySmall(
                            '${auth.currentUser!.displayName!.toUpperCase()}',
                            fontWeight: 600,
                          ),
                          FxText.bodySmall(
                            '${auth.currentUser!.email!.toUpperCase()}',
                            fontWeight: 600,
                          ),
                      
                         ],
                       ),
                  
                             
                    ],
                  ),
            ),
              

               FxSpacing.height(14),
                    statistics(),
                    FxSpacing.height(24),

                    ChangeThemeColor(),
                    FxSpacing.height(24),

                    other(),
                    FxSpacing.height(24),
                    account(),
              
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
        FxText.bodySmall(
          'Settings',
          fontWeight: 600,
          muted: true,
        ),
        FxSpacing.height(20),
        Row(
          children: [
            FxContainer(
              paddingAll: 8,
              color: Constant.softColors.blue.color,
              child: Icon(
                Icons.notifications,
                size: 20,
                color: Constant.softColors.blue.onColor,
              ),
            ),
            FxSpacing.width(16),
            Expanded(child: FxText.bodyMedium('Notifications')),
            FxSpacing.width(16),
            Row(
              children: [
                FxContainer.rounded(
                  height: 24,
                  width: 24,
                  paddingAll: 0,
                  color: Get.theme.primary,
                  child: Center(
                    child: FxText.bodySmall(
                      '4',
                      color: Get.theme.onPrimary,
                    ),
                  ),
                ),
                FxSpacing.width(4),
                Icon(
                  FeatherIcons.chevronRight,
                  size: 18,
                  color: Get.theme.primary,
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
              color: Constant.softColors.green.color,
              child: Icon(
                Icons.delete_forever,
                size: 20,
                color: Constant.softColors.green.onColor,
              ),
            ),
            FxSpacing.width(16),
            Expanded(child: FxText.bodyMedium('Delete Account')),
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
              color: Constant.softColors.orange.color,
              child: Icon(
                Icons.privacy_tip_outlined,
                size: 20,
                color: Constant.softColors.orange.onColor,
              ),
            ),
            FxSpacing.width(16),
            Expanded(child: FxText.bodyMedium('Privacy Policy')),
            FxSpacing.width(16),
            Row(
              children: [
                FxText.bodySmall(
                  'Action Needed',
                  color: Get.theme.onErrorContainer,
                  fontWeight: 600,
                ),
                FxSpacing.width(4),
                Icon(
                  FeatherIcons.chevronRight,
                  size: 18,
                  color: Get.theme.onErrorContainer,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.bodySmall(
          'My Account',
          fontWeight: 600,
          xMuted: true,
        ),
        FxSpacing.height(8),
        FxButton.text(
            padding: FxSpacing.zero,
            onPressed: () {},
            child: FxText.bodyMedium(
              'Switch to another account',
              color: Get.theme.primary,
              fontWeight: 600,
            )),
        FxSpacing.height(20),
        Center(
          child: FxButton(
              backgroundColor: Get.theme.ErrorContainer,
              elevation: 0,
              borderRadiusAll: Constant.buttonRadius.small,
              onPressed: () {
                 FirebaseAuth.instance
                      .signOut()
                      .then((value) => Get.offAll(() => LoginPage()));
              },
              child: FxText(
                'Logout',
                color: Get.theme.onErrorContainer,
                fontWeight: 600,
              )),
        )
      ],
    );
  }
}
