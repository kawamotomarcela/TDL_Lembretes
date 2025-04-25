import 'package:flutter/material.dart';
import 'package:grupotdl/pages/tasks/widgets/task_card.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> tasks;
  final Function(Map<String, dynamic>) onToggle;

  const TaskSection({
    super.key,
    required this.title,
    required this.tasks,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...tasks.map((tarefa) => TaskCard(
              title: tarefa['title'],
              subtitle: tarefa['subtitle'],
              status: tarefa['status'],
              dateTime: tarefa['dateTime'],
              priority: tarefa['priority'],
              onChanged: () => onToggle(tarefa),
            )),
      ],
    );
  }
}
