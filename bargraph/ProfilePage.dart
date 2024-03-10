import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> ud ;

  Future<void> getdata() async {
    String uri = "https://project-pilot.000webhostapp.com/API/view_group_detail.php";
    try{
      var res = await http.get(Uri.parse(uri));
      setState(() {
        ud = jsonDecode(res.body);
      });
    }catch(e){print(e);}
  }
  int fetch(){
    if(ud["name4"] == null){
      return 3;
    }
    else if(ud["name4"] == null && ud["name3"] == null){
      return 2;
    }
    else if(ud["name4"] == null && ud["name3"] == null && ud["name2"]){
      return 1;
    }
    else{
      return 4;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 45),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('../assets/images/man.jpg'), // Add your profile image
                ),
                SizedBox(height: 16.0),
                Text(
                  ud["group_name"], // Replace with user's name
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'john.doe@example.com', // Replace with user's email
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 28.0),
                ElevatedButton(
                  onPressed: () {
                    // Add logout logic here
                    Navigator.pop(context); // Navigate back to the previous screen or login page
                  },
                  child: Text('Log Out'),
                ),
                SizedBox(height: 34.0),
                Container(
                  child:Column(
                    children: [
                      Align(alignment:Alignment.topLeft,child: Text("Group Members",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start)),
                      SizedBox(height: 15),
                      Center(
                        child: Container(
                          height: 400, // Height of the horizontal list
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: fetch(), // Number of cards in the list
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: double.infinity, // Width of each card
                                margin: EdgeInsets.all(8),
                                child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          children: [
                                            // Left side: Image
                                            Container(
                                              width: 80.0, // Adjust the width as needed
                                              height: 80.0, // Adjust the height as needed
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage('../assets/images/man.jpg'), // Replace with your image
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                              ud["name"+(index+1).toString()],
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    ud["div"+(index+1).toString()],
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    ud["email"+(index+1).toString()],
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      // ListView.builder(
                      //   scrollDirection: Axis.vertical,
                      //   itemCount: fetch(),
                      //   itemBuilder: (BuildContext context, int index){
                      //       return Card(
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(16.0),
                      //           child: Row(
                      //             children: [
                      //               // Left side: Image
                      //               Container(
                      //                 width: 80.0, // Adjust the width as needed
                      //                 height: 80.0, // Adjust the height as needed
                      //                 decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   image: DecorationImage(
                      //                     fit: BoxFit.cover,
                      //                     image: AssetImage('assets/sample_image.jpg'), // Replace with your image
                      //                   ),
                      //                 ),
                      //               ),
                      //               SizedBox(width: 16.0),
                      //               Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                 ud["name"+(index+1).toString()],
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
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //   }
                      // ),
                      // CardWithImageAndTexts(name: ud["name1"],),
                      // CardWithImageAndTexts(name: ud["name2"],),
                      // CardWithImageAndTexts(name: ud["name3"],),
                      // CardWithImageAndTexts(name: ud["name4"],),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CardWithImageAndTexts extends StatefulWidget {
  late String name;

  CardWithImageAndTexts({required this.name});

  @override
  State<CardWithImageAndTexts> createState() => _CardWithImageAndTextsState();
}

class _CardWithImageAndTextsState extends State<CardWithImageAndTexts> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left side: Image
            Container(
              width: 80.0, // Adjust the width as needed
              height: 80.0, // Adjust the height as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/sample_image.jpg'), // Replace with your image
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
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
          ],
        ),
      ),
    );
  }
}

