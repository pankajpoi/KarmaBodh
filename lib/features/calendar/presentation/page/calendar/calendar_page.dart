import 'package:flutter/material.dart';
import 'package:karmbodh/features/calendar/data/model/calendar_day.dart';
import 'package:karmbodh/features/calendar/data/model/nepali_month.dart';
import 'package:karmbodh/features/calendar/presentation/widgets/date_detail_sheet.dart';
import 'package:karmbodh/features/calendar/presentation/widgets/month_info_bar.dart';
import 'package:karmbodh/features/calendar/services/calendar_service.dart';
import 'calendar_grid.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Future<List<NepaliMonth>> _calendarFuture;
  List<NepaliMonth> _months = [];

  int _currentMonthIndex = 0;
  CalendarDay? _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFuture = CalendarService().loadCalendar();
  }

  void _goToPreviousMonth() {
    if (_currentMonthIndex > 0) {
      setState(() {
        _currentMonthIndex--;
        _selectedDay = null;
      });
    }
  }

  void _goToNextMonth() {
    if (_currentMonthIndex < _months.length - 1) {
      setState(() {
        _currentMonthIndex++;
        _selectedDay = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nepali Calendar'), centerTitle: true),
      body: FutureBuilder<List<NepaliMonth>>(
        future: _calendarFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          _months = snapshot.data!;
          final NepaliMonth currentMonth = _months[_currentMonthIndex];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _currentMonthIndex > 0
                          ? _goToPreviousMonth
                          : null,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Expanded(
                      child: Text(
                        '${currentMonth.monthName} ${currentMonth.year}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _currentMonthIndex < _months.length - 1
                          ? _goToNextMonth
                          : null,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: CalendarGrid(
                  days: currentMonth.days,
                  selectedDay: _selectedDay,
                  onDaySelected: (day) {
                    setState(() {
                      _selectedDay = day;
                    });

                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (_) => DateDetailSheet(day: day),
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              Expanded(
                flex: 6,
                child: MonthInfoBar(
                  days: currentMonth.days,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
