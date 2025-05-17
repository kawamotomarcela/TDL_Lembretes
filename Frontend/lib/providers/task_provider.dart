import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService taskService;

  TaskProvider({required this.taskService});

  List<TaskModel> _tarefas = [];
  bool _carregando = false;
  String? _erro;

  List<TaskModel> get tarefas => List.unmodifiable(_tarefas);
  bool get carregando => _carregando;
  String? get erro => _erro;

  Future<void> carregarTarefas() async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _tarefas = await taskService.fetchTasks();
    } catch (e) {
      _erro = 'Erro ao carregar tarefas';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> adicionar(TaskModel tarefa) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      final novaTarefa = await taskService.createTask(tarefa);
      if (novaTarefa != null) {
        await carregarTarefas(); 
      } else {
        _erro = 'Erro ao adicionar tarefa';
      }
    } catch (e) {
      _erro = 'Erro ao adicionar tarefa';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> editar(TaskModel tarefaAtualizada) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      final sucesso = await taskService.updateTask(tarefaAtualizada);
      if (sucesso) {
        final index = _tarefas.indexWhere((t) => t.id == tarefaAtualizada.id);
        if (index != -1) {
          _tarefas[index] = tarefaAtualizada;
        }
      } else {
        _erro = 'Erro ao editar tarefa';
      }
    } catch (e) {
      _erro = 'Erro ao editar tarefa';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> concluir(String id) async {
    _erro = null;
    try {
      final sucesso = await taskService.toggleStatus(id);
      if (sucesso) {
        final index = _tarefas.indexWhere((t) => t.id == id);
        if (index != -1) {
          final tarefa = _tarefas[index];
          _tarefas[index] = tarefa.copyWith(status: tarefa.proximoStatus());
          notifyListeners();
        }
      } else {
        _erro = 'Erro ao concluir tarefa';
        notifyListeners();
      }
    } catch (e) {
      _erro = 'Erro ao concluir tarefa';
      notifyListeners();
    }
  }

  Future<void> alternarAlarme(String id) async {
    _erro = null;
    try {
      final index = _tarefas.indexWhere((t) => t.id == id);
      if (index != -1) {
        final tarefa = _tarefas[index];
        final atualizada = tarefa.copyWith(alarmeAtivado: !tarefa.alarmeAtivado);
        final sucesso = await taskService.updateTask(atualizada);
        if (sucesso) {
          _tarefas[index] = atualizada;
          notifyListeners();
        } else {
          _erro = 'Erro ao atualizar alarme';
          notifyListeners();
        }
      }
    } catch (e) {
      _erro = 'Erro ao alternar alarme';
      notifyListeners();
    }
  }

  Future<void> remover(String id) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      final sucesso = await taskService.deleteTask(id);
      if (sucesso) {
        _tarefas.removeWhere((t) => t.id == id);
      } else {
        _erro = 'Erro ao remover tarefa';
      }
    } catch (e) {
      _erro = 'Erro ao remover tarefa';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  void limpar() {
    _tarefas.clear();
    notifyListeners();
  }
}

