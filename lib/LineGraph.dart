import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LineGraph extends StatefulWidget {
const LineGraph({super.key});
// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".


@override
State<LineGraph> createState() => _LineGraphPageState();
}

class _LineGraphPageState extends State<LineGraph> {
@override
Widget build(BuildContext context) {
// This method is rerun every time setState is called, for instance as done
// by the _incrementCounter method above.
//
// The Flutter framework has been optimized to make rerunning build methods
// fast, so that you can just rebuild anything that needs updating rather
// than having to individually change instances of widgets.
return Scaffold(
appBar: AppBar(
// TRY THIS: Try changing the color here to a specific color (to
// Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
// change color while the other colors stay the same.
backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
title: Text('Line Graph',
style: TextStyle(
fontSize: 22,
color: Colors.white,
fontWeight: FontWeight.normal
),
),
),
body: SingleChildScrollView(
child: Center( child: Container(
padding: const EdgeInsets.all(10),
width: double.infinity,
height: 300,
child: Padding(
padding: EdgeInsets.only(top: 20),
child:Container(
  padding: const EdgeInsets.all(10),
  width: double.infinity,
  height: 300,
  child: LineChart(
    LineChartData(borderData: FlBorderData(show: false), lineBarsData: [
      LineChartBarData(spots: [
        const FlSpot(0, 1),
        const FlSpot(1, 3),
        const FlSpot(2, 10),
        const FlSpot(3, 7),
        const FlSpot(4, 12),
        const FlSpot(5, 13),
        const FlSpot(6, 17),
        const FlSpot(7, 15),
        const FlSpot(8, 20)
      ])
    ]),
  ),
),


)

)
)

));

}
}