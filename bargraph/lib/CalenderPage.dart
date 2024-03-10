import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'modal/event.dart';
import 'package:table_calendar/table_calendar.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TimeOfDay startTTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  late List<Map<String,dynamic>> jsondata;
  TextEditingController _eventController = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    _readData();
    // Fetch schedule data when the widget is initialized
    fetchScheduleData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F5FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(29.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(10),
                child: TableCalendar(
                  focusedDay: selectedDay,
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  daysOfWeekVisible: true,
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      selectedDay = selectDay;
                      focusedDay = focusDay;
                      String formattedDate = DateFormat('yyyy-MM-dd').format(focusDay);
                      print("Date = ${formattedDate}");

                    });
                  },
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },
                  eventLoader: _getEventsfromDay,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: Container(
                    height: 300,
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List? jsonData = snapshot.data;
                            return Column(
                              children: jsonData!.map((data) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                      tileColor: Colors.grey[300],
                                      leading: Icon(Icons.event, color: Colors.blue),
                                      title: Text(
                                        data['title'],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.0),
                                          Text(
                                            'Date: ${data['date']}',
                                            style: TextStyle(color: Colors.black87),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'Time: ${data['start']} - ${data['end']}',
                                            style: TextStyle(color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error fetching data');
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    print('** event for day: ${selectedEvents[date]}');
    return selectedEvents[date] ?? [];
  }

  Future<List<dynamic>> fetchData() async {
    // Simulated JSON data
    final response = await http.post(
        Uri.parse(
            'https://project-pilot.000webhostapp.com/API/view_schedule.php'),
        body: {"fid": "${fid}"});
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData;
  }

  Future<void> fetchScheduleData() async {
    final response = await http.post(
        Uri.parse(
            'https://project-pilot.000webhostapp.com/API/view_schedule.php'),
        body: {"fid": "${fid}"});

    print("88 events data: ${response.body}");
    List<dynamic> data = jsonDecode(response.body);
    updateEvents(data);
  }

  Future<void> addSchedule(String eventTitle, TimeOfDay startTime, TimeOfDay endTime) async {
    final response = await http.post(
      Uri.parse('https://project-pilot.000webhostapp.com/API/insert_schedule.php'),
      body: {
        'fid': '${fid}',
        'date': flutterDateTimeToSqlDate(selectedDay),
        'start_time': flutterTimeOfDayToSqlTime(startTime),
        'remark': eventTitle,
        'end_time': flutterTimeOfDayToSqlTime(endTime),
      },
    );

    print("** add schedule: ${response.body}");

    // Check if the API call was successful before fetching updated schedule data
    if (response.statusCode == 200) {
      // Parse the response to get the added event details
      final addedEvent = jsonDecode(response.body);

      // Update the selectedEvents map with the new event
      DateTime date = DateTime.parse(addedEvent['date']);
      if (selectedEvents[date] == null) {
        selectedEvents[date] = [];
      }
      selectedEvents[date]?.add(Event(
        title: addedEvent['title'],
        date: addedEvent['date'],
        startTime: addedEvent['start'],
        endTime: addedEvent['end'],
      ));

      // Update the state to trigger a rebuild of the UI
      setState(() {});
    }
  }

  void updateEvents(List<dynamic> data) {
    for (var item in data) {
      DateTime date = DateTime.parse(item['date']);
      if (selectedEvents[date] == null) {
        selectedEvents[date] = [];
      }
      selectedEvents[date]?.add(Event(
        endTime: item["end"],
        startTime: item["start"],
        date:item["date"],
        title: item['title'],
        // Add other properties as needed (start, end, etc.)
      ));
    }
    print("*** selected event: ${selectedEvents}");
    setState(() {});
  }


  String flutterDateTimeToSqlDate(DateTime dateTime) {
    // Convert to local time zone
    dateTime = dateTime.toLocal();

    // Format as SQL date (yyyy-MM-dd)
    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return formattedDate;
  }

  String flutterTimeOfDayToSqlTime(TimeOfDay timeOfDay) {
    // Format as SQL time (HH:mm:ss)
    String formattedTime = "${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}:00";

    return formattedTime;
  }

}
