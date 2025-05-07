import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  // Lista privada de tarefas (imutável externamente)
  final List<TaskModel> _tarefas = [];

  /// Retorna uma cópia imutável da lista de tarefas
  List<TaskModel> get tarefas => List.unmodifiable(_tarefas);

  /// Adiciona uma nova tarefa à lista
  void adicionar(TaskModel tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  /// Atualiza uma tarefa existente com base no ID
  void editar(TaskModel tarefaAtualizada) {
    final index = _tarefas.indexWhere((t) => t.id == tarefaAtualizada.id);
    if (index != -1) {
      _tarefas[index] = tarefaAtualizada;
      notifyListeners();
    }
  }

  /// Alterna o status da tarefa (Pendente -> Andamento -> Concluída -> Pendente)
  void concluir(String id) {
    final index = _tarefas.indexWhere((t) => t.id == id);
    if (index != -1) {
      final tarefa = _tarefas[index];
      _tarefas[index] = tarefa.copyWith(status: tarefa.proximoStatus());
      notifyListeners();
    }
  }

  /// Alterna a ativação do alarme de uma tarefa
  void alternarAlarme(String id) {
    final index = _tarefas.indexWhere((t) => t.id == id);
    if (index != -1) {
      final tarefa = _tarefas[index];
      _tarefas[index] = tarefa.copyWith(alarmeAtivado: !tarefa.alarmeAtivado);
      notifyListeners();
    }
  }

  /// Remove uma tarefa pelo ID
  void remover(String id) {
    _tarefas.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  /// Remove todas as tarefas (opcional para testes/reset)
  void limpar() {
    _tarefas.clear();
    notifyListeners();
  }
}
