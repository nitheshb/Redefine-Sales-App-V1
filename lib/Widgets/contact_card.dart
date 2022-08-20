import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/themes/themes.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {Key? key,
      required this.title,
      required this.jobTitle,
      required this.onTap})
      : super(key: key);
  final String title;
  final String jobTitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.account_circle,
        color: Get.theme.kContactIconColor,
        size: 32,
      ),
      title: Text(title,
          style: Get.theme.kNormalStyle
              .copyWith(color: Get.theme.kContactIconColor)),
      subtitle: Text(jobTitle,
          style: Get.theme.kSubTitle
              .copyWith(color: Get.theme.btnTextCol.withOpacity(0.2))),
      trailing: Icon(Icons.arrow_forward_ios_rounded,
          color: Get.theme.btnTextCol.withOpacity(0.2)),
      onTap: onTap,
    );
  }
}
