import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;

  const EventCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.event, color: Color.fromARGB(255, 33, 102, 6)),
        title: Text(title),
      ),
    );
  }
}
