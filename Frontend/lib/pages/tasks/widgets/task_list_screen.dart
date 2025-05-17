import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_model.dart';
import '../../../providers/task_provider.dart';
import 'task_form.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  void _abrirFormulario(BuildContext context, [TaskModel? tarefa]) {
    final taskProvider = context.read<TaskProvider>();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TaskForm(
          tarefaEditavel: tarefa,
          onSubmit: (task) {
            if (tarefa == null) {
              taskProvider.adicionar(task);
            } else {
              taskProvider.remover(tarefa.id);
              taskProvider.adicionar(task);
            }
          },
          onDelete: (id) {
            taskProvider.remover(id);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tarefa excluída com sucesso!')),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tarefas = context.watch<TaskProvider>().tarefas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
      ),
      body: tarefas.isEmpty
          ? const Center(child: Text('Nenhuma tarefa cadastrada.'))
          : ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (_, index) {
                final tarefa = tarefas[index];
                final data = tarefa.dataFinalizacao;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(tarefa.titulo),
                    subtitle: Text(
                      '${data.day.toString().padLeft(2, '0')}/'
                      '${data.month.toString().padLeft(2, '0')}/'
                      '${data.year} - ${tarefa.descricao}',
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        final provider = context.read<TaskProvider>();
                        switch (value) {
                          case 'editar':
                            _abrirFormulario(context, tarefa);
                            break;
                          case 'concluir':
                            provider.concluir(tarefa.id);
                            break;
                          case 'alarme':
                            provider.alternarAlarme(tarefa.id);
                            break;
                          case 'remover':
                            provider.remover(tarefa.id);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'editar', child: Text('Editar')),
                        const PopupMenuItem(value: 'concluir', child: Text('Mudar Status')),
                        const PopupMenuItem(value: 'alarme', child: Text('Alternar Alarme')),
                        const PopupMenuItem(value: 'remover', child: Text('Remover')),
                      ],
                    ),
                    leading: Icon(
                      tarefa.alarmeAtivado ? Icons.alarm_on : Icons.alarm_off,
                      color: tarefa.alarmeAtivado ? Colors.red : Colors.grey,
                    ),
                    tileColor: _getStatusColor(tarefa.status),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(StatusTarefa status) {
    switch (status) {
      case StatusTarefa.pendente:
        return Colors.yellow[100]!;
      case StatusTarefa.emAndamento:
        return Colors.blue[100]!;
      case StatusTarefa.concluida:
        return Colors.green[100]!;
      case StatusTarefa.expirada:
        return Colors.grey[300]!;
    }
  }
}
