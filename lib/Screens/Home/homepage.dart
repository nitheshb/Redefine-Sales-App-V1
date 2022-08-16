import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/checkboxlisttile.dart';
import 'package:redefineerp/Widgets/datewidget.dart';
import 'package:redefineerp/Widgets/headerbg.dart';
import 'package:redefineerp/Widgets/minimsg.dart';
import 'package:redefineerp/themes/themes.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    onPressed: () => {},
                    icon: Icon(
                      Icons.filter_list_rounded,
                      color: Get.theme.btnTextCol,
                    ),
                  ),
                )
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 35),
                    child: Text(
                      'Morning, Nitesh',
                      style: Get.theme.kTitleStyle
                          .copyWith(color: Get.theme.btnTextCol),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 2, bottom: 20),
                    child: Text('10/10 Tasks pending',
                        style: Get.theme.kSubTitle
                            .copyWith(color: Get.theme.colorAccent)),
                  ),
                ],
              ),
              bottom: TabBar(
                  onTap: (value) => {
                        controller.tabIndex.value = value,
                      },
                  isScrollable: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  indicatorColor: Get.theme.colorPrimaryDark,
                  labelColor: Get.theme.colorPrimaryDark,
                  labelStyle: Get.theme.kNormalStyle,
                  unselectedLabelColor: Get.theme.btnTextCol.withOpacity(0.2),
                  tabs: [
                    Tab(
                        icon: Row(
                      children: [
                        Text(
                          'Today',
                          style: Get.theme.kNormalStyle,
                        ),
                        tabTaskIndicator(
                            taskNum: 10, index: 0, controller: controller),
                      ],
                    )),
                    Tab(
                      icon: Row(
                        children: [
                          Text(
                            'Upcoming',
                            style: Get.theme.kNormalStyle,
                          ),
                          tabTaskIndicator(
                              taskNum: 2, index: 1, controller: controller),
                        ],
                      ),
                    ),
                    Tab(
                      icon: Row(
                        children: [
                          Text(
                            'Created',
                            style: Get.theme.kNormalStyle,
                          ),
                          tabTaskIndicator(
                              taskNum: 2, index: 2, controller: controller),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {},
            backgroundColor: Get.theme.kBlueColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                firstTab(),
                secondTab(),
                thirdTab(),
              ]),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                onTap: controller.bottomBarOnTap,
                currentIndex: controller.bottomBarIndex.value,
                selectedItemColor: Get.theme.colorPrimaryDark,
                unselectedItemColor: Get.theme.btnTextCol.withOpacity(0.3),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outlined),
                      activeIcon: Icon(Icons.check_circle_rounded),
                      label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications_outlined),
                      activeIcon: Icon(Icons.notifications_rounded),
                      label: 'Inbox'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search_outlined),
                      activeIcon: Icon(Icons.search_rounded),
                      label: 'Search'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_outlined),
                      activeIcon: Icon(Icons.person_rounded),
                      label: 'Account'),
                ]),
          )),
    );
  }

  Widget tabTaskIndicator(
      {required int taskNum,
      required int index,
      required HomePageController controller}) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: index == controller.tabIndex.value
              ? Get.theme.colorPrimaryDark
              : null,
          borderRadius: BorderRadius.circular(12),
          border: index != controller.tabIndex.value
              ? Border.all(width: 2.0, color: Get.theme.curveBG)
              : null,
        ),
        child: Text(
          '$taskNum',
          style: Get.theme.kSubTitle.copyWith(
            color: index == controller.tabIndex.value
                ? Colors.white
                : Get.theme.btnTextCol.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  Widget firstTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          taskCheckBox(
              taskPriority: 1,
              taskPriorityNum: 2,
              selected: false,
              task:
                  'Collect insurance documents from Mr.Rajesh Sales Plan for New Product',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          taskCheckBox(
              taskPriority: 2,
              taskPriorityNum: 2,
              selected: false,
              task: 'Sales Plan for New Product',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 0,
              selected: false,
              task: 'Check Screens for Todo',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 0,
              selected: false,
              task: 'Check Screens for Todo',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 0,
              selected: false,
              task: 'Check Screens for Todo',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 0,
              selected: false,
              task: 'Check Screens for Todo',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
        ],
      ),
    );
  }

  Widget secondTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          DateWidget('Tommorow'),
          taskCheckBox(
              taskPriority: 1,
              taskPriorityNum: 4,
              selected: true,
              task: 'Preparing the images that will be used in the email A',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          DateWidget('14 Aug'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 0,
              selected: false,
              task: 'Make sure the product is working',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          taskCheckBox(
              taskPriority: 1,
              taskPriorityNum: 4,
              selected: false,
              task: 'Writing a description for the blog post A',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 0,
              selected: false,
              task: 'Preparing the email structure',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          DateWidget('15 Aug'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 0,
              selected: false,
              task: 'Finding the winner of the test',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
        ],
      ),
    );
  }

  Widget thirdTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          headerBg(
              title: 'Gif Design for page loading',
              createdOn: 'Created: 12 August | 11:00 PM',
              taskPriority: 1,
              taskPriorityNum: 2),
          miniMessage('Marked as done, pending for review'),
          DateWidget('Due Tommorow'),
          taskCheckBox(
              taskPriority: 2,
              taskPriorityNum: 4,
              selected: false,
              task: 'Completing the post in the new product page',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assigner: Mr. Tejesh'),
          DateWidget('14 Aug'),
          taskCheckBox(
              taskPriority: 1,
              taskPriorityNum: 2,
              selected: false,
              task: 'Going throuh bug report list',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assignee: Mr. Anshu'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 4,
              selected: false,
              task: 'Updating & Testing the colour selection',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assignee: Mr. Tejesh'),
          DateWidget('15 Aug'),
          taskCheckBox(
              taskPriority: 3,
              taskPriorityNum: 0,
              selected: false,
              task: 'Presentation Regarding',
              createdOn: 'Created: 12 August | 11:00 PM',
              assigner: 'Assignee: Mr. Tejesh'),
        ],
      ),
    );
  }
}
