import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_model.dart';
import '../../../providers/task_provider.dart';
import '../../../utils/show_snackbar.dart';
import 'widgets/task_form.dart';
import 'widgets/task_section.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController _searchController = TextEditingController();
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

  void _adicionarTarefa(TaskModel novaTarefa) {
    Provider.of<TaskProvider>(context, listen: false).adicionar(novaTarefa);
  }

  void _alternarStatus(TaskModel tarefa) {
    Provider.of<TaskProvider>(context, listen: false).concluir(tarefa.id);
  }

  void _alternarAlarme(TaskModel tarefa) {
    Provider.of<TaskProvider>(context, listen: false).alternarAlarme(tarefa.id);

    final novaTarefa = Provider.of<TaskProvider>(context, listen: false)
        .tarefas
        .firstWhere((t) => t.id == tarefa.id);

    if (!novaTarefa.alarmeAtivado) {
      showSnackBar(context, 'Alarme desativado com sucesso', color: Colors.red);
    } else {
      showSnackBar(context, 'Alarme ativado com sucesso');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Consumer<TaskProvider>(
              builder: (context, provider, _) {
                final tarefas = provider.tarefas;
                final filtradas = tarefas.where((t) =>
                  t.titulo.toLowerCase().contains(_filter) ||
                  t.categoria.toLowerCase().contains(_filter)).toList();

                final pendentes = filtradas.where((t) => t.status == StatusTarefa.pendente).toList();
                final andamento = filtradas.where((t) => t.status == StatusTarefa.andamento).toList();
                final concluidas = filtradas.where((t) => t.status == StatusTarefa.concluida).toList();

                return ListView(
                  children: [
                    TaskSection(
                      title: '📌 Pendentes',
                      tasks: pendentes,
                      onToggle: _alternarStatus,
                      onAlarmeToggle: _alternarAlarme,
                    ),
                    TaskSection(
                      title: '⏳ Em Andamento',
                      tasks: andamento,
                      onToggle: _alternarStatus,
                      onAlarmeToggle: _alternarAlarme,
                    ),
                    TaskSection(
                      title: '✅ Concluídas',
                      tasks: concluidas,
                      onToggle: _alternarStatus,
                      onAlarmeToggle: _alternarAlarme,
                    ),
                  ],
                );
              },
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
            builder: (_) => TaskForm(onSubmit: _adicionarTarefa),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

