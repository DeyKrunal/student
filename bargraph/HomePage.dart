// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   Future<Map<String, dynamic>>?ud;
//   // late Map<String, dynamic> ud1;
//
//
//   Future<void> getdata() async {
//     String uri = "http://localhost/pro/API/view_gruop_detail.php";
//     try{
//       var res = await http.get(Uri.parse(uri));
//       setState(() {
//         print(res.body);
//
//         ud = jsonDecode(res.body);
//       });
//     }catch(e){print(e);}
//   }
//
//   // Future<void> getfdata() async {
//   //   String uri = "http://localhost/pro/API/view_faculty.php";
//   //   try{
//   //     var res = await http.get(Uri.parse(uri));
//   //     setState(() {
//   //       ud1 = jsonDecode(res.body);
//   //     });
//   //   }catch(e){print(e);}
//   // }
//   // int fetch(){
//   //   if(ud["name4"] == null){
//   //     return 3;
//   //   }
//   //   else if(ud["name4"] == null && ud["name3"] == null){
//   //     return 2;
//   //   }
//   //   else if(ud["name4"] == null && ud["name3"] == null && ud["name2"]){
//   //     return 1;
//   //   }
//   //   else{
//   //     return 4;
//   //   }
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // getfdata();
//     super.initState();
//     getdata();
//   }
//
//   final List<double> groupProgressData = [50, 75, 30, 90, 10, 20, 20, 90, 40];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: getdata(),
//         builder: (BuildContext context, snapshot) {
//           if(snapshot.hasData){
//             return Text("Connected");
//           }else{
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//
//       )
//       // SingleChildScrollView(
//       //   child: Column(
//       //     children: [
//       //     Container(
//       //     height: 150,
//       //     child: Card(
//       //       color: Colors.blue[100],
//       //       child: Padding(
//       //         padding: const EdgeInsets.all(16.0),
//       //         child: Row(
//       //           children: [
//       //             Expanded(
//       //               child: Column(
//       //                 crossAxisAlignment: CrossAxisAlignment.start,
//       //                 children: [
//       //                   Text(
//       //                     ud["group_name"],
//       //                     style: TextStyle(
//       //                       fontSize: 18.0,
//       //                       fontWeight: FontWeight.bold,
//       //                     ),
//       //                   ),
//       //                   SizedBox(height: 8.0),
//       //                   const Text(
//       //                     'Members : ',
//       //                     style: TextStyle(
//       //                       fontSize: 14.0,
//       //                       color: Colors.grey,
//       //                     ),
//       //                   ),
//       //                   SizedBox(height: 8.0),
//       //                   Text(
//       //                     'Guide : ',
//       //                     style: TextStyle(
//       //                       fontSize: 16.0,
//       //                     ),
//       //                   ),
//       //                 ],
//       //               ),
//       //             ),
//       //             Container(
//       //               // Adjust the height as needed
//       //               child: Image.asset('../assets/images/man.jpg'),
//       //             ),
//       //             SizedBox(width: 16.0),
//       //           ],
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       //       Center(
//       //         child: SizedBox(
//       //           height: 200, // Height of the horizontal list
//       //           child:  Container(
//       //                 width: double.infinity, // Width of each card
//       //                 margin: EdgeInsets.all(8),
//       //                 child: Card(
//       //                   child: Row(
//       //                     children: [
//       //                       Expanded(
//       //                         flex: 5, // Adjust the ratio of width between progress and info
//       //                         child: Padding(
//       //                           padding: EdgeInsets.all(16),
//       //                           child: Column(
//       //                             crossAxisAlignment: CrossAxisAlignment.start,
//       //                             mainAxisAlignment: MainAxisAlignment.center,
//       //                             children: [
//       //                               Text(
//       //                                 ud["group_name"],
//       //                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       //                               ),
//       //                               SizedBox(height: 8),
//       //                               Text(
//       //                                 ud["email1"],
//       //                               ),
//       //                             ],
//       //                           ),
//       //                         ),
//       //                       ),
//       //                       Expanded(
//       //                         flex: 6, // Adjust the ratio of width between progress and info
//       //                         child: Padding(
//       //                             padding: EdgeInsets.all(16),
//       //                             child: Image.network('https://tse1.mm.bing.net/th?id=OIP.-7A_QAbtBi8WJPFPmYb9NwAAAA&pid=Api&P=0&h=220')
//       //                         ),
//       //                       ),
//       //                     ],
//       //                   ),
//       //                 ),
//       //           ),
//       //         ),
//       //       ),
//       //       SizedBox(height: 10,),
//       //       Container(
//       //         height: 200, // Height of the horizontal list
//       //         child:Container(
//       //               width: double.infinity, // Width of each card
//       //               margin: EdgeInsets.all(8),
//       //               child: Card(
//       //                 child: Row(
//       //                   children: [
//       //                    const Expanded(
//       //                       flex: 5, // Adjust the ratio of width between progress and info
//       //                       child: Padding(
//       //                         padding: EdgeInsets.all(16),
//       //                         child: Column(
//       //                           crossAxisAlignment: CrossAxisAlignment.start,
//       //                           mainAxisAlignment: MainAxisAlignment.center,
//       //                           children: [
//       //                             Text(
//       //                               // ud1['f_name'],
//       //                               "Hello 1",
//       //                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       //                             ),
//       //                             SizedBox(height: 8),
//       //                             Text(
//       //                               'Description of Card 1',
//       //                             ),
//       //                           ],
//       //                         ),
//       //                       ),
//       //                     ),
//       //                     Expanded(
//       //                       flex: 6, // Adjust the ratio of width between progress and info
//       //                       child: Padding(
//       //                           padding: EdgeInsets.all(16),
//       //                           child: Image.network('https://up.yimg.com/ib/th?id=OIP.fqSvfYQB0rQ-6EG_oqvonQHaHa&%3Bpid=Api&rs=1&c=1&qlt=95&w=121&h=121')
//       //                         // child: CircularProgressIndicator(
//       //                         // 	value: 0.5, // Replace with your progress value
//       //                         // 	strokeWidth: 15,
//       //                         // 	backgroundColor: Colors.grey,
//       //                         // 	valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//       //                         // ),
//       //                       ),
//       //                     ),
//       //                   ],
//       //                 ),
//       //               ),
//       //             ),
//       //         ),
//       //       Center(
//       //         child: Container(
//       //           height: 200, // Height of the horizontal list
//       //           child: ListView.builder(
//       //             scrollDirection: Axis.horizontal,
//       //             itemCount: fetch(), // Number of cards in the list
//       //             itemBuilder: (BuildContext context, int index) {
//       //               return Container(
//       //                 width: 150, // Width of each card
//       //                 margin: EdgeInsets.all(8),
//       //                 child: Card(
//       //                   color: Colors.blue[100],
//       //                   child: Column(
//       //                     mainAxisAlignment: MainAxisAlignment.center,
//       //                     children: [
//       //                       Center(
//       //                         child: Text(
//       //                           ud["name"+(index+1).toString()],
//       //                           style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       //                         ),
//       //                       ),
//       //                       SizedBox(height: 8),
//       //                       Text(
//       //                         ud["email"+(index+1).toString()],
//       //                         textAlign: TextAlign.center,
//       //                       ),
//       //                     ],
//       //                   ),
//       //                 ),
//       //               );
//       //             },
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
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
// class HomePage extends StatelessWidget {
//
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
//                       "Hello",
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
//                 // Adjust the height as needed
//                 child: Image.asset('../assets/images/man.jpg'),
//               ),
//               SizedBox(width: 16.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
