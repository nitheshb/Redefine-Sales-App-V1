
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/projectDetails/unit_details.dart';
import 'package:redefineerp/themes/themes.dart';

class UnitScreen extends StatelessWidget {
  const UnitScreen({required this.unitArrayPayload,super.key});
 final unitArrayPayload;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          mainAxisExtent: 90,
          crossAxisCount: 4,
        ),
        itemCount: unitArrayPayload.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => UnitDetailsScreen(unitDetails: unitArrayPayload[index]));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.030,
                width: MediaQuery.of(context).size.width * 0.070,
                decoration: const BoxDecoration(
                    color: Color(0xFFD0D1D6),
                    borderRadius: BorderRadius.all(Radius.circular(13))),
                    child: Center(child: Text('${unitArrayPayload[index]['unit_no']}',  style: titleTiny,)),
              ),
            ),
          );
        });
  }
}
