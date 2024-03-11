import 'dart:convert';
import 'package:bargraph/editProfile.dart';
import 'package:bargraph/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'modal/view_group.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoaded = false;
  late group g;
  var fid,gid;

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
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('login'); // Remove the 'login' key from SharedPreferences

    // Navigate back to the login screen or previous screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => OnbodingScreen())); // Navigate back to the previous screen or login page
  }

  @override
  void initState() {
    // TODO: implement initState
    // fetchdata();
    _readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 45),
        child: Center(
          child: FutureBuilder(
            future: fetchGroup(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return  CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return  Text("Error");
              } else {
                g = group.fromJson(snapshot.data!);
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70.0, // Sets the radius of the circle avatar
                          backgroundImage: NetworkImage("http://project-pilot.000webhostapp.com/upload/${g.image}"), // Specifies the image to display
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          g.groupName, // Replace with user's name
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 28.0),
                        Center(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, // Aligns the children of the Row to the center horizontally
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Add logout logic here
                                    _logout(); // Navigate back to the previous screen or login page
                                  },
                                  icon: Icon(Icons.logout), // Add your desired icon for logout
                                  label: Text('Log Out'),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Add edit logic here
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateDataForm())); // Navigate to the edit screen
                                  },
                                  icon: Icon(Icons.edit), // Add your desired icon for edit
                                  label: Text('Edit'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 34.0),
                        const Text("Group Members",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start),
                        const SizedBox(height: 15),
                        Container(
                          height: MediaQuery.of(context).size.width * .87,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index) {
                                return snapshot.data!["name$index"] != null && snapshot.data!["name$index"] != ""
                                    ? Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        // Left side: Image
                                        Container(
                                          width: 80.0,
                                          // Adjust the width as needed
                                          height: 80.0,
                                          // Adjust the height as needed
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/man.jpg'), // Replace with your image
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Name: ${snapshot.data!['name$index']}",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                "Div: ${snapshot.data!['div$index']}",
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                "Phone No: ${snapshot.data!['phno$index']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                "Email: ${snapshot.data!['email$index']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                "Roll No: ${snapshot.data!['rn$index']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ) : Container();
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class CardWithImageAndTexts extends StatelessWidget {
  late String name;

  CardWithImageAndTexts({required this.name});

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
                  image: AssetImage(
                      '../assets/sample_image.jpg'), // Replace with your image
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
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
