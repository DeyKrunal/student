import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import 'modal/view_faculty.dart';
import 'modal/view_group.dart';

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage2> {
  late List<group> groups; // Change the type to a list of groups

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<Map<String,dynamic>> fetchData() async {
    String uri = "http://localhost/pro/API/view_gruop_detail.php";
    var res = await http.get(Uri.parse(uri));
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
            child:Text("jay") ,
            );
              };

          }

      ),
    );
  }

  Widget buildGroupCard(group groupData) {
    return Container(
      height: 150,
      child: Card(
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupData.groupName, // Example: Access group name from groupData
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      groupData.facultyId, // Example: Access faculty ID from groupData
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      groupData.status, // Example: Access status from groupData
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // Adjust the height as needed
                child: Image.network(groupData.image), // Example: Access image URL from groupData
              ),
              SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   late Map<String, dynamic> g;
//   late Map<String, dynamic> ud;
//   // List<dynamic> ud1 = [];
//   late Faculty f;
//   // late List<String> g = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // getdata();
//     // getfdata();
//     super.initState();
//     // getdata();
//     fetchData();
//     // getdata1();
//   }
//   // Future<void> getdata() async {
//   //   // String uri = "http://localhost:81/pro/API/view_gruop_detail.php";
//   //   String uri = "http://localhost:81/pro/API/view_faculty.php";
//   //   try{
//   //     var res = await http.get(Uri.parse(uri));
//   //     setState(() {
//   //       print(res.body);
//   //       f = Faculty.fromJson(jsonDecode(res.body));
//   //       print(f.fName);
//   //     });
//   //   }catch(e){print(e);}
//   // }
//   // Future<group> getdata1() async {
//   //   String uri = "https://localhost:81/pro/API/view_gruop_detail.php";
//   //   // String uri = "http://localhost:81/pro/API/view_faculty.php";
//   //   try{
//   //     var res = await http.get(Uri.parse(uri));
//   //     return group.fromJson(jsonDecode(res.body));
//   //     // setState(() {
//   //     //   // print(res.body);
//   //     //   ud = jsonDecode(res.body);
//   //     //   g = group.fromJson(jsonDecode(res.body)) as Future<group>;
//   //     //   print(g);
//   //     // });
//   //   }catch(e){print(e);}
//   // }
//
//   Future<Map<String, dynamic>> fetchData() async {
//     String uri = "http://localhost/pro/API/view_gruop_detail.php";
//     try {
//       var res = await http.get(Uri.parse(uri));
//       print(res.body);
//       g = group.fromJson(jsonDecode(res.body)) as Map<String, dynamic>;
//       print(g[1]);
//       return g;
//     } catch (e) {
//       print(e);
//       throw e;
//     }
//   }
//
//   // int fetch(){
//   //   if(g.name4 == ""){
//   //     return 3;
//   //   }
//   //   else if(g.name4 == "" && g.name3 == ""){
//   //     return 2;
//   //   }
//   //   else if(g.name4 == "" && g.name3 == "" && g.name2 == ""){
//   //     return 1;
//   //   }
//   //   else{
//   //     return 4;
//   //   }
//   // }
//
//
//
//   final List<double> groupProgressData = [50, 75, 30, 90, 10, 20, 20, 90, 40];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           return Container(
//             height: 150,
//             child: Card(
//               color: Colors.blue[100],
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     // Left side: Image
//                     // Adjust spacing between image and texts
//                     // Right side: Texts
//                     for (int i = 0 ;i <= snapshot.data!.length; i++)
//                       Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Hello",
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Text(
//                             'Subtitle 1',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Text(
//                             'Description 1',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       // Adjust the height as needed
//                       // child: Image.asset('../assets/images/man.jpg'),
//                     ),
//                     SizedBox(width: 16.0),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//       )
//     );
//   }
//
//   List<BarChartGroupData> createBarGroups() {  List<BarChartGroupData> barGroups = [];
//
//   for (int i = 0; i < groupProgressData.length; i++) {
//     barGroups.add(
//       BarChartGroupData(
//         x: i,
//         barRods: [
//           BarChartRodData(
//             width: 30.0,
//             y: groupProgressData[i],
//           ),
//         ],
//       ),
//     );
//   }
//
//   return barGroups;
//   }
// }
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
                      "Hello",
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
                // Adjust the height as needed
                child: Image.asset('../assets/images/man.jpg'),
              ),
              SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

