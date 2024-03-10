import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:bargraph/modal/view_progress.dart';
import 'package:bargraph/task.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modal/view_faculty.dart';
import 'modal/view_group.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late group g;
  late Faculty f;
  late progress p;
  // late Map<String,dynamic> ud ;
  var fid,gid;
  var amt = 0;
  List<double> groupProgressData = [];

  @override
  void initState() {
    super.initState();
    print("Hello");
    loadData();
    _readData();
    print(fetchData3());
  }
  double _progressValue = 600;

  void _updateProgress(double value) {
    setState(() {
      _progressValue = value;
    });
  }

  Future<void> _readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value1 = prefs.getString('gid');
    if (value1 != null) {
      setState(() {
        gid = value1; // Update the user variable with the retrieved value
      });
      print("gid = ${value1}");
    } else {
      setState(() {
        gid = "guest"; // Set user to "guest" if no value is found
      });
      print('No value found for the key');
    }

    String? value2 = prefs.getString('fid');
    if (value2 != null) {
      setState(() {
        fid = value2; // Update the user variable with the retrieved value
      });
      print("fid = ${value2}");
    } else {
      setState(() {
        fid = "guest"; // Set user to "guest" if no value is found
      });
      print('No value found for the key');
    }
  }

  Future<Map<String, dynamic>> fetchGroup() async {
    String uri = "https://project-pilot.000webhostapp.com/API/view_group_detail.php";
    var res = await http.post(Uri.parse(uri), body: {
      "gid":"$gid"
    });
    return jsonDecode(res.body);
  }

  Future<Map<String,dynamic>> fetchFaculty() async {
    String uri = "https://project-pilot.000webhostapp.com/API/view_faculty.php";
    var res = await http.post(Uri.parse(uri),body: {
      "fid":"${fid}"
    });
    // print(res.body);
    return jsonDecode(res.body);
  }

  void loadData() async {
    var x = await fetchData3();
    print(x);
    //final json = x as Map<dynamic, dynamic>;
    //var a = progress.fromJson(json);
    print(x["proid"]);
    amt = x["count"];
    print("Total = ${amt}");
    for (var i = 1; i <= 9; i++) {
      print( x["p"+i.toString()]);
      groupProgressData.add(int.parse(x["p"+i.toString()]) as double);
    }
  }

  Future<Map<dynamic,dynamic>> fetchData3() async {
    String uri = "https://project-pilot.000webhostapp.com/API/progress_api.php";
    var res = await http.post(Uri.parse(uri),body: {
      "grp_id":"${gid}"
    });
    print(res.body);
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(

        padding: EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 15),
            DateAndBellWidget(),
            SizedBox(height: 20),
            FutureBuilder(
              future: fetchGroup(),
              builder: (BuildContext context,  snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else if(snapshot.hasError){
                  return Center(child: Text("Something went wrong"));
                }else{
                  g = group.fromJson(snapshot.data!);
                  return RectangleCardWidget(
                    imagePath: 'assets/man.jpg',
                    groupName: ' Group 0${g.gsid}',
                    groupId: g.groupName,
                    progressPercentage: 70, // Example progress percentage
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          startAngle: 150,
                          endAngle: 30,
                          minimum: 0,
                          maximum: 900,
                          interval: 100,
                          radiusFactor: 0.99,
                          labelOffset: 20,
                          majorTickStyle: MajorTickStyle(length: 0.15, thickness: 2),
                          minorTickStyle: MinorTickStyle(length: 0.07, thickness: 1),
                          axisLineStyle: AxisLineStyle(thickness: 3),
                          ranges: <GaugeRange>[
                            GaugeRange(startValue: 0, endValue: _progressValue)
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(knobStyle: KnobStyle(knobRadius: 0.07,sizeUnit: GaugeSizeUnit.factor,borderWidth: 0.65,borderColor: Colors.lightBlue),value: _progressValue,enableAnimation: true,animationType: AnimationType.easeInCirc,onValueChanged: _updateProgress,),
                            RangePointer(value: _progressValue,enableAnimation: true,animationType: AnimationType.easeInCirc,color: Colors.lightBlue,onValueChanged: _updateProgress,)
                            ,MarkerPointer(markerWidth: 15,value: _progressValue,enableAnimation: true,animationType: AnimationType.easeInCirc,color: Colors.black,onValueChanged: _updateProgress,),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Text('Group Progress', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black)),
                                angle: 90,
                                positionFactor: 0.8
                            ),
                            GaugeAnnotation(
                                widget: Text('600', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)),
                                angle: 90,
                                positionFactor: 0.0
                            )
                          ],

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: fetchFaculty(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }else if(snapshot.hasError){
                  return Center(child: Text("Something went wrong"));
                }else{
                  f = Faculty.fromJson(snapshot.data!);
                  return FacultyDetailsCard(
                    facultyName: f.fName,
                    facultyEmail: f.fEmail,
                    facultyMobile: '+91${f.fPhno}',
                    facultyImageUrl: 'assets/man.jpg',
                  );
                }
              },
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                // color: Colors.red,
              ),
              child: Padding(

                padding:  EdgeInsets.only(top:20),
                child: Row(
                  children: [

                    SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(Icons.timeline, size: 28, color: Colors.black), // Adjust icon properties as needed
                        SizedBox(width: 8), // Adjust spacing between icon and text
                        Text(
                          'Time Line',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TimelineItem(
              bulletColor: Colors.pink,
              time: 'DEC - JAN',
              title: 'Project Session Start',
              description: 'Group Details & Faculty Allocation & start Project Work',

            ),
            TimelineItem(
              bulletColor: Colors.green,
              time: 'FEB - MIDD',
              title: 'Theory Examination',
              description: 'Internal & External Theory Exams',
            ),
            TimelineItem(
              bulletColor: Colors.orange,
              time: 'MAR - END',
              title: 'Internal Submission',
              description: 'Internal Submission Of Project & Seminar',
            ),
            TimelineItem(
              bulletColor: Colors.pink,
              time: 'APR - MIDD',
              title: 'External Submission',
              description: 'External Submission Of Project & Seminar',
            ),
            TimelineItem(
              bulletColor: Colors.green,
              time: 'APR',
              title: 'End Of Bachelor\'s',
              description: '',
            ),
          ],

        ),
      )
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
    print(groupProgressData[i]);
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
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       child: Card(
//         color: Colors.blue[100],
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               // Left side: Image
//               // Adjust spacing between image and texts
//               // Right side: Texts
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Title 1',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Subtitle 1',
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Description 1',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: 90.0, // Adjust the width as needed
//                 height: 90.0, // Adjust the height as needed
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(width: 16.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class DateAndBellWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd').format(now);
    String formattedDay = DateFormat('EEEE').format(now);
    String formattedMonthYear = DateFormat('MMMM, yyyy').format(now);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),
              Text(
                formattedDay,
                style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                formattedMonthYear,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_active_outlined, color: Color(0xFF3D72DC),size: 30,),
              onPressed: () {
                // Add your notification handling logic here
              },
            ),
            Positioned(
              right: 5,
              top: 7,
              child: Icon(Icons.circle, size: 10, color:Colors.redAccent), // Red dot indicating notifications
            ),
          ],
        ),
      ],
    );
  }
}


