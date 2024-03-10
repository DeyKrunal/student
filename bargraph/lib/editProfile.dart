import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateDataForm extends StatefulWidget {
  @override
  _UpdateDataFormState createState() => _UpdateDataFormState();
}

class _UpdateDataFormState extends State<UpdateDataForm> {
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();
  String _imageFile = "";

  void _updateData() {
    String text1 = _textField1Controller.text;
    String text2 = _textField2Controller.text;

    print("G Name = ${text1}");
    print("P Name = ${text2}");
    print("Image = ${_imageFile}");

    // Add your logic here to update the data using text1 and text2
    // For example, you can make an API call to update the data in your backend

    // Clear the text fields after updating
    _textField1Controller.clear();
    _textField2Controller.clear();
  }
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path).path;
        print("Hello1");
        print("Hello = ${_imageFile}");
      });
    } else {
      print('No image selected');
    }
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
                        _getImage();
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
}