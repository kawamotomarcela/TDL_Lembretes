import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tarefas = [];

  List<TaskModel> get tarefas => List.unmodifiable(_tarefas);

  void adicionar(TaskModel tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  void concluir(String id) {
    final index = _tarefas.indexWhere((t) => t.id == id);
    if (index != -1) {
      final tarefa = _tarefas[index];
      _tarefas[index] = tarefa.copyWith(status: tarefa.proximoStatus());
      notifyListeners();
    }
  }

  void alternarAlarme(String id) {
    final index = _tarefas.indexWhere((t) => t.id == id);
    if (index != -1) {
      final tarefa = _tarefas[index];
      _tarefas[index] = tarefa.copyWith(alarmeAtivado: !tarefa.alarmeAtivado);
      notifyListeners();
    }
  }

  void remover(String id) {
    _tarefas.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}


