import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  Buttons(
      {super.key,
      required this.height,
      required this.width,
      required this.color,
      required this.child,
      required this.radius});
  final double height;
  final double width;
  final double radius;
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: child,
    );
  }
}
