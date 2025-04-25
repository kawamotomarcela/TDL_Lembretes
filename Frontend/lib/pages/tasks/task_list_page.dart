import 'package:flutter/material.dart';
import 'widgets/task_section.dart';
import 'widgets/task_form.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Apresentar relatório',
      'subtitle': 'Reunião com equipe',
      'status': 'pendente',
      'priority': 'Alta',
      'dateTime': '26/04/2025 às 14:00',
    },
    {
      'title': 'Enviar email de follow-up',
      'subtitle': 'Cliente XPTO',
      'status': 'concluída',
      'priority': 'Média',
      'dateTime': '25/04/2025 às 10:30',
    },
    {
      'title': 'Montar proposta comercial',
      'subtitle': 'Projeto ABC',
      'status': 'em andamento',
      'priority': 'Baixa',
      'dateTime': '28/04/2025 às 09:00',
    },
  ];

  String _filter = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _filter = _searchController.text.toLowerCase();
      });
    });
  }

  void _toggleTask(Map<String, dynamic> task) {
    setState(() {
      if (task['status'] == 'pendente') {
        task['status'] = 'em andamento';
      } else if (task['status'] == 'em andamento') {
        task['status'] = 'concluída';
      } else {
        task['status'] = 'pendente';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _tasks.where((task) {
      return task['title'].toLowerCase().contains(_filter) ||
          task['subtitle'].toLowerCase().contains(_filter);
    }).toList();

    final pending = filteredTasks.where((t) => t['status'] == 'pendente').toList();
    final inProgress = filteredTasks.where((t) => t['status'] == 'em andamento').toList();
    final completed = filteredTasks.where((t) => t['status'] == 'concluída').toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar tarefas...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                TaskSection(
                  title: '📌 Pendentes',
                  tasks: pending,
                  onToggle: _toggleTask,
                ),
                TaskSection(
                  title: '⏳ Em Andamento',
                  tasks: inProgress,
                  onToggle: _toggleTask,
                ),
                TaskSection(
                  title: '✅ Concluídas',
                  tasks: completed,
                  onToggle: _toggleTask,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab-task',
        backgroundColor: const Color.fromARGB(255, 38, 117, 187),
        tooltip: 'Nova Tarefa',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => TaskForm(
              onSubmit: (task) {
                task['status'] = 'pendente'; 
                setState(() => _tasks.add(task));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tarefa adicionada!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
