import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService taskService;

  TaskProvider({required this.taskService});

  List<TaskModel> _tarefas = [];

  List<TaskModel> get tarefas => List.unmodifiable(_tarefas);

  Future<void> carregarTarefas() async {
    _tarefas = await taskService.fetchTasks();
    notifyListeners();
  }

  Future<void> adicionar(TaskModel tarefa) async {
    final novaTarefa = await taskService.createTask(tarefa);
    if (novaTarefa != null) {
      _tarefas.add(novaTarefa);
      notifyListeners();
    }
  }

  Future<void> editar(TaskModel tarefaAtualizada) async {
    final sucesso = await taskService.updateTask(tarefaAtualizada);
    if (sucesso) {
      final index = _tarefas.indexWhere((t) => t.id == tarefaAtualizada.id);
      if (index != -1) {
        _tarefas[index] = tarefaAtualizada;
        notifyListeners();
      }
    }
  }

  Future<void> concluir(String id) async {
    final sucesso = await taskService.toggleStatus(id);
    if (sucesso) {
      final index = _tarefas.indexWhere((t) => t.id == id);
      if (index != -1) {
        final tarefa = _tarefas[index];
        _tarefas[index] = tarefa.copyWith(status: tarefa.proximoStatus());
        notifyListeners();
      }
    }
  }

  Future<void> alternarAlarme(String id) async {
    final index = _tarefas.indexWhere((t) => t.id == id);
    if (index != -1) {
      final tarefa = _tarefas[index];
      final atualizada = tarefa.copyWith(alarmeAtivado: !tarefa.alarmeAtivado);
      final sucesso = await taskService.updateTask(atualizada);
      if (sucesso) {
        _tarefas[index] = atualizada;
        notifyListeners();
      }
    }
  }

  Future<void> remover(String id) async {
    final sucesso = await taskService.deleteTask(id);
    if (sucesso) {
      _tarefas.removeWhere((t) => t.id == id);
      notifyListeners();
    }
  }

  void limpar() {
    _tarefas.clear();
    notifyListeners();
  }
}
