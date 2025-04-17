import 'package:flutter/material.dart';
import 'package:grupotdl/widgets/calendar_widget.dart';
import 'package:grupotdl/widgets/event_card.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2025, 1, 1): ['Ano Novo 🎉'],
    DateTime.utc(2025, 2, 14): ['Dia de São Valentim 💌'],
    DateTime.utc(2025, 4, 21): ['Tiradentes 🇧🇷'],
    DateTime.utc(2025, 6, 3): ['Corpus Christi – Feriado nacional 🇧🇷'],
    DateTime.utc(2025, 6, 12): ['Dia dos Namorados 💕'],
    DateTime.utc(2025, 6, 21): ['Início do Inverno ❄️'],
    DateTime.utc(2025, 9, 7): ['Independência do Brasil 🇧🇷'],
    DateTime.utc(2025, 12, 25): ['Natal 🎄'],
  };

  List<String> _getEventsForDay(DateTime day) {
    final date = DateTime.utc(day.year, day.month, day.day);
    return _events[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      body: Column(
        children: [
          CalendarWidget(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: events.isEmpty
                ? const Center(child: Text("Nenhum evento para este dia."))
                : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (_, index) {
                      return EventCard(title: events[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
