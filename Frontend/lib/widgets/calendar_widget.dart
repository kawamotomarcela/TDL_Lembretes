import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime, DateTime) onDaySelected;
  final List<dynamic> Function(DateTime)? eventLoader;

  const CalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    this.eventLoader,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'pt_BR',
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2025, 12, 31),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,
      eventLoader: eventLoader,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(color: Colors.indigo, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: 18),
      ),
    );
  }
}
