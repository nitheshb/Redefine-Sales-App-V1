import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';

class ContactCard extends StatefulWidget {
  const ContactCard(
      {Key? key,
      required this.title,
      required this.jobTitle,
      required this.uid,
      required this.onTap,
      required this.taskData})
      : super(key: key);
  final String title;
  final QueryDocumentSnapshot<Object?>? taskData;
  final String jobTitle;
  final VoidCallback onTap;
  final String uid;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool? isActive;

  @override
  void initState() {
    try {
      widget.taskData!["name"];

      widget.taskData!["department"][0];
      widget.taskData!["email"];
      widget.taskData!["uid"];
      widget.taskData!["user_fcmtoken"];
      isActive = true;
    } catch (e) {
      isActive = false;

      print(e);
    }
    // TODO: implement initState
    print('this bool is ${widget.uid}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ContactController>(ContactController());

    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          Icons.account_circle,
          color: Get.theme.kContactIconColor,
          size: 32,
        ),
        title: Row(
          children: [
            FxText.bodyLarge(
              widget.title,
              fontSize: 16,
              fontWeight: 700,
            ),
            Spacer(),
            isActive == true
                ? CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: MediaQuery.of(context).size.height * 0.006,
                  )
                : const SizedBox()
          ],
        ),
        subtitle: FxText.bodySmall(
          widget.jobTitle,
          fontSize: 11,
          fontWeight: 700,
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            color: Get.theme.btnTextCol.withOpacity(0.2)),
        onTap: widget.onTap,
      ),
    );
  }
}
