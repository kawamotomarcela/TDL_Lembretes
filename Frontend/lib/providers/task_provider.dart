import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tarefas = [];

  List<TaskModel> get tarefas => List.unmodifiable(_tarefas);

  void adicionar(TaskModel tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  void alternarStatus(String id) {
    final index = _tarefas.indexWhere((t) => t.id == id);
    if (index != -1) {
      final statusAtual = _tarefas[index].status;
      final proximoStatus = _proximoStatus(statusAtual);
      _tarefas[index] = _tarefas[index].copyWith(status: proximoStatus);
      notifyListeners();
    }
  }

  void remover(String id) {
    _tarefas.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  StatusTarefa _proximoStatus(StatusTarefa atual) {
    switch (atual) {
      case StatusTarefa.pendente:
        return StatusTarefa.andamento;
      case StatusTarefa.andamento:
        return StatusTarefa.concluida;
      case StatusTarefa.concluida:
        return StatusTarefa.pendente;
    }
  }
}
