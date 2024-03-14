import 'package:flutter/foundation.dart';

class Event {
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  Event({required this.title,required this.date, required this.startTime,required this.endTime,});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      date: json['date'] as String,
      startTime: json['start'],
      endTime: json['end']
    );
  }

}