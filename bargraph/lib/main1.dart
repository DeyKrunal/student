import 'package:bargraph/ChatBot.dart';
import 'package:bargraph/splash.dart';
import 'package:flutter/material.dart';

import 'ChartPage.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'CalenderPage.dart';
import 'main.dart';

void main() {
  runApp(splash());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: BottomNavigationDemo(),
    );
  }
}

class BottomNavigationDemo extends StatefulWidget {
  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MyHomePage(),
    ProgressPage(),
    AddSchedule(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black),
            label: 'Home',
            backgroundColor: Colors.blue[300],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart,color: Colors.black),
            label: 'Chart',
            backgroundColor: Colors.blue[300],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today,color: Colors.black),
            label: 'Calendar',
            backgroundColor: Colors.blue[300],

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.black),
            label: 'Profile',
            backgroundColor: Colors.blue[300],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
          backgroundColor: Colors.deepPurple[200],
          onPressed: (){
            Navigator.push(
              context , MaterialPageRoute(builder: (context) => ChatPage())
            );
          },
        child: Icon(Icons.chat)
      ),
    );
  }
}
// class CalendarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Calendar Page'),
//     );
//   }
// }


// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 radius: 50.0,
//                 backgroundImage: AssetImage('assets/profile_image.jpg'), // Add your profile image
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'Group Name', // Replace with user's name
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 'john.doe@example.com', // Replace with user's email
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.grey,
//                 ),
//               ),
//               SizedBox(height: 28.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add logout logic here
//                   Navigator.pop(context); // Navigate back to the previous screen or login page
//                 },
//                 child: Text('Log Out'),
//               ),
//               SizedBox(height: 34.0),
//               Container(
//                 child:Column(
//                   children: [
//                     Align(alignment:Alignment.topLeft,child: Text("Group Members",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start)),
//                     SizedBox(height: 15),
//                     CardWithImageAndTexts(),
//                     CardWithImageAndTexts(),
//                     CardWithImageAndTexts(),
//                     CardWithImageAndTexts(),
//                   ],
//                 ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class CardWithImageAndTexts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             // Left side: Image
//             Container(
//               width: 80.0, // Adjust the width as needed
//               height: 80.0, // Adjust the height as needed
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/sample_image.jpg'), // Replace with your image
//                 ),
//               ),
//             ),
//             SizedBox(width: 16.0), // Adjust spacing between image and texts
//
//             // Right side: Texts
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Title 1',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     'Subtitle 1',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     'Description 1',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
