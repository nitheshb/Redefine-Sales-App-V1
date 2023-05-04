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
      required this.onTap})
      : super(key: key);
  final String title;
  final String jobTitle;
  final VoidCallback onTap;
  final String uid;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  void initState() {
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
        title: FxText.bodyLarge(
          widget.title,
          fontSize: 16,
          fontWeight: 700,
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
