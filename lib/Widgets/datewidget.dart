import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/themes/themes.dart';

Widget DateWidget(String text) {
  return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Get.theme.btnTextCol.withOpacity(0.2),
            width: 2,
          ),
        ),
      ),
      child: Text(text,
          textAlign: TextAlign.start,
          style: Get.theme.kSubTitle
              .copyWith(color: Get.theme.btnTextCol.withOpacity(0.6))));
}
