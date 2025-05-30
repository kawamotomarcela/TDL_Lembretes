import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
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
      debugPrint('Erro ao carregar tarefas: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> enviarComprovacao({
    required String usuarioId,
    required String tarefaId,
    required String comprovacaoUrl,
  }) async {
    debugPrint('Enviando comprovação...');
    debugPrint('usuarioId: $usuarioId');
    debugPrint('tarefaId: $tarefaId');
    debugPrint('comprovacaoUrl: $comprovacaoUrl');

    if (tarefaId.isEmpty) {
      debugPrint(' tarefaId vazio');
      _erro = 'ID da tarefa inválido.';
      notifyListeners();
      return false;
    }

    try {
      await taskService.enviarComprovacao(
        usuarioId: usuarioId,
        tarefaId: tarefaId,
        comprovacaoUrl: comprovacaoUrl,
      );

      final index = _tarefas.indexWhere((t) => t.id == tarefaId);
      if (index != -1) {
        final atualizada = _tarefas[index].copyWith(comprovacaoUrl: comprovacaoUrl);
        _tarefas[index] = atualizada;
        debugPrint('Comprovação atualizada localmente');
        notifyListeners();
      } else {
        debugPrint('Tarefa não encontrada localmente');
      }

      return true;
    } catch (e, stack) {
      debugPrint(' Erro ao enviar comprovação: $e');
      debugPrintStack(stackTrace: stack);
      _erro = 'Erro ao enviar imagem de comprovação.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> concluirTarefa(String tarefaId) async {
    debugPrint('Tentando concluir tarefa: $tarefaId');

    if (tarefaId.isEmpty) {
      _erro = 'ID inválido.';
      notifyListeners();
      return false;
    }

    final tarefa = _tarefas.firstWhereOrNull((t) => t.id == tarefaId);

    if (tarefa == null) {
      _erro = 'Tarefa não encontrada.';
      notifyListeners();
      return false;
    }

    if (tarefa.comprovacaoUrl == null || tarefa.comprovacaoUrl!.isEmpty) {
      _erro = 'Você precisa enviar uma imagem antes de concluir.';
      notifyListeners();
      return false;
    }

    try {
      await taskService.concluirTarefa(tarefaId);
      _tarefas.removeWhere((t) => t.id == tarefaId);
      debugPrint('Tarefa concluída com sucesso.');
      notifyListeners();
      return true;
    } catch (e, stack) {
      debugPrint('Erro ao concluir tarefa: $e');
      debugPrintStack(stackTrace: stack);
      _erro = 'Erro ao concluir a tarefa.';
      notifyListeners();
      return false;
    }
  }

  void removerTarefa(TaskOfcModel tarefa) {
    _tarefas.removeWhere((t) => t.id == tarefa.id);
    notifyListeners();
  }

  void limpar() {
    _tarefas.clear();
    _loading = false;
    _erro = null;
    notifyListeners();
  }
}
