import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Contact/contacts_controller.dart';
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
  final bool uid;

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
      color: (widget.uid) ? Colors.yellow : Colors.white,
      child: ListTile(
        leading: Icon(
          Icons.account_circle,
          color: Get.theme.kContactIconColor,
          size: 32,
        ),
        title: Text(widget.title,
            style: Get.theme.kNormalStyle
                .copyWith(color: Get.theme.kContactIconColor)),
        subtitle: Text(widget.jobTitle,
            style: Get.theme.kSubTitle
                .copyWith(color: Get.theme.btnTextCol.withOpacity(0.2))),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            color: Get.theme.btnTextCol.withOpacity(0.2)),
        onTap: widget.onTap,
      ),
    );
  }
}
