import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDataForm extends StatefulWidget {
  @override
  _UpdateDataFormState createState() => _UpdateDataFormState();
}

class _UpdateDataFormState extends State<UpdateDataForm> {
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();
  String _imageFile = "";
  var fid,gid;
  late String base64Image;
  late String fileName;

  get html => null;

  @override
  void initState() {
    super.initState();
    print("Hello");
    _readData();
  }

  Future<void> uploadImage(imageFile) async {
    base64Image = base64Encode(imageFile.readAsBytesSync());
    fileName = imageFile.path.split('/').last;
  }

  void chooseImage() async {
    XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      uploadImage(imageFile.path);
    }
  }

  Future<void> _updateData() async {
    String text1 = _textField1Controller.text;
    String text2 = _textField2Controller.text;
    print("G Name = ${text1}");
    print("P Name = ${text2}");
    print("Gid = ${gid}");
    final response = await http.post(
        Uri.parse(
            'https://project-pilot.000webhostapp.com/API/update_profile.php'),
        body: {
          "gname": text1,
          "pname": text2,
          "gid": gid,
        });
    print(response.body);
    var jsonData = jsonDecode(response.body);

    _textField1Controller.clear();
    _textField2Controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/man.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 130,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlueAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        chooseImage();
                        // Add your edit functionality here
                      },
                    ),),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _textField1Controller,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  hintText: 'Enter your Group Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _textField2Controller,
                decoration: InputDecoration(
                  labelText: 'Project Name',
                  hintText: 'Enter Project Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateData,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
              child: Text('Update Data', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
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
}