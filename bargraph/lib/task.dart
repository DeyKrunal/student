import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(

        body: SingleChildScrollView(

          padding: EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15),
              DateAndBellWidget(),
              SizedBox(height: 20),
              RectangleCardWidget(
                imagePath: 'assets/man.jpg',
                groupName: ' Group 01',
                groupId: 'Progress Pilot',
                progressPercentage: 70, // Example progress percentage
              ),
              SizedBox(height: 20),
              Card(
                shadowColor: Colors.yellow,
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Group Progress',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 250, // Increased height
                        child: BarChartWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              FacultyDetailsCard(
                facultyName: 'John Doe',
                facultyEmail: 'john.doe@example.com',
                facultyMobile: '+1234567890',
                facultyImageUrl: 'assets/man.jpg',
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
        ),
      ),
    );
  }
}

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
  final List<charts.Series<OrdinalSales, String>> seriesList = _createSampleData();

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('1', 25),
      OrdinalSales('2', 70),
      OrdinalSales('3', 45),
      OrdinalSales('4', 80),
      OrdinalSales('5', 30),
      OrdinalSales('6', 90),
      OrdinalSales('7', 55),
      OrdinalSales('8', 20),
      OrdinalSales('9', 65),
    ];

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
                    SizedBox(width: 80,

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
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 1.5),
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

class GaugePainter extends CustomPainter {
  final double value;
  final double size;

  GaugePainter({required this.value, required this.size});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = (size.width - 10) / 2;

    // Draw the gauge background
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(Offset(centerX, centerY), radius, backgroundPaint);

    // Draw the gauge arc
    Paint arcPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * (value / 150);
    canvas.drawArc(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius), startAngle, sweepAngle, false, arcPaint);

    // Draw the gauge ticks and labels
    TextStyle tickTextStyle = TextStyle(color: Colors.black, fontSize: 14);
    TextSpan tickTextSpan = TextSpan(style: tickTextStyle, text: value.toInt().toString());
    TextPainter tickTextPainter = TextPainter(text: tickTextSpan);
    tickTextPainter.layout();

    final double tickLength = 10;
    final double tickSpacing = 30;
    final double tickRadius = radius - 10;
    final double labelRadius = tickRadius - tickLength - 10;

    for (int i = 10; i <= 150; i += 10) {
      final double angle = -pi / 2 + 2 * pi * (i / 150);

      if (i % 50 == 0) {
        // Draw the label
        final double labelX = centerX + (labelRadius - 5) * cos(angle);
        final double labelY = centerY + (labelRadius - 5) * sin(angle);
        canvas.drawRect(Rect.fromLTWH(labelX - tickTextPainter.width / 2, labelY - tickTextPainter.height / 2, tickTextPainter.width, tickTextPainter.height), Paint()..color = Colors.black);
        tickTextPainter.paint(canvas, Offset(labelX, labelY));

        // Draw the tick
        final double tickX1 = centerX + (tickRadius - 5) * cos(angle);
        final double tickY1 = centerY + (tickRadius - 5) * sin(angle);
        final double tickX2 = centerX + (tickRadius + 5) * cos(angle);
        final double tickY2 = centerY + (tickRadius + 5) * sin(angle);
        canvas.drawLine(Offset(tickX1, tickY1), Offset(tickX2, tickY2), arcPaint);
      } else {
        // Draw the tick
        final double tickX = centerX + (tickRadius - 5) * cos(angle);
        final double tickY = centerY + (tickRadius - 5) * sin(angle);
        canvas.drawLine(Offset(tickX, tickY), Offset(tickX + tickLength * cos(angle), tickY + tickLength * sin(angle)), arcPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

