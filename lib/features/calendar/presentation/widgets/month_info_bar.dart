import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karmbodh/features/calendar/data/model/calendar_day.dart';


class MonthInfoBar extends StatefulWidget {
  final List<CalendarDay> days;

  const MonthInfoBar({
    super.key,
    required this.days,
  });

  @override
  State<MonthInfoBar> createState() => _MonthInfoBarState();
}

class _MonthInfoBarState extends State<MonthInfoBar> {
  final ScrollController _controller = ScrollController();
  final DateFormat _dateFormat = DateFormat('MMMM d, yyyy');

  late List<DateTime> parsedDates;

  @override
  void initState() {
    super.initState();

    // Parse all dates once (efficient)
    parsedDates = widget.days
        .map((d) => _dateFormat.parse(d.englishFullDate))
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  void _scrollToToday() {
    final today = DateTime.now();

    final index = parsedDates.indexWhere((d) =>
        d.year == today.year &&
        d.month == today.month &&
        d.day == today.day);

    if (index != -1) {
      _controller.animateTo(
        index * 72.0, // approximate ListTile height
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    // FIXED filter condition
    final importantDays = widget.days.where((day) =>
        (day.event != null && day.event!.isNotEmpty) || day.isHoliday).toList();

    if (importantDays.isEmpty) {
      return const Center(
        child: Text(
          'No special events this month.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Month Highlights',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            controller: _controller,
            itemCount: widget.days.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1),
            itemBuilder: (context, index) {
              final day = widget.days[index];
              final date = parsedDates[index];

              final isToday = date.year == today.year &&
                  date.month == today.month &&
                  date.day == today.day;

              return ListTile(
                tileColor:
                    isToday ? Colors.yellow.shade100 : null, // highlight

                leading: CircleAvatar(
                  backgroundColor: day.isHoliday
                      ? Colors.red.shade50
                      : Colors.blue.shade50,
                  child: Text(
                    day.nepaliDay,
                    style: TextStyle(
                      color: day.isHoliday ? Colors.red : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                title: Text(
                  (day.event != null && day.event!.isNotEmpty)
                      ? day.event!
                      : day.tithi,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),

                subtitle: Text(
                  day.englishFullDate,
                  style: const TextStyle(fontSize: 12),
                ),

                trailing: day.isHoliday
                    ? const Icon(Icons.circle, color: Colors.red, size: 10)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}