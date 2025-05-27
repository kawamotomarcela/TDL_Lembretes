import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import 'task_card.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<TaskModel> tasks;
  final Function(TaskModel) onToggle;
  final Function(TaskModel)? onAlarmeToggle;
  final Function(TaskModel)? onEditar;

  const TaskSection({
    super.key,
    required this.title,
    required this.tasks,
    required this.onToggle,
    this.onAlarmeToggle,
    this.onEditar,
  });

  String _statusToText(StatusTarefa status) {
    switch (status) {
      case StatusTarefa.emAndamento:
        return 'em andamento';
      case StatusTarefa.concluida:
        return 'concluída';
      case StatusTarefa.expirada:
        return 'expirada';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')} '
        'às ${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
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
              subtitle: task.descricao,
              status: _statusToText(task.status),
              dateTime: _formatDate(task.dataFinalizacao),
              priority: task.prioridade.index,
              onChanged: () => onToggle(task),
              alarmeAtivado: task.alarmeAtivado,
              onAlarmeChanged: (bool newValue) {
                if (onAlarmeToggle != null) {
                  onAlarmeToggle!(task);
                }
              },
              onTap: () {
                if (onEditar != null) {
                  onEditar!(task);
                }
              },
            )),
      ],
    );
  }
}
