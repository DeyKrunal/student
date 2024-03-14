import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ProgressPage extends StatefulWidget {
  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  var gid;
  List<String> arr = [
    "Project Profile & Objectives",
    "Requirement Specifications",
    "Project Modules & Flow",
    "Data Dictionary & Table Relations",
    "DFD Or USeCase Or UML Etc..",
    "BackEnd Or UserSide",
    "FrontEnd Or AdminSide",
    "Testing & Validations",
    "Documentations"
  ];
  @override
  void initState() {
    super.initState();
    _readData();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Center(child:Text('Group Progress')),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final progressData = snapshot.data!;
            return progressData[0]["error"] != "No data found" ?
              ListView.builder(
              itemCount: progressData.length ,
              itemBuilder: (context, index) {
                double cardWidth = MediaQuery.of(context).size.width * 0.7;
                final item = progressData[index];
                var title = item['title'] ?? '';
                var progress = int.tryParse(item['progress'] ?? '0') ?? 0;
                return SquareCard(
                  title: title,
                  progress: progress,
                  cardWidth: cardWidth,
                  alignRight: index.isEven,
                );
              },
            ) :Container(child: Center(child: Text("No Progress Uploaded .....",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)));
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    print("*GID = ${gid}");
    final response = await http.get(
        Uri.parse('https://project-pilot.000webhostapp.com/API/progress_name_data.php?fid=${gid}')
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class SquareCard extends StatelessWidget {
  final String title;
  final int progress;
  final double cardWidth;
  final bool alignRight;

  SquareCard({
    required this.title,
    required this.progress,
    required this.cardWidth,
    this.alignRight = false,
  });

  @override
  Widget build(BuildContext context) {
    double progressWidth = cardWidth * (progress / 100);

    return Align(
      alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepPurple[100],
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
            SizedBox(height: 15),
            Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7E7E9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: 10,
                  width: progressWidth,
                  decoration: BoxDecoration(
                    color: Color(0xFFEE93A2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  '$progress%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
