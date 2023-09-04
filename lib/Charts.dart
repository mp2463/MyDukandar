import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Charts extends StatefulWidget {
  const Charts({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<Charts> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<Charts> {
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
          title: Text('Charts',
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
                    child:BarChart(BarChartData(

                        borderData: FlBorderData(
                            border: const Border(
                              top: BorderSide.none,
                              right: BorderSide.none,
                              left: BorderSide(width: 1),
                              bottom: BorderSide(width: 1),
                            )),
                        groupsSpace: 10,

                        // add bars
                        barGroups: [
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(toY: 10, width: 15, color: Colors.amber),
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(toY: 9, width: 15, color: Colors.amber),
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(toY: 4, width: 15, color: Colors.amber),
                          ]),
                          BarChartGroupData(x: 4, barRods: [
                            BarChartRodData(toY: 2, width: 15, color: Colors.amber),
                          ]),
                          BarChartGroupData(x: 5, barRods: [
                            BarChartRodData(toY: 13, width: 15, color: Colors.amber),
                          ]),
                          BarChartGroupData(x: 6, barRods: [
                            BarChartRodData(toY: 17, width: 15, color: Colors.amber),
                          ]),
                          BarChartGroupData(x: 7, barRods: [
                            BarChartRodData(toY: 19, width: 15, color: Colors.amber),
                          ]),
                          BarChartGroupData(x: 8, barRods: [
                            BarChartRodData(toY: 21, width: 15, color: Colors.amber),
                          ]),
                        ])),

                  )

              )
          )

        ));

  }
}