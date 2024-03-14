import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'modal/faq_modal.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textController = TextEditingController();
  List<Map<String, String>> _messages = [];

  static const String baseURL = 'https://project-pilot.000webhostapp.com/API/faq_api.php';

  static Future<List<FAQ>> fetchFAQs(String question) async {
    final response = await http.post(Uri.parse('$baseURL?question=$question')).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      if (data is List) {
        List<FAQ> faqs = data.map((item) => FAQ.fromJson(item)).toList();
        return faqs;
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load FAQs (${response.statusCode})');
    }
  }
  void _sendMessage() async {
    String message = _textController.text;
    _textController.clear();
    setState(() {
      _messages.add({'sender': 'You', 'message': message});
    });

    // Send the message to the backend and receive the response
    // List<String> responses = await _getResponseFromBackend(message);
    List<String> responses = await _getResponseFromBackend(message);
    setState(() {
      for (String response in responses) {
        _messages.add({'sender': 'Progress Pilot', 'message': response});
      }
    });
  }

  Future<List<String>> _getResponseFromBackend(String message) async {
    // Make an HTTP request to the backend API
    var url = Uri.parse('https://project-pilot.000webhostapp.com/API/faq_api.php');
    var response = await http.post(url, body: {'question': message});

    if (response.statusCode == 200) {
      // Parse the JSON response and extract the answers
      List<dynamic> data = json.decode(response.body);
      List<String> botResponses = data.map<String>((item) => item['answer'] as String).toList();
      var l=botResponses.length;
      if(l<1){
        botResponses=['No Any Question Found'];
      }
      return botResponses;
    } else {
      // Handle error response
      throw Exception('Failed to get response from backend');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: _messages[index]['sender'] == 'You' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Text(
                        _messages[index]['sender']!,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Align(
                      alignment: _messages[index]['sender'] == 'You' ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: _messages[index]['sender'] == 'You' ? Colors.blue : Colors.green,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          _messages[index]['message']!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Enter your question...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
