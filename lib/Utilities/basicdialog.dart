import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/themes/themes.dart';

basicDialog(
  String title,
  String message,
) {
  Get.dialog(Column(
    children: [
      Text(
        title,
        style: Get.theme.kTitleStyle,
      ),
      Text(
        message,
        style: Get.theme.kNormalStyle.copyWith(color: Get.theme.btnTextCol),
      ),
    ],
  ));
}
