class CalendarDay {
  final String nepaliDay;
  // final DateTime englishDay;
  final String englishDay;
  final String tithi;
  final bool isHoliday;
  final String? event;
  final String englishFullDate;

  CalendarDay({
    required this.nepaliDay,
    required this.englishDay,
    required this.tithi,
    required this.isHoliday,
    required this.englishFullDate,
    this.event,
  });

  factory CalendarDay.fromJson(Map<String, dynamic> json) {
    return CalendarDay(
      nepaliDay: json['nepaliDay'].toString(),
      englishDay: json['englishDay'].toString(),
      englishFullDate: json['englishFullDate'].toString(),
      tithi: json['tithi'] as String,
      isHoliday: json['isHoliday'] as bool,
      event: json['event'],
    );
  }
}
