import 'package:flutter/material.dart';
import 'package:grupotdl/models/task_ofc_model.dart';
import 'package:grupotdl/services/task_ofc_service.dart';

class TaskOfcProvider extends ChangeNotifier {
  final TaskOfcService taskService;

  TaskOfcProvider(this.taskService);

  List<TaskOfcModel> _tarefas = [];
  bool _loading = false;
  String? _erro;

  List<TaskOfcModel> get tarefas => List.unmodifiable(_tarefas);
  bool get loading => _loading;
  String? get erro => _erro;

  Future<void> carregarTarefas() async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      _tarefas = await taskService.fetchOfficialTasks();
    } catch (e) {
      _erro = 'Erro ao carregar tarefas oficiais';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void removerTarefa(TaskOfcModel tarefa) {
    _tarefas.removeWhere((t) => t.titulo == tarefa.titulo && t.dataCriacao == tarefa.dataCriacao);
    notifyListeners();
  }

  void limpar() {
    _tarefas.clear();
    _loading = false;
    _erro = null;
    notifyListeners();
  }
}
