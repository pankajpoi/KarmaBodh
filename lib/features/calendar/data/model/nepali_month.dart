import 'calendar_day.dart';

class NepaliMonth {
  final String year;
  final String monthName;
  final int monthIndex;
  final List<CalendarDay> days;

  NepaliMonth({
    required this.year,
    required this.monthName,
    required this.monthIndex,
    required this.days,
  });

  factory NepaliMonth.fromJson(Map<String, dynamic> json) {
    return NepaliMonth(
      year: json['year'].toString(), //converts to string
      monthName: json['month'].toString(),
      monthIndex: json['monthIndex'] as int,
      days: (json['days'] as List)
          .map((day) => CalendarDay.fromJson(day))
          .toList(),
    );
  }
}
