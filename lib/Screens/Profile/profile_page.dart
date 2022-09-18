import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Profile/profile_controller.dart';
import 'package:redefineerp/themes/themes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ProfileController>(ProfileController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.theme.colorPrimary,
        leading: BackButton(
          color: Get.theme.btnTextCol,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Get.theme.colorPrimary,
        child: Column(
          children: [
            Text(
              'Profile',
              style: Get.theme.kNormalStyle.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Hero(
              tag: 'profile',
              child: Material(
                type: MaterialType.transparency,
                child: CircleAvatar(
                  backgroundColor: Get.theme.colorPrimaryDark,
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    color: Get.theme.colorPrimary,
                    size: 60,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Obx(()=>Text(
              controller.homePageController.userName.value,
              style: Get.theme.kNormalStyle.copyWith(fontSize: 16),
            ),),
            Obx(()=>Text(
              controller.homePageController.userEmail.value,
              style: Get.theme.kNormalStyle,
            ),),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.94,
                child: const Divider(color: Colors.grey, thickness: 0.2),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Account Setting',
                    style: Get.theme.kNormalStyle.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Info',
                              style: Get.theme.kNormalStyle,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            const Text(
                              'Edit and view your information ',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                        ),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.94,
              child: const Divider(color: Colors.black, thickness: 0.2),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Extra',
                    style: Get.theme.kNormalStyle.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Text(
                          'Notification',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.66),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.022,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Text(
                          'Privacy & Policy',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.59),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.94,
              child: const Divider(color: Colors.grey, thickness: 0.2),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Log Out',
                style: Get.theme.kNormalStyle
                    .copyWith(color: Get.theme.colorPrimaryDark),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.94,
              child: const Divider(color: Colors.black, thickness: 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
