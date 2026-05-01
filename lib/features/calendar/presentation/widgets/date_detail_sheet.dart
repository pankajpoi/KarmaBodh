import 'package:flutter/material.dart';
import 'package:karmbodh/features/calendar/data/model/calendar_day.dart';


class DateDetailSheet extends StatelessWidget {
  final CalendarDay day;

  const DateDetailSheet({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'नेपाली मिति: ${day.nepaliDay}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'English Date: ${day.englishFullDate.toString().split(' ')[0]}', //error might occur here
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'Tithi: ${day.tithi}',
            style: const TextStyle(fontSize: 14),
          ),
          if (day.event != null) ...[
            const SizedBox(height: 12),
            Text(
              'Event: ${day.event}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
