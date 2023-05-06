import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:redefineerp/Screens/Dashboard/dashboard_pages.dart';
import 'package:redefineerp/Screens/Home/homepage.dart';
import 'package:redefineerp/Screens/Notification/notification_pages.dart';
import 'package:redefineerp/Screens/Profile/profile_page.dart';
import 'package:redefineerp/Screens/Search/search_task.dart';

class NavItem {
  final String title;
  final IconData iconData;

  NavItem(this.title, this.iconData);
}

class FullAppController extends GetxController {
  int currentIndex = 1;
  int pages = 4;
  late TabController tabController;

  final TickerProvider tickerProvider;

  late List<NavItem> navItems;
  late List<Widget> items;

  FullAppController(this.tickerProvider) {
    tabController =
        TabController(length: pages, vsync: tickerProvider, initialIndex: 0);

    navItems = [
      NavItem('Dashboard', FeatherIcons.airplay),
      NavItem('Products', FeatherIcons.server),
      NavItem('Orders', FeatherIcons.search),
      NavItem('Profile', FeatherIcons.user),
    ];

    items = [
      const DashboardPage(),
      HomePage(),
      const SearchPage(),
      const ProfilePage(),
    ];
  }

  @override
  void initState() {
    // super.initState();
    tabController.addListener(handleTabSelection);
    tabController.animation!.addListener(() {
      final aniValue = tabController.animation!.value;
      if (aniValue - currentIndex > 0.5) {
        currentIndex++;
        update();
      } else if (aniValue - currentIndex < -0.5) {
        currentIndex--;
        update();
      }
    });
  }

  handleTabSelection() {
    currentIndex = tabController.index;
    update();
  }

  @override
  String getTag() {
    return "shopping_manager_full_app_controller";
  }
}
