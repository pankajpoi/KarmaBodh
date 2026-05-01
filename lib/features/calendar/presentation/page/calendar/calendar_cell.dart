import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karmbodh/features/calendar/data/model/calendar_day.dart';

class CalendarCell extends StatelessWidget {
  final CalendarDay day;
  final bool isSelected;
  final VoidCallback onTap;

  const CalendarCell({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  bool get isToday {
    final now = DateTime.now();

    final englishDate = DateFormat('MMMM d, yyyy').parse(day.englishFullDate);

    return now.year == englishDate.year &&
        now.month == englishDate.month &&
        now.day == englishDate.day;
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey.shade300;
    Color backgroundColor = Colors.transparent;

    if (isSelected) {
      backgroundColor = Theme.of(context).colorScheme.primary;
      borderColor = Theme.of(context).colorScheme.primary;
    } else if (isToday) {
      backgroundColor = Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.12);
      borderColor = Theme.of(context).colorScheme.primary;
    }

    final Color nepaliTextColor = day.isHoliday ? Colors.red : Colors.black;

    final Color englishTextColor = isSelected
        ? Colors.white70
        : Colors.grey.shade600;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day.nepaliDay.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: nepaliTextColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                day.englishDay.toString(),
                style: TextStyle(fontSize: 11, color: englishTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
