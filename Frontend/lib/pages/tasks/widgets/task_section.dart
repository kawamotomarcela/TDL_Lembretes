import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import 'task_card.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<TaskModel> tasks;
  final Function(TaskModel) onToggle;

  const TaskSection({
    super.key,
    required this.title,
    required this.tasks,
    required this.onToggle,
  });

  String _statusToText(StatusTarefa status) {
    switch (status) {
      case StatusTarefa.pendente:
        return 'pendente';
      case StatusTarefa.andamento:
        return 'em andamento';
      case StatusTarefa.concluida:
        return 'concluída';
    }
  }

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
        ...tasks.map((task) => TaskCard(
              title: task.titulo,
              subtitle: task.categoria,
              status: _statusToText(task.status),
              dateTime:
                  '${task.data.day.toString().padLeft(2, '0')}/${task.data.month.toString().padLeft(2, '0')} às ${task.data.hour.toString().padLeft(2, '0')}:${task.data.minute.toString().padLeft(2, '0')}',
              priority: task.prioridade,
              onChanged: () => onToggle(task),
            )),
      ],
    );
  }
}

