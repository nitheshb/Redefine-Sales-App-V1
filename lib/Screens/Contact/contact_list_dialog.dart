import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contact_list_page.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/Utilities/custom_sizebox.dart';
import 'package:redefineerp/Widgets/contact_card.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/themes/themes.dart';

class ContactListDialogPage extends StatelessWidget {
  const ContactListDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ContactController>(ContactController());

    return  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                            children: [
                                  TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Task name...'),
                                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                                    onSubmitted: (value) {
                                      Navigator.pop(context);
                                      var currentDate = DateTime.now();
                                  DatePicker.showTimePicker(context,
                                  showSecondsColumn: false,
                                    showTitleActions: true,
                                     onChanged: (date) {
                                }, onConfirm: (date) {
                                  if(value.isNotEmpty){
                                   print('value is ${value} data is ${date}');
                                  }
                                }, currentTime: DateTime.now());
                                    },
                                    autofocus: true,
                                  ),
                                   TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Description'),
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                    onSubmitted: (value) {
                                      Navigator.pop(context);
                                      var currentDate = DateTime.now();
                                  DatePicker.showTimePicker(context,
                                  showSecondsColumn: false,
                                    showTitleActions: true,
                                     onChanged: (date) {
                                }, onConfirm: (date) {
                                  if(value.isNotEmpty){
                                    print('value iss ${value} data is ${date}');
                                  //  var task = Task.create(name: value, createdAt: date);
                                  // base.dataStore.addTask(task: task);
                                  }
                                  
                                }, currentTime: DateTime.now());
                                    },
                                    autofocus: true,
                                  
                                 ),
                                //  Container(
                                //   height: 
                                //  child: null),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [  
                                                                  
                                      SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: ()=>{
       showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child:  ContactListPage()))
                  },
                  child: Row(
                    children: [
                      Icon(
                                  Icons.person_2_outlined,
                                  color: Get.theme.kLightGrayColor,
                                ),
                                Obx(
                      () => ActionChip(
        elevation: 0,
        side: BorderSide(color: Get.theme.btnTextCol.withOpacity(0.1)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Get.theme.kBadgeColorBg,
        label: Text(
          // controller.assignedUserName.value,
          "new",
          style: Get.theme.kSubTitle.copyWith(color: Get.theme.kBadgeColor),
        ),
        onPressed: () => {
              Get.to(() => const ContactListPage()),
            })
                          
                    ),
                    ],
                  ),
                ),
                  SizedBox(width: 20.0,),
                         InkWell(
                  onTap: ()=>{
        DatePicker.showDateTimePicker(context,
                                showTitleActions: true, onChanged: (date) {
                              print(
                                      'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                            }, onConfirm: (date) {
                              // controller.dateSelected = date;
                              // controller.updateSelectedDate();
                            }, currentTime: DateTime.now())
                  },
                  child: Icon(
                              Icons.people_alt_outlined,
                              color: Get.theme.kLightGrayColor,
                            ),
                ),
                  SizedBox(width: 20.0,),
                         InkWell(
                  onTap: ()=>{
        DatePicker.showDateTimePicker(context,
                                showTitleActions: true, onChanged: (date) {
                              print(
                                      'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                            }, onConfirm: (date) {
                              // controller.dateSelected = date;
                              // controller.updateSelectedDate();
                            }, currentTime: DateTime.now())
                  },
                  child: Icon(
                              Icons.calendar_month_outlined,
                              color: Get.theme.kLightGrayColor,
                            ),
                ),
                SizedBox(width: 20.0,),
                         InkWell(
                  onTap: ()=>{
        DatePicker.showDateTimePicker(context,
                                showTitleActions: true, onChanged: (date) {
                              print(
                                      'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                            }, onConfirm: (date) {
                              // controller.dateSelected = date;
                              // controller.updateSelectedDate();
                            }, currentTime: DateTime.now())
                  },
                  child: Icon(
                              Icons.attach_file,
                              color: Get.theme.kLightGrayColor,
                            ),
                ),
SizedBox(width: 20.0,),
                         InkWell(
                  onTap: ()=>{
        DatePicker.showDateTimePicker(context,
                                showTitleActions: true, onChanged: (date) {
                              print(
                                      'change ${date.millisecondsSinceEpoch} $date in time zone ${date.timeZoneOffset.inHours}');
                            }, onConfirm: (date) {
                              // controller.dateSelected = date;
                              // controller.updateSelectedDate();
                            }, currentTime: DateTime.now())
                  },
                  child: Icon(
                              Icons.flag_outlined,
                              color: Get.theme.kLightGrayColor,
                            ),
                ),

         
              ],
            ),
          ),

          Text('Create')
                                    ],
                                  ),
