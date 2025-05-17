import 'dart:developer';
import 'package:grupotdl/models/task_model.dart';
import 'package:grupotdl/api/api_client.dart';

class TaskService {
  final ApiClient api;

  TaskService(this.api);

  Future<List<TaskModel>> fetchTasks() async {
    try {
      final response = await api.get('/CriarTarefaPersonalizada');
      if (response is List) {
        return response.map((json) => TaskModel.fromMap(json)).toList();
      }
      return [];
    } catch (e, stack) {
      log('Erro ao buscar tarefas', error: e, stackTrace: stack);
      return [];
    }
  }

Future<TaskModel?> createTask(TaskModel task) async {
  try {
    String capitalize(String value) =>
        value[0].toUpperCase() + value.substring(1).toLowerCase();

    final payload = {
      'Id': task.id,
      'Titulo': task.titulo,
      'Descricao': task.descricao,
      'DataCriacao': task.dataCriacao.toIso8601String(),
      'DataFinalizacao': task.dataFinalizacao.toIso8601String(),
      'Status': capitalize(task.status.name),
      'Prioridade': capitalize(task.prioridade.name),
      'AlarmeAtivado': task.alarmeAtivado,
    };


    final response = await api.post('/CriarTarefaPersonalizada', payload);

    return TaskModel.fromMap(response);
  } catch (e, stack) {
    log('Erro ao criar tarefa', error: e, stackTrace: stack);
    return null;
  }
}


  Future<bool> updateTask(TaskModel task) async {
    try {
      await api.put(
        '/CriarTarefaPersonalizada/${task.id}',
        task.toMapForDto(),
      );
      return true;
    } catch (e, stack) {
      log('Erro ao atualizar tarefa', error: e, stackTrace: stack);
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      await api.delete('/CriarTarefaPersonalizada/$id');
      return true;
    } catch (e, stack) {
      log('Erro ao excluir tarefa', error: e, stackTrace: stack);
      return false;
    }
  }

  Future<bool> toggleStatus(String id) async {
    try {
      await api.put('/CriarTarefaPersonalizada/$id/toggle', {});
      return true;
    } catch (e, stack) {
      log('Erro ao alternar status da tarefa', error: e, stackTrace: stack);
      return false;
    }
  }
}
