import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:karmbodh/features/calendar/data/model/nepali_month.dart';

class CalendarService {
  Future<List<NepaliMonth>> loadCalendar() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/nepali_calendar.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData
        .map((monthJson) => NepaliMonth.fromJson(monthJson))
        .toList();
  }
}