SizedBox(height: 16,)

                            ],
                          );

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text("data"));
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: 
   Scaffold(
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
              controller: controller.searchController,
              // onChanged: (v) {
              //   controller.searchResult.value = v;
              // },
              onSubmitted: (v) {
                controller.searchResult.value = v;
              },
              decoration: InputDecoration(
                  prefix: sizeBox(20, 20),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {
                      controller.searchResult.value =
                          controller.searchController.text;
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
              child: Obx(
                () => Row(
                  children: [
                    _contactFilterChip(0,
                        title: 'All',
                        controller: controller,
                        onTap: () => {
                              controller.selectedIndex.value = 0,
                              controller.filterValue.value = 'All',
                            }),
                    ...controller.deptFilterList.map((e) {
                      int id = controller.deptFilterList.indexOf(e) + 1;
                      if (e == 'a' || e == 'c' || e == 'f' || e == 'p') {
                        return sizeBox(0, 0);
                      }
                      return _contactFilterChip(id,
                          title: e,
                          controller: controller,
                          onTap: () => {
                                controller.selectedIndex.value = id,
                                controller.filterValue.value = e,
                              });
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(),
                      onPressed: () => {
                        if (controller.filterByEmployeeValue.value == 'ZA')
                          {controller.filterByEmployeeValue.value = 'AZ'}
                        else
                          controller.filterByEmployeeValue.value = 'ZA',
                      },
                      icon: Icon(
                        Icons.sort_by_alpha_outlined,
                        size: 16,
                        color: Get.theme.btnTextCol.withOpacity(0.3),
                      ),
                      label: Text('Employee Name',
                          style: Get.theme.kSubTitle.copyWith(
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          )),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(),
                      onPressed: () => {},
                      icon: Icon(
                        Icons.swap_vert_rounded,
                        size: 16,
                        color: Get.theme.btnTextCol.withOpacity(0.3),
                      ),
                      label: Text('Pending Task',
                          style: Get.theme.kSubTitle.copyWith(
                            color: Get.theme.btnTextCol.withOpacity(0.3),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 2, width: Get.size.width, color: Get.theme.curveBG),
            _streamUsersContacts(controller),
          ],
        ),
      ),
    )
 
 
 ); }

  Widget _streamUsersContacts(ContactController controller) {
    return Obx(() => StreamBuilder<QuerySnapshot>(
        stream: DbQuery.instanace.getEmployees(
            sortByDeptName: controller.filterValue.value,
            sortEmployees: controller.filterByEmployeeValue.value,
            sortByName: controller.searchResult.value),
        builder: (con, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong! 😣..."),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                primary: false,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (c, i) {
                  QueryDocumentSnapshot<Object?>? taskData =
                      snapshot.data?.docs[i];
                  return ContactCard(
                      title: '${taskData!["name"]}',
                      jobTitle: '${taskData["roles"][0]}',
                      onTap: () => {
                            controller.taskController.assignedUserName.value =
                                taskData["name"],
                            controller.taskController.assignedUserDepartment
                                .value = taskData["department"][0],
                            controller.taskController.assignedUserEmail.value =
                                taskData["email"],
                            controller.taskController.assignedUserUid.value =
                                taskData["uid"],
                            controller.taskController.assignedUserFcmToken
                                .value = taskData["user_fcmtoken"],
                            Get.back()
                          });
                });
          } else {
            return Center(
              child: Column(
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Text("Users Loading..."),
                  )
                ],
              ),
            );
          }
        }));
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
