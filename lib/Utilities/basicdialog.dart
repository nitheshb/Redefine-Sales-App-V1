import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/themes/themes.dart';

BasicDialog(
    {required String title,
    required String message,
    required String confirmText,
    required VoidCallback onTap}) {
  Get.dialog(AlertDialog(
    title: Text(
      title,
      style: Get.theme.kTitleStyle,
    ),
    content: Text(
      message,
    ),
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        style:
            TextButton.styleFrom(primary: Get.theme.kLightGrayColor),
        child: const Text('Close'),
      ),
      TextButton(
          onPressed: () => onTap(),
          style: TextButton.styleFrom(primary: Get.theme.colorPrimaryDark),
          child: Text(confirmText))
    ],
  ));
}
