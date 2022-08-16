import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/themes/themes.dart';

Widget miniMessage(String msg) {
  return Container(
    color: Get.theme.kGreenLight2,
    alignment: Alignment.topLeft,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Text(
      msg,
      style: Get.theme.kSubTitle.copyWith(color: Get.theme.kGreenDark),
    ),
  );
}
