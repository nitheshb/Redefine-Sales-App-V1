import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Filter/filter_screen.dart';
import 'package:redefineerp/Screens/Search/search_controller.dart';
import 'package:redefineerp/Utilities/bottomsheet.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/themes/themes.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController controller = Get.put<SearchController>(SearchController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: TextField(
              onChanged: (v) {
                controller.searchResultsWidget.value =
                    controller.searchResults(v);
              },
              decoration: InputDecoration(
                  prefix: sizeBox(20, 20),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {
                      /* Clear the search field */
                    },
                  ),
                  hintText: 'Search',
                  hintStyle: Get.theme.kNormalStyle
                      .copyWith(color: Get.theme.kBadgeColor),
                  border: InputBorder.none),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                {bottomSheetWidget(FilterScreen(), transparentBg: true)},
            icon: Icon(
              Icons.calendar_month_outlined,
              color: Get.theme.kLightGrayColor,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip(0,
                    title: 'All',
                    controller: controller,
                    onTap: () => {
                          controller.selectedIndex.value = 0,
                        }),
                _filterChip(1,
                    title: 'Done',
                    controller: controller,
                    onTap: () => {
                          controller.selectedIndex.value = 1,
                        }),
                _filterChip(2,
                    title: 'Pending',
                    controller: controller,
                    onTap: () => {
                          controller.selectedIndex.value = 2,
                        }),
                _filterChip(3,
                    title: 'Created',
                    controller: controller,
                    onTap: () => {
                          controller.selectedIndex.value = 3,
                        }),
                _filterChip(4,
                    title: 'Today',
                    controller: controller,
                    onTap: () => {
                          controller.selectedIndex.value = 4,
                        }),
              ],
            ),
          ),
          sizeBox(20, 0),
          // Center(child: SvgPicture.asset('assets/images/Search.svg')),
          Expanded(
            child: Obx(() => controller.searchResultsWidget.value),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(30.0),
          //   child: Text(
          //     'Begin Search',
          //     style: Get.theme.kNormalStyle
          //         .copyWith(color: Get.theme.kLightGrayColor),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _filterChip(int index,
      {required String title,
      required SearchController controller,
      required VoidCallback onTap}) {
    return Padding(
      padding: index == 0
          ? const EdgeInsets.only(left: 20, right: 5, top: 8, bottom: 8)
          : const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Obx(
        () => ActionChip(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            shape: index != controller.selectedIndex.value
                ? const StadiumBorder(side: BorderSide(color: Colors.black26))
                : null,
            backgroundColor: index == controller.selectedIndex.value
                ? Get.theme.colorPrimaryDark
                : Colors.white,
            label: Text(
              title,
              style: Get.theme.kSubTitle.copyWith(
                color: controller.selectedIndex.value == index
                    ? Colors.white
                    : Get.theme.kBadgeColor,
              ),
            ),
            onPressed: onTap),
      ),
    );
  }
}
