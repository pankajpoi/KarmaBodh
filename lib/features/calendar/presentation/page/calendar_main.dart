import 'package:flutter/material.dart';
import 'package:flutter_bs_ad_calendar/flutter_bs_ad_calendar.dart';

class CalendarMain extends StatefulWidget {
  const CalendarMain({super.key});

  @override
  State<CalendarMain> createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calender")),
      body: FlutterBSADCalendar(
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2030),
        onMonthChanged: (date, events) {
          setState(() {
            selectedDate = date;
          });
        },
        onDateSelected: (date, events) {
          setState(() {
            selectedDate = date;
          });
        },
      ),
    );
  }
}
