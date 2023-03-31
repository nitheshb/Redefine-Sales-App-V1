
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Screens/SuperHomePage/SuperHomePage_controller.dart';
import 'package:redefineerp/themes/FxTabIndicator.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/themes.dart';

class SuperHomePage extends StatefulWidget {
  @override
  State<SuperHomePage> createState() => _SuperHomePageState();
}

class _SuperHomePageState extends State<SuperHomePage>   with SingleTickerProviderStateMixin{
  final storageReference =
      FirebaseStorage.instance.ref().child('images/image.jpg');

  ImagePicker picker = ImagePicker();
  late FullAppController controller2;

  XFile? image;
    @override
  void initState() {
    controller2 = Get.put<FullAppController>(FullAppController(this));

  }

  @override
  Widget build(BuildContext context) {
    

    final controller = Get.put<HomePageController>(HomePageController());
    final controller1 = Get.put<ContactController>(ContactController());

    // TaskController controller1 = Get.put<TaskController>(TaskController());
    debugPrint("home called ${FirebaseAuth.instance.currentUser}");
     // Set the system status bar color
   
    return Scaffold(
      backgroundColor:Color(0xffffffff),
     
        body: Column(
              children: [
                Expanded(
                    child: TabBarView(
                  controller: controller2.tabController,
                  children: controller2.items,
                )),
                FxContainer(
                  bordered: true,
                  enableBorderRadius: false,
                  border: Border(
                      top: BorderSide(
                          color: Get.theme.dividerColor,
                          width: 1,
                          style: BorderStyle.solid)),
                  padding: FxSpacing.xy(12, 16),
                  color: Get.theme.scaffoldBackgroundColor,
                  child: TabBar(
                    controller: controller2.tabController,
                    indicator: FxTabIndicator(
                        indicatorColor: Get.theme.primary,
                        indicatorHeight: 3,
                        radius: 3,
                        indicatorStyle: FxTabIndicatorStyle.rectangle,
                        yOffset: -18),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Get.theme.primary,
                    tabs: buildTab(),
                  ),
                )
              ],)    
     );
     
  }


  
  List<Widget> buildTab() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller2.navItems.length; i++) {
      bool selected = controller2.currentIndex == i;
      tabs.add(Icon(controller2.navItems[i].iconData,
          size: 20,
          color: selected
              ? Get.theme.primary
              : Get.theme.primary));
    }
    return tabs;
  }
  
  Widget tabTaskIndicator(
      {required int taskNum,
      required BuildContext context,
      required int index,
      required HomePageController controller}) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: index == controller.tabIndex.value
              ? Get.theme.onPrimary
              : null,
          borderRadius: BorderRadius.circular(12),
          border: index != controller.tabIndex.value
              ? Border.all(width: 2.0, color: Get.theme.curveBG)
              : null,
        ),
        child: Text(
          '$taskNum',
          style: TextStyle(
              color: index == controller.tabIndex.value
                  ? Colors.white
                  : Get.theme.btnTextCol.withOpacity(0.3),
              fontSize: MediaQuery.of(context).size.height * 0.017),
        ),
      ),
    );
  }
}

