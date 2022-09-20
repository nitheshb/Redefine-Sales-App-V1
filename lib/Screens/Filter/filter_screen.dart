import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:redefineerp/themes/themes.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var isToday = true;
  var isYesterday = false;
  var isLastWeek = false;
  var isLastMonth = false;
  var isCustomRange = false;
  String todayDate = "20 August";
  String yesterdayDate = "19 August";
  String lastWeekDate = "Aug 7 - 13";
  String lastMonthDate = "Jul 1 - 31";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.29,
            ),
            const Text(
              'Sort by Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isToday = true;
                isYesterday = isLastWeek = isLastMonth = isCustomRange = false;
              });
            },
            child: Row(
              children: isToday
                  ? [
                      SvgPicture.asset('assets/images/Today.svg'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 117, 98, 1),
                            ),
                          ),
                          Text(
                            todayDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.54),
                      const Icon(
                        Icons.check,
                        color: Color.fromRGBO(255, 117, 98, 1),
                      ),
                    ]
                  : [
                      SvgPicture.asset(
                        'assets/images/Today.svg',
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Today',
                          ),
                          Text(
                            todayDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isYesterday = true;
                isToday = isLastWeek = isLastMonth = isCustomRange = false;
              });
            },
            child: Row(
              children: isYesterday
                  ? [
                      SvgPicture.asset(
                        'assets/images/Yesterday.svg',
                        color: Get.theme.colorPrimaryDark,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Yesterday',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 117, 98, 1),
                            ),
                          ),
                          Text(
                            yesterdayDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.54),
                      const Icon(
                        Icons.check,
                        color: Color.fromRGBO(255, 117, 98, 1),
                      ),
                    ]
                  : [
                      SvgPicture.asset(
                        'assets/images/Yesterday.svg',
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Yesterday',
                          ),
                          Text(
                            yesterdayDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isLastWeek = true;
                isToday = isYesterday = isLastMonth = isCustomRange = false;
              });
            },
            child: Row(
              children: isLastWeek
                  ? [
                      SvgPicture.asset(
                        'assets/images/LastWeek.svg',
                        color: Get.theme.colorPrimaryDark,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Week',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 117, 98, 1),
                            ),
                          ),
                          Text(
                            lastWeekDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.54),
                      const Icon(
                        Icons.check,
                        color: Color.fromRGBO(255, 117, 98, 1),
                      ),
                    ]
                  : [
                      SvgPicture.asset(
                        'assets/images/LastWeek.svg',
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Week',
                          ),
                          Text(
                            lastWeekDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 8,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isLastMonth = true;
                isToday = isYesterday = isLastWeek = isCustomRange = false;
              });
            },
            child: Row(
              children: isLastMonth
                  ? [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Color.fromRGBO(255, 117, 98, 1),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Month',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 117, 98, 1),
                            ),
                          ),
                          Text(
                            lastMonthDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.52),
                      const Icon(
                        Icons.check,
                        color: Color.fromRGBO(255, 117, 98, 1),
                      ),
                    ]
                  : [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Month',
                          ),
                          Text(
                            lastMonthDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isCustomRange = true;
                isToday = isYesterday = isLastWeek = isLastMonth = false;
              });
            },
            child: Row(
              children: isCustomRange
                  ? [
                      SvgPicture.asset(
                        'assets/images/CustomRange.svg',
                        color: Get.theme.colorPrimaryDark,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      const Text(
                        'Custom Range',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 117, 98, 1),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.47),
                      const Icon(
                        Icons.check,
                        color: Color.fromRGBO(255, 117, 98, 1),
                      ),
                    ]
                  : [
                      SvgPicture.asset(
                        'assets/images/CustomRange.svg',
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      const Text(
                        'Custom Range',
                      ),
                    ],
            ),
          ),
        ),
      ],
    );
  }
}
