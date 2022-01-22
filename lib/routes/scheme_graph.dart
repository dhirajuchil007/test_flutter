import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter/models/get_schemes_response.dart';
import 'package:test_flutter/models/scheme_nav_data.dart';

class SchemeGraph extends StatefulWidget {
  const SchemeGraph({Key? key}) : super(key: key);

  @override
  _SchemeGraphState createState() => _SchemeGraphState();
}

class _SchemeGraphState extends State<SchemeGraph> {
  SchemeData? schemeData;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/absl_index.json');
    var jsonMap = await json.decode(response);
    var schemeResponse = SchemeData.fromJson(jsonMap);
    setState(() {
      schemeData = schemeResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    var navList = schemeData?.data ?? [];
    List<List<Datum>> groupList = [];

    for (int i = 0; i < navList.length / 10; i += 10) {
      groupList.add(navList.sublist(i, i + 10));
    }
    PreferredSizeWidget appBar2 = AppBar(
      title: Text('Graph'),
    );
    return Scaffold(
      appBar: appBar2,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('ABSL Index Fund (G)'),
            ),
            Wrap(children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.indigoAccent, Colors.indigo],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                width: double.infinity,
                height: (MediaQuery.of(context).size.height -
                        appBar2.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LineChart(
                    LineChartData(gridData: FlGridData(show: true,),

                        borderData: FlBorderData(
                            show: true,
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.white30, width: 5),
                                left: BorderSide(
                                    color: Colors.white30, width: 5))),
                        axisTitleData: FlAxisTitleData(
                          bottomTitle: AxisTitle(titleText: 'Date',showTitle: true,textStyle: TextStyle(color: Colors.white54)),
                          leftTitle: AxisTitle(titleText: 'NAV',showTitle: true,textStyle: TextStyle(color: Colors.white54))
                        ),
                        titlesData: FlTitlesData(
                            show: true,
                            rightTitles: SideTitles(showTitles: false),
                            topTitles: SideTitles(showTitles: false),
                            bottomTitles: SideTitles(
                              getTextStyles: (ctx, value) {
                                return TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                );
                              },
                              getTitles: (value) {
                                var dt = DateTime.fromMillisecondsSinceEpoch(
                                    value.toInt());
                                String date =
                                    DateFormat("dd-MM-yyyy").format(dt);
                                return date;
                              },
                              showTitles: true,
                            ),
                            leftTitles: SideTitles(
                                getTextStyles: (ctx, value) {
                                  return TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  );
                                },
                                showTitles: true,
                                reservedSize: 50)),
                        lineBarsData: [
                          LineChartBarData(
                              barWidth: 2,
                              colors: [Colors.white70],
                              dotData: FlDotData(show: false),
                              spots: navList
                                  .sublist(0, 25)
                                  .map(
                                    (e) => FlSpot(getDateFromString(e.date),
                                        double.parse(e.nav)),
                                  )
                                  .toList())
                        ]),
                    swapAnimationDuration: Duration(milliseconds: 500),
                    // Optional
                    swapAnimationCurve: Curves.linear,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    readJson();
  }

  Widget getItemList() {
    if (schemeData != null) {
      return ListView.builder(
        itemBuilder: (ctx, i) => ListTile(
          title: Text(schemeData!.data[i].nav),
          subtitle: Text(schemeData!.data[i].date),
        ),
        itemCount: schemeData!.data.length,
      );
    } else
      return Center(child: Text("No items"));
  }
}

double getDateFromString(String date) {
  var dt = DateFormat("dd-MM-yyyy").parse(date);
  return dt.millisecondsSinceEpoch.toDouble();
}
