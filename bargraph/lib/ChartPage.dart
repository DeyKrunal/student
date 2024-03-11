import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChartPage extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ChartPage> {
  Future<List<Map<dynamic,dynamic>>>? _progressData;
  var fid,gid;

  @override
  void initState() {
    super.initState();
    _readData();
    _progressData = getProgressData() as Future<List<Map<dynamic, dynamic>>>?;
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
  Future<List<Map<dynamic,dynamic>>> getProgressData() async {
    final response = await http.post(
        Uri.parse('https://project-pilot.000webhostapp.com/API/progress_name_data.php'),
        body: {"fid":gid}
    );
    print(response.body);
    return jsonDecode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<dynamic,dynamic>>>(
      future: getProgressData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final title = snapshot.data![index]['title'];
              final progress = snapshot.data![index]['progress'];
              return SquareCard(
                title: title,
                progress: progress,
              );
            },
          );
        } else {
          return Center(
            child: Text('No progress data available'),
          );
        }
      },
    );
  }
}

class SquareCard extends StatelessWidget {
  final String title;
  final int progress;

  SquareCard({
    required this.title,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
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
                width: progress.toDouble(),
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
    );
  }
}