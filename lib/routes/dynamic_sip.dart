import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:test_flutter/models/dsip_values.dart';
import 'package:test_flutter/models/dsip_year.dart';

class DynamicSIP extends StatefulWidget {
  const DynamicSIP({Key? key}) : super(key: key);

  @override
  _DynamicSIPState createState() => _DynamicSIPState();
}

class _DynamicSIPState extends State<DynamicSIP> {
  List<DSIPValue> values = [
    DSIPValue(0, Colors.amber),
    DSIPValue(0, Colors.blue)
  ];

  List<DSIPDate> dates = [
    DSIPDate(
        "Today", [DSIPValue(40, Colors.amber), DSIPValue(60, Colors.blue)]),
    DSIPDate("2018", [DSIPValue(23, Colors.amber), DSIPValue(76, Colors.blue)]),
    DSIPDate("2010", [DSIPValue(34, Colors.amber), DSIPValue(66, Colors.blue)]),
    DSIPDate("2008", [DSIPValue(80, Colors.amber), DSIPValue(20, Colors.blue)]),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic SIP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Earn more than normal SIP",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: double.infinity,
                      sections: values
                          .map((e) => PieChartSectionData(
                              radius: 20,
                              value: e.value,
                              color: e.color,
                              showTitle: false))
                          .toList(),
                      startDegreeOffset: 0,
                      sectionsSpace: 0,
                    ),
                    swapAnimationDuration: Duration(milliseconds: 800),
                    // Optional
                    swapAnimationCurve: Curves.ease,
                  ),
                ),
                Positioned(
                  child: Text("Share Market \n${values[0].value}"),
                  right: width / 2.2,
                  bottom: values[0].value + 40,
                ),
                Positioned(
                  child: Text("Fixed Income \n${values[1].value}"),
                  left: width / 2.2,
                  bottom: values[1].value + 40,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (buildContext, index) => Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          values = dates[index].dsipValue;
                        });
                      },
                      child: Text(dates[index].year)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    values = [DSIPValue(50, Colors.amber), DSIPValue(40, Colors.blue)];
  }
}
