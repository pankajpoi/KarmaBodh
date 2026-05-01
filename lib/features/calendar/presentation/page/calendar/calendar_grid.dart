import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karmbodh/features/calendar/data/model/calendar_day.dart';

import '../../../utils/constants.dart';
import 'calendar_cell.dart';

class CalendarGrid extends StatelessWidget {
  final List<CalendarDay> days;
  final CalendarDay? selectedDay;
  final ValueChanged<CalendarDay> onDaySelected;

  const CalendarGrid({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  int _calculateStartOffset() {
    final date = DateFormat('MMMM d, yyyy').parse(days.first.englishFullDate);

    // Dart weekday: Mon=1 ... Sun=7
    // We want: Sun=0 ... Sat=6
    return date.weekday % 7; // Sun=0 ... Sat=6
  }

  @override
  Widget build(BuildContext context) {
    final int startOffset = _calculateStartOffset();
    final int totalCells = days.length + startOffset;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: nepaliWeekdays.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),

        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: totalCells,
            itemBuilder: (context, index) {
              if (index < startOffset) {
                return const EmptyCalendarCell();
              }

              final dayIndex = index - startOffset;
              final day = days[dayIndex];

              return CalendarCell(
                day: day,
                isSelected: selectedDay == day,
                onTap: () => onDaySelected(day),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EmptyCalendarCell extends StatelessWidget {
  const EmptyCalendarCell({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
