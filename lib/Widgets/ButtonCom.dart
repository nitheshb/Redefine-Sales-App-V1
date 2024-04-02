
import 'package:flutter/material.dart';
import 'package:redefineerp/themes/myColors.dart';

class ButtonCom extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback ontap;
  const ButtonCom({super.key, required this.text, required this.icon, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:ontap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: onSecondryColor,
        ),
        child: Row(
          children: [
            Text("$text"),
            SizedBox(width: 10),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
