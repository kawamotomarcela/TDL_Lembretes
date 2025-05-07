import 'package:flutter/material.dart';
import '../../../models/task_model.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<TaskModel> tasks;
  final Function(TaskModel) onToggle;
  final Function(TaskModel) onAlarmeToggle;
  final Function(TaskModel) onEditar;
  final Function(String) onDelete; 

  const TaskSection({
    super.key,
    required this.title,
    required this.tasks,
    required this.onToggle,
    required this.onAlarmeToggle,
    required this.onEditar,
    required this.onDelete, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style:
                Theme.of(
                  context,
                ).textTheme.titleLarge, 
          ),
        ),

        ...tasks.map((tarefa) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(tarefa.titulo),
              subtitle: Text(
                '${tarefa.data.day.toString().padLeft(2, '0')}/${tarefa.data.month.toString().padLeft(2, '0')}/${tarefa.data.year} - ${tarefa.categoria}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  onDelete(tarefa.id); // Chamando a função de excluir
                },
              ),
              leading: Icon(
                tarefa.alarmeAtivado ? Icons.alarm_on : Icons.alarm_off,
                color: tarefa.alarmeAtivado ? Colors.red : Colors.grey,
              ),
              onTap: () => onEditar(tarefa),
            ),
          );
        })
      ],
    );
  }
}
