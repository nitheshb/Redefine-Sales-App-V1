import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sort by Date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isToday = true;
                  isYesterday =
                      isLastWeek = isLastMonth = isCustomRange = false;
                });
              },
              child: Row(
                children: isToday
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
                          children: const [
                            Text(
                              'Today',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 117, 98, 1),
                              ),
                            ),
                            Text(
                              '20 August',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.54),
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
                          children: const [
                            Text(
                              'Today',
                            ),
                            Text(
                              '20 August',
                              style: TextStyle(color: Colors.grey),
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
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromRGBO(255, 117, 98, 1),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Yesterday',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 117, 98, 1),
                              ),
                            ),
                            Text(
                              '19 August',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.54),
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
                          children: const [
                            Text(
                              'Yesterday',
                            ),
                            Text(
                              '19 August',
                              style: TextStyle(color: Colors.grey),
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
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromRGBO(255, 117, 98, 1),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Last Week',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 117, 98, 1),
                              ),
                            ),
                            Text(
                              'Aug 7 - 13',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.54),
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
                          children: const [
                            Text(
                              'Last Week',
                            ),
                            Text(
                              'Aug 7 - 13',
                              style: TextStyle(color: Colors.grey),
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
                          children: const [
                            Text(
                              'Last Month',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 117, 98, 1),
                              ),
                            ),
                            Text(
                              'Jul 1 - 31',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.52),
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
                          children: const [
                            Text(
                              'Last Month',
                            ),
                            Text(
                              'Jul 1 - 31',
                              style: TextStyle(color: Colors.grey),
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
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromRGBO(255, 117, 98, 1),
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
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.47),
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
                        const Text(
                          'Custom Range',
                        ),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
