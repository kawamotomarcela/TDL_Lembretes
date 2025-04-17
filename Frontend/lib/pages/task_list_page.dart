import 'package:flutter/material.dart';
import 'package:grupotdl/widgets/task_section.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _tarefas = [
    {
      'title': 'Enviar relatório para o Frank',
      'subtitle': 'Trabalho',
      'done': false,
      'dateTime': '23 de Outubro, 10:00',
    },
    {
      'title': 'Revisar assinaturas',
      'subtitle': 'Casa',
      'done': false,
      'dateTime': 'Hoje, 14:30',
    },
    {
      'title': 'Comprar leite',
      'subtitle': 'Mercado',
      'done': false,
      'dateTime': 'Amanhã, 08:00',
    },
    {
      'title': 'Re: Alpine Ski House',
      'subtitle': 'Mensagem',
      'done': true,
      'dateTime': 'Ontem, 17:00',
    },
  ];

  String _filtro = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _filtro = _searchController.text.toLowerCase();
      });
    });
  }

  void _toggleTarefa(Map<String, dynamic> tarefa) {
    setState(() {
      tarefa['done'] = !tarefa['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final tarefasFiltradas = _tarefas.where((tarefa) {
      return tarefa['title'].toLowerCase().contains(_filtro) ||
          tarefa['subtitle'].toLowerCase().contains(_filtro);
    }).toList();

    final pendentes = tarefasFiltradas.where((t) => !t['done']).toList();
    final concluidas = tarefasFiltradas.where((t) => t['done']).toList();

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
                  tasks: pendentes,
                  onToggle: _toggleTarefa,
                ),
                TaskSection(
                  title: '✅ Concluídas',
                  tasks: concluidas,
                  onToggle: _toggleTarefa,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
