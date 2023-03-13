import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child:  SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
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
                  
                  ],
                ),
              ),
              Container(
                  height: 2, width: Get.size.width, color: Get.theme.curveBG),
              _streamUsersContacts(controller),
            ],
          ),
        )
      
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[

      //   ])
        
        );

  }

  Widget _streamUsersContacts(ContactController controller) {
        var tempFollwers = [];
        var myTemp = [];

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
                            // controller.taskController.assignedUserName.value =
                            //     taskData["name"],
                            // controller.taskController.assignedUserDepartment
                            //     .value = taskData["department"][0],
                            // controller.taskController.assignedUserEmail.value =
                            //     taskData["email"],
                            // controller.taskController.assignedUserUid.value =
                            //     taskData["uid"],
                            // controller.taskController.assignedUserFcmToken
                            //     .value = taskData["user_fcmtoken"],

                            // controller.participantsList.value.filter()
                            tempFollwers = controller.participantsList.value,
                             

                              //  tempFollwers.where((i) => i.isAnimated).toList(),

                        if(tempFollwers.length >0){
                            tempFollwers.map( (a) {
                              if(a["uid"] != taskData["uid"]){
                                print('this will get dded');
                                myTemp.add({"uid": taskData["uid"],"name": taskData['name']});
                                  
                              }else{
                                return;
                              }
                              
                              // else{

                              //    data.removeWhere((item) => item["name"]=="stack")
                              //                                   tempFollwers.remove({"uid": taskData["uid"],"name": taskData['name']})

                              // }
                             
                                
                               
    // object[a.empid] = a;
}),}else{
                               myTemp.add({"uid": taskData["uid"],"name": taskData['name']})
                             },
controller.participantsList.value = myTemp,
                            // controller.participantsList.add({"uid": taskData["uid"],"name": taskData['name']}) ,   
                            print('temp followers list ${taskData["uid"]}, ${controller.participantsList.value}  ${myTemp}') ,
                            // Get.back()
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
