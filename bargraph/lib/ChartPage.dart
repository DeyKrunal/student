import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChartPage> {
  final List<double> groupProgressData = [50, 75, 30, 90, 10, 20, 20, 90, 40];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 200.0, // Set the desired height of the chart
                  width: double.infinity,
                  child: BarChart(
                    BarChartData(
                        backgroundColor: Colors.grey[200],
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barGroups: createBarGroups(),
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(
                              showTitles:
                              true, // Set showTitles to false to hide the left axis titles
                              interval: 10,
                              getTextStyles: (context, value) => const TextStyle(
                                fontSize: 10,
                              )),
                          rightTitles: SideTitles(
                            showTitles:
                            false, // Set showTitles to false to hide the right axis titles
                          ),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            rotateAngle: 270,
                            margin: 8,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            getTitles: (double value) {
                              // Customize the group names on the bottom axis
                              switch (value.toInt()) {
                                case 0:
                                  return 'A';
                                case 1:
                                  return 'B';
                                case 2:
                                  return 'c';
                                case 3:
                                  return 'D';
                                default:
                                  return '';
                              }
                            },
                          ),
                          topTitles: SideTitles(
                            rotateAngle: 270,
                            showTitles: false,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            getTitles: (double value) {
                              // Customize the group names on the bottom axis
                              switch (value.toInt()) {
                                case 0:
                                  return 'A';
                                case 1:
                                  return 'B';
                                case 2:
                                  return 'C';
                                case 3:
                                  return 'D';
                                default:
                                  return '';
                              }
                            },
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        groupsSpace: 1.0),
                  ),
                )
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 200.0, // Set the desired height of the chart
                  width: double.infinity,
                  child: BarChart(
                    BarChartData(
                        backgroundColor: Colors.grey[200],
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barGroups: createBarGroups1(),
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(
                              showTitles:
                              true, // Set showTitles to false to hide the left axis titles
                              interval: 10,
                              getTextStyles: (context, value) => const TextStyle(
                                fontSize: 10,
                              )),
                          rightTitles: SideTitles(
                            showTitles:
                            false, // Set showTitles to false to hide the right axis titles
                          ),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            rotateAngle: 270,
                            margin: 8,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            getTitles: (double value) {
                              // Customize the group names on the bottom axis
                              switch (value.toInt()) {
                                case 0:
                                  return 'A';
                                case 1:
                                  return 'B';
                                case 2:
                                  return 'c';
                                case 3:
                                  return 'D';
                                default:
                                  return '';
                              }
                            },
                          ),
                          topTitles: SideTitles(
                            rotateAngle: 270,
                            showTitles: false,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            getTitles: (double value) {
                              // Customize the group names on the bottom axis
                              switch (value.toInt()) {
                                case 0:
                                  return 'A';
                                case 1:
                                  return 'B';
                                case 2:
                                  return 'C';
                                case 3:
                                  return 'D';
                                default:
                                  return '';
                              }
                            },
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        groupsSpace: 1.0),
                  ),
                )
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 200.0, // Set the desired height of the chart
                  width: double.infinity,
                  child: BarChart(
                    BarChartData(
                        backgroundColor: Colors.grey[200],
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barGroups: createBarGroups3(),
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(
                              showTitles:
                              true, // Set showTitles to false to hide the left axis titles
                              interval: 10,
                              getTextStyles: (context, value) => const TextStyle(
                                fontSize: 10,
                              )),
                          rightTitles: SideTitles(
                            showTitles:
                            false, // Set showTitles to false to hide the right axis titles
                          ),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            rotateAngle: 270,
                            margin: 8,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            getTitles: (double value) {
                              // Customize the group names on the bottom axis
                              switch (value.toInt()) {
                                case 0:
                                  return 'A';
                                case 1:
                                  return 'B';
                                case 2:
                                  return 'c';
                                case 3:
                                  return 'D';
                                default:
                                  return '';
                              }
                            },
                          ),
                          topTitles: SideTitles(
                            rotateAngle: 270,
                            showTitles: false,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            getTitles: (double value) {
                              // Customize the group names on the bottom axis
                              switch (value.toInt()) {
                                case 0:
                                  return 'A';
                                case 1:
                                  return 'B';
                                case 2:
                                  return 'C';
                                case 3:
                                  return 'D';
                                default:
                                  return '';
                              }
                            },
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        groupsSpace: 1.0),
                  ),
                )
            ),

          ],
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      // 	items: const <BottomNavigationBarItem>[
      // 		BottomNavigationBarItem(
      // 			icon: Icon(Icons.home),
      // 			label:'Home',
      // 		),
      // 		BottomNavigationBarItem(
      // 			icon: Icon(Icons.insights),
      // 			label:'Home',
      // 		),
      // 		BottomNavigationBarItem(
      // 			icon: Icon(Icons.chat),
      // 			label:'Home',
      // 		),
      // 		BottomNavigationBarItem(
      // 			icon: Icon(Icons.settings),
      // 			label:'Home',
      // 		),
      // 	],
      // 	selectedItemColor: Colors.blue, // Color of the selected item icon and text
      // 	selectedLabelStyle: TextStyle(color: Colors.blue),
      // 	unselectedItemColor: Colors.green,
      // ),
    );
  }

  List<BarChartGroupData> createBarGroups() {  List<BarChartGroupData> barGroups = [];

  for (int i = 0; i < groupProgressData.length; i++) {
    barGroups.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            width: 30.0,
            y: groupProgressData[i],
          ),
        ],
      ),
    );
  }

  return barGroups;
  }
  List<BarChartGroupData> createBarGroups1() {  List<BarChartGroupData> barGroups = [];

  for (int i = 0; i < groupProgressData.length; i++) {
    barGroups.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            width: 30.0,
            y: groupProgressData[i],
          ),
        ],
      ),
    );
  }

  return barGroups;
  }
  List<BarChartGroupData> createBarGroups3() {  List<BarChartGroupData> barGroups = [];

  for (int i = 0; i < groupProgressData.length; i++) {
    barGroups.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            width: 30.0,
            y: groupProgressData[i],
          ),
        ],
      ),
    );
  }

  return barGroups;
  }


}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Left side: Image
              // Adjust spacing between image and texts
              // Right side: Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title 1',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Subtitle 1',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Description 1',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 90.0, // Adjust the width as needed
                height: 90.0, // Adjust the height as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

