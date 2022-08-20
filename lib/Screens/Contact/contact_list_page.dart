import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/contact_card.dart';
import 'package:redefineerp/themes/themes.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ContactController>(ContactController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: TextField(
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _contactFilterChip(0,
                      title: 'All',
                      controller: controller,
                      onTap: () => {
                            controller.selectedIndex.value = 0,
                          }),
                  _contactFilterChip(1,
                      title: 'CRM',
                      controller: controller,
                      onTap: () => {
                            controller.selectedIndex.value = 1,
                          }),
                  _contactFilterChip(2,
                      title: 'Legal',
                      controller: controller,
                      onTap: () => {
                            controller.selectedIndex.value = 2,
                          }),
                  _contactFilterChip(3,
                      title: 'HR',
                      controller: controller,
                      onTap: () => {
                            controller.selectedIndex.value = 3,
                          }),
                  _contactFilterChip(4,
                      title: 'Sales',
                      controller: controller,
                      onTap: () => {
                            controller.selectedIndex.value = 4,
                          }),
                  _contactFilterChip(5,
                      title: 'Admin',
                      controller: controller,
                      onTap: () => {
                            controller.selectedIndex.value = 5,
                          }),
                ],
              ),
            ),
            ContactCard(
                title: 'Indrajit Nigam',
                jobTitle: 'Sales Executive',
                onTap: () => {}),
            ContactCard(
                title: 'Mahendra Mangal',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Kalini Gaba',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Ravi Prabhakar',
                jobTitle: 'Project Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Lochan Solanki',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Vivek Dhillon',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Vivek Dhillon',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Vivek Dhillon',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Vivek Dhillon',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Vivek Dhillon',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
            ContactCard(
                title: 'Vivek Dhillon',
                jobTitle: 'Sales Manager',
                onTap: () => {}),
          ],
        ),
      ),
    );
  }

  Widget _contactFilterChip(int index,
      {required String title,
      required ContactController controller,
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
