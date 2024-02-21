
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/projectDetails/unit_gallery.dart';
import 'package:redefineerp/Screens/projectDetails/unit_request.dart';
import 'package:redefineerp/Screens/projectDetails/unit_statusScreen.dart';
import 'package:redefineerp/themes/themes.dart';


class UnitDetailsScreen extends StatelessWidget {
  UnitDetailsScreen({this.unitDetails,super.key});
final unitDetails;
  @override
  Widget build(BuildContext context) {
    print("data 2 ${unitDetails.data()}");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.020,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.050,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                      ),
                      Text(
                        "Unit-${unitDetails['unit_no']} ",
                        style: headline2,
                      ),
                      const Spacer()
                    ],
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.010,
                // ),
                TabBar(
                    isScrollable: true,
                    labelColor: appLightTheme.primaryColor,
                    indicatorColor: appLightTheme.primaryColor,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Status',
                      ),
                      Tab(
                        text: 'Gallery',
                      ),
                      Tab(
                        text: 'Request',
                      ),
                    ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [StatusScreen(), UnitGallery(), UnitRequest()]),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
