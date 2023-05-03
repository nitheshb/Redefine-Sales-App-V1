import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Dashboard/dashboard_controller.dart';
import 'package:redefineerp/Screens/Notification/notification_controller.dart';
import 'package:redefineerp/Utilities/dummyData.dart';
import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/themes/constant.dart';
import 'package:redefineerp/themes/container.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/themes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timeago/timeago.dart' as timeago;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<String> filterTime = [
    "All time",
    "Yesterday",
    "This week",
    "7 days ago"
  ];

  late String time = "All time";

  var currentUserId = FirebaseAuth.instance.currentUser!.uid;

  late TooltipBehavior tooltipBehavior;
  late List<ChartSampleData> chartData;

  void initTime() {
    time = time = filterTime.first; // initializing the time field
    // initializing the time field
    initChartData();
  }

  void initState() {
    // time = filterTime.first;
    initChartData();
  }

  initChartData() {
    tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);

    chartData = <ChartSampleData>[
      ChartSampleData(
          x: '1', y: 10, pointColor: Constant.softColors.blue.color),
      ChartSampleData(
        x: '2',
        y: 8,
        pointColor: Constant.softColors.violet.color,
      ),
      ChartSampleData(
        x: '3',
        y: 16,
        pointColor: Constant.softColors.orange.color,
      ),
      ChartSampleData(
        x: '4',
        y: 24,
        pointColor: Constant.softColors.blue.color,
      ),
      ChartSampleData(
        x: '5',
        y: 32,
        pointColor: Constant.softColors.orange.color,
      ),
      ChartSampleData(
        x: '6',
        y: 30,
        pointColor: Constant.softColors.blue.color,
      ),
      ChartSampleData(
        x: '7',
        y: 25,
        pointColor: Constant.softColors.violet.color,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: FxSpacing.fromLTRB(
              20, FxSpacing.safeAreaTop(context) + 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleRow(),
              FxSpacing.height(16),
              alert(),
              FxSpacing.height(16),
              overview(),
              FxSpacing.height(20),
              statistics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleRow() {
    return Row(
      children: [
        FxContainer(
          width: 10,
          height: 24,
          color: Get.theme.primaryContainer,
          borderRadiusAll: 2,
        ),
        FxSpacing.width(8),
        FxText.titleMedium(
          "Dashboard",
          fontWeight: 600,
        ),
      ],
    );
  }

  Widget alert() {
    return FxContainer(
      color: Constant.softColors.green.color,
      child: Row(
        children: [
          FxText.bodySmall(
            'Alert: ',
            color: Constant.softColors.green.onColor,
            fontWeight: 700,
          ),
          FxText.bodySmall(
            'This has demo data',
            color: Constant.softColors.green.onColor,
            fontWeight: 600,
            fontSize: 11,
          )
        ],
      ),
    );
  }

  Widget timeFilter() {
    final controller = Get.put<DashboardController>(DashboardController());

    return PopupMenuButton(
      color: Get.theme.onBackground,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constant.containerRadius.small)),
      elevation: 1,
      child: FxContainer.bordered(
          paddingAll: 12,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FxText.bodySmall(
                controller.time,
              ),
              FxSpacing.width(8),
              Icon(
                FeatherIcons.chevronDown,
                size: 14,
              )
            ],
          )),
      itemBuilder: (BuildContext context) => [
        ...controller.filterTime.map((time) => PopupMenuItem(
            onTap: () {
              controller.changeFilter(time);
            },
            padding: FxSpacing.x(16),
            height: 36,
            child: FxText.bodyMedium(time)))
      ],
    );
  }

  Widget overview() {
    return Column(
      children: [
        FxContainer(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FxContainer(
                      width: 10,
                      height: 20,
                      color: Get.theme.primaryContainer,
                      borderRadiusAll: 2,
                    ),
                    FxSpacing.width(8),
                    FxText.titleSmall(
                      "Overview",
                      fontWeight: 600,
                    ),
                  ],
                ),
                timeFilter()
              ],
            ),
            FxSpacing.height(20),
            status()
          ],
        )),
      ],
    );
  }

  Widget status() {
    return IntrinsicHeight(
      child: Row(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('spark_assignedTasks')
                .where("status", isEqualTo: "completed")
                .where("to_uid",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                print("completed======>${snapshot.data!.docs}");
              }

              return Expanded(
                child: FxContainer.bordered(
                  color: Get.theme.Background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.bodySmall(
                        'Completed',
                        fontWeight: 600,
                        muted: true,
                      ),
                      FxSpacing.height(8),
                      FxText.titleLarge(
                        '${snapshot.data!.docs.length}',
                        fontWeight: 700,
                      ),
                      FxSpacing.height(8),
                      FxContainer(
                          borderRadiusAll: Constant.containerRadius.small,
                          paddingAll: 6,
                          color: Get.theme.primaryContainer,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FeatherIcons.arrowUp,
                                size: 12,
                                color: Get.theme.onPrimaryContainer,
                              ),
                              FxSpacing.width(2),
                              FxText.bodySmall(
                                "28%",
                                color: Get.theme.onPrimaryContainer,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
          FxSpacing.width(20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('spark_assignedTasks')
                .where("status", isEqualTo: "InProgress")
                .where("to_uid", isEqualTo: currentUserId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                print("Inprogressss ${snapshot.data!.docs[0].data()}");
              }

              return Expanded(
                  child: FxContainer(
                color: Get.theme.primaryContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodySmall(
                      'Tasks',
                      fontWeight: 600,
                      muted: true,
                      color: Get.theme.onPrimaryContainer,
                    ),
                    FxSpacing.height(8),
                    FxText.titleLarge(
                      '${snapshot.data!.docs.length}',
                      fontWeight: 700,
                      color: Get.theme.onPrimaryContainer,
                    ),
                    FxSpacing.height(8),
                    FxContainer(
                        borderRadiusAll: Constant.containerRadius.small,
                        paddingAll: 6,
                        color: Get.theme.ErrorContainer,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FeatherIcons.arrowDown,
                              size: 12,
                              color: Get.theme.onErrorContainer,
                            ),
                            FxSpacing.width(2),
                            FxText.bodySmall(
                              "45%",
                              fontWeight: 600,
                              color: Get.theme.onErrorContainer,
                            )
                          ],
                        ))
                  ],
                ),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget statistics() {
    return FxContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FxContainer(
                  width: 10,
                  height: 20,
                  color: Get.theme.primaryContainer,
                  borderRadiusAll: 2,
                ),
                FxSpacing.width(8),
                FxText.titleSmall(
                  "Completion Ranking",
                  fontWeight: 600,
                ),
              ],
            ),
            timeFilter()
          ],
        ),
        FxSpacing.height(20),
        salesStatusChart()
      ],
    ));
  }

  SfCartesianChart salesStatusChart() {
    final controller = Get.put<DashboardController>(DashboardController());

    return SfCartesianChart(
      margin: EdgeInsets.zero,
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          labelFormat: '{value}k',
          majorTickLines: MajorTickLines(size: 4, color: Colors.transparent)),
      series: _getDefaultColumnSeries(),
      tooltipBehavior: tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    final controller = Get.put<DashboardController>(DashboardController());

    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        width: 0.5,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(Constant.containerRadius.xs)),
        dataLabelSettings: DataLabelSettings(
            isVisible: false, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}