class TimelineItem extends StatelessWidget {
  final Color bulletColor;
  final String time;
  final String title;
  final String description;

  const TimelineItem({
    required this.bulletColor,
    required this.time,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 15, // Increase the width to create a small line segment
            height:15, // Set the height to control the length of the line segment
            margin: const EdgeInsets.only(top: 50), // Adjust top margin to center it vertically

            decoration: BoxDecoration(
              color: bulletColor, // Color of the bullet line
              borderRadius: BorderRadius.circular(8), // Curved ends of the bullet line
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            // child: Card(
            //
            //   color: bulletColor,

            child: Card(

              elevation:4,

              child: Padding(

                padding: const EdgeInsets.all(10.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(

                      time,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      softWrap: true,
                    ),
                    SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final List<charts.Series<OrdinalSales, String>> seriesList;

  BarChartWidget(List<dynamic> groupProgressData)
      : seriesList = _createSampleData(groupProgressData.cast<double>());

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData(
      List<double> groupProgressData) {
    final data = List.generate(
      groupProgressData.length,
          (index) => OrdinalSales(
        (index + 1).toString(),
        groupProgressData[index] as int,
      ),
    );

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF5D47BF)),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}


class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class RectangleCardWidget extends StatelessWidget {
  final String imagePath;
  final String groupName;
  final String groupId;
  final int progressPercentage;

  RectangleCardWidget({
    required this.imagePath,
    required this.groupName,
    required this.groupId,
    required this.progressPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Color(0xFFE2D9FC),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Icon(
                      Icons.groups_outlined, // Replace with your desired icon
                      size: 24, // Adjust size as needed
                      color: Colors.black, // Adjust color as needed
                    ),
                    SizedBox(width: 100,
                        // Adjust spacing between icon and text
                        child: Text(
                          maxLines: 2, // Allow multiple lines
                          overflow: TextOverflow.ellipsis,
                          groupName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                SizedBox(height: 4),
                Row(

                  children: [

                    Icon(
                      Icons.info_outline, // Replace with your desired icon
                      size: 24, // Adjust size as needed
                      color: Colors.black,
                      // Adjust color as needed
                    ),
                    SizedBox(width: 8), // Adjust spacing between icon and text
                    SizedBox(

                      width: 60, // Adjust width as needed
                      child: Text(

                        groupId, // Limit text to 10 characters
                        maxLines: 2, // Allow multiple lines
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    SizedBox(
                      width: 100, // Adjust width
                      height: 100, // Adjust height
                      child: CustomPaint(
                        painter: CurvePainter(progressPercentage: progressPercentage),
                        child: Center(
                          child: Text(
                            '$progressPercentage%',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final int progressPercentage;

  CurvePainter({required this.progressPercentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF52B4D4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    double progressRadians = (progressPercentage / 100) * 2 * 3.14;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 45),
      -3.14 / 2,
      progressRadians,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class FacultyDetailsCard extends StatelessWidget {
  final String facultyName;
  final String facultyEmail;
  final String facultyMobile;
  final String facultyImageUrl;

  const FacultyDetailsCard({
    Key? key,
    required this.facultyName,
    required this.facultyEmail,
    required this.facultyMobile,
    required this.facultyImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFBE6EC),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                facultyImageUrl,
                width: 100, // Adjust width
                height: 100, // Adjust height
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.perm_identity_outlined), // Replace icon_name with the name of the desired icon
                      SizedBox(width: 8), // Add some spacing between the icon and the text
                      Flexible(
                        child: Text(
                          '$facultyName',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email), // Replace 'email' with the desired email icon
                      SizedBox(width: 8), // Add some spacing between the icon and the text
                      Flexible(
                        child: Text(
                          '$facultyEmail',
                          style: TextStyle(fontSize: 16),
                          // maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.call), // Replace 'email' with the desired email icon
                      SizedBox(width: 8), // Add some spacing between the icon and the text
                      Flexible(
                        child: Text(
                          '$facultyMobile',
                          style: TextStyle(fontSize: 16),
                          // maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
